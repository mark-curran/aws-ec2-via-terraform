#!/bin/bash
# Connect to the EC2 instance if it exists, otherwise start a new EC2
# instance.
# Args:
#   1:  Path to the private key file corresponding to the key used to create
#       the EC2 instance.

main () {
    
    local instance_id=$(\
        aws autoscaling describe-auto-scaling-instances \
        | grep -i instanceid \
        | cut -d ':' -f 2 \
        | tr -d ' '\"\,
    )
    local namespace=$( echo "$(terraform output namespace | tr -d \")")

    # Check if instance is running.
    if [[ "$instance_id" = "" ]]; then
        echo "No instance_id found, attempting to start an instance."
        echo "Please wait about 30-60 seconds for the instances to start."
        # Command to start an instance.
        aws autoscaling execute-policy \
        --auto-scaling-group-name $namespace-asg \
        --policy-name $namespace-autoscaling-policy-single-instance
    else
        echo "An instance is running with id: $instance_id"
        echo "Getting instance public dns name."
        local public_dns_name=$(\
            echo $(\
                aws ec2 describe-instances --instance-ids=$instance_id \
                | grep PublicDnsName \
                | head -1 \
                | cut -d ':' -f 2 \
                | tr -d ' '\"\,
            )
        )

        echo "The public dns name is $public_dns_name"
        echo "Connecting to instance."
        ssh -i $1 ubuntu@$public_dns_name
    fi

}

main "$1"
