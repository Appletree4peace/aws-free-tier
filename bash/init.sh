#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $BASEDIR/inc.sh

cd $BASEDIR/../terraform
terraform init

header "Switching to tf workspace ..."
select_ws $AWS_ACCOUNT
log "switched to ws $AWS_ACCOUNT"
