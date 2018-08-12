#!/bin/bash

cd `dirname $0`
source conoha-ctl.sh

DOMAIN_WITH_TRAILINGDOT=$CERTBOT_DOMAIN'.'
RECORD_NAME_WITH_TRAILINGDOT='_acme-challenge.'$DOMAIN_WITH_TRAILINGDOT

DOMAIN_ID=`get_domain_id`
RECORD_ID=`get_record_id`
delete_record
