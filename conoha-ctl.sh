#!/bin/bash

cd `dirname $0`

if [ -e vars  ]; then
  source vars
else
  echo vars file does not exist!
  exit 1
fi

function get_token(){
  # params: OS_USERNAME, OS_PASSWORD, OS_TENANT_ID
  curl -sS -X POST -H "Accept: application/json" \
       -d '{ "auth": { "passwordCredentials": { "username": "'$OS_USERNAME'", "password": "'$OS_PASSWORD'" }, "tenantId": "'$OS_TENANT_ID'" } }' \
       https://identity.tyo1.conoha.io/v2.0/tokens \
    | jq -r ".access.token.id"
}

function get_domain_id(){
  # params: TOKEN, DOMAIN_WITH_TRAILINGDOT
  curl -sS -X GET \
       -H "Accept: application/json" \
       -H "X-Auth-Token: $TOKEN" \
       -H "Content-Type: application/json" \
       https://dns-service.tyo1.conoha.io/v1/domains \
    | jq -r '.domains[] | select(.name == "'$DOMAIN_WITH_TRAILINGDOT'") | .id'
}

function get_record_id(){
  # params: TOKEN, DOMAIN_ID, RECORD_NAME_WITH_TRAILINGDOT
  curl -sS -X GET \
       -H "Accept: application/json" \
       -H "X-Auth-Token: $TOKEN" \
       -H "Content-Type: application/json" \
       https://dns-service.tyo1.conoha.io/v1/domains/$DOMAIN_ID/records \
    | jq -r '.records[] | select(.name == "'$RECORD_NAME_WITH_TRAILINGDOT'") | .id'
    # | jq -r '.records[]'
}

function update_record(){
  # params: TOKEN, DOMAIN_ID, RECORD_ID, RECORED_NAME_WITH_TRAILINGDOT, TYPE, DATA
  curl -sS -X PUT \
       -H "Accept: application/json" \
       -H "X-Auth-Token: $TOKEN" \
       -H "Content-Type: application/json" \
       -d '{"name": "'$RECORD_NAME_WITH_TRAILINGDOT'", "type": "'$TYPE'", "data": "'$DATA'"}' \
       https://dns-service.tyo1.conoha.io/v1/domains/$DOMAIN_ID/records/$RECORD_ID \
    | jq .
}

function delete_record(){
  # params: TOKEN, DOMAIN_ID, RECORD_ID
  curl -sS -X DELETE \
       -H "Accept: application/json" \
       -H "X-Auth-Token: $TOKEN" \
       -H "Content-Type: application/json" \
       https://dns-service.tyo1.conoha.io/v1/domains/$DOMAIN_ID/records/$RECORD_ID
}

function create_record(){
  # params: TOKEN, DOMAIN_ID, RECORED_NAME_WITH_TRAILINGDOT, TYPE, DATA
  curl -sS -X POST \
       -H "Accept: application/json" \
       -H "X-Auth-Token: $TOKEN" \
       -H "Content-Type: application/json" \
       -d '{"name": "'$RECORD_NAME_WITH_TRAILINGDOT'", "type": "'$TYPE'", "data": "'$DATA'"}' \
       https://dns-service.tyo1.conoha.io/v1/domains/$DOMAIN_ID/records \
    | jq .
}
TOKEN=`get_token`
