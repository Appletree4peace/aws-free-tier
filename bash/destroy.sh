#!/usr/bin/env bash
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $BASEDIR/inc.sh

cd $BASEDIR/../terraform

header "Destroying ..."
terraform destroy --auto-approve
