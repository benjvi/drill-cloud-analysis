#!/bin/sh
set -e 

# need to be root to run drill, and access files used here
# sudo wipes out path so we append to it here
PATH="$PATH:/opt/apache-drill-1.13.0/bin"

# also setup creds
export AWS_DEFAULT_REGION=eu-west-1
export AWS_PROFILE=auditor

# fetch all the data (into separate files)
# nb aws cli does pagination in the background
aws ec2 describe-instances | jq -r ".Reservations[].Instances" > /tmp/instances.json
aws ec2 describe-subnets | jq -r ".Subnets" > /tmp/subnets.json

# run the query - defined in drill-query.sql
# would be quicker if we don't start the drill server every time
drill-embedded -f query.sql --silent=true --showHeader=false --outputformat=csv 2> /tmp/drill-query.log > /tmp/query-results.csv

# parse query results and perform the desired action
instance_id=$(cat /tmp/query-results.csv | csvtool drop 1 - | csvtool col 1 - | tr -d "'")
echo $instance_id | xargs aws ec2 describe-instance-status --region eu-west-1 --instance-id
