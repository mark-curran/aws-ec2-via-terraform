#!/bin/bash

# This script stops all ec2 instances in the VPC.

stop_all_instances() {

    local namespace=$( echo "$(terraform output namespace | tr -d \")")
    
    echo "Executing autoscaling-policy-stop-all"

    aws autoscaling execute-policy \
    --auto-scaling-group-name $namespace-asg \
    --policy-name $namespace-autoscaling-policy-stop-all
}

stop_all_instances
