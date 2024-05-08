#!/bin/bash
##############################################################################
# Module Practice Assessment
# This assignment requires you to destroy the Cloud assets you created
# Remember to set you default output to text in the aws config command
##############################################################################

echo "Beginning destroy script for module-02..."

# Collect Instance IDs
# https://stackoverflow.com/questions/31744316/aws-cli-filter-or-logic
# INSTANCEIDS=$(aws ec2 describe-instances --output=text --query 'Reservations[*].Instances[*].InstanceID' --filter "Name=instance-state-name,Values=running,pending")

# echo $INSTANCEIDS
INSTANCEIDS=$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].InstanceId" --output text)
echo "Instance IDs to terminate: $INSTANCEIDS"

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/wait/instance-terminated.html
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/terminate-instances.html

if [ "$INSTANCEIDS" != "" ]
  then
    aws ec2 terminate-instances --instance-ids $INSTANCEIDS
    echo "Waiting for all instances report state as TERMINATED..."
    aws ec2 wait instance-terminated --instance-ids $INSTANCEIDS
    echo "Finished destroying instances..."
  else
    echo 'There are no running values in $INSTANCEIDS to be terminated...'
fi 
