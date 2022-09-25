# AWS Sandbox EC2 Instance using Terraform

Terraform template to create a AWS Virtual Private Cloud running a single EC2
instance.

## Requirements

This template requires that AWS CLI is correctly configured on the local machine, in particular the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are correctly set. For further information see this [link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs).

In addition, you must also have a key pair associated with your AWS CLI configuration. To check if a key exists use the command

`aws ec2 describe-key-pairs`

This outputs a list of keys that are known to the CLI. You need to know two things about these keys:

* Of all the output fields, in `describe-key-pairs`, the field `KeyName` is
required.
* The corresponding private key file for that key pair.

## Starting the VPC and Connecting to the EC2 Instance

You must specify the name of the AWS key that you will use to ssh into the EC2 instance that is created. To start the VPC run

`terraform apply -var-file=terraform.tfvars -var 'key_name=MyAwsKey`

Where `MyAwsKey` is the name of the key used to authenticate ssh access to the EC2 instance. **This is not the same as the private key file itself.**

In order to connect to the EC2 instance run the command

`bash ./scripts/ec2_connect.sh PathToPrivateKey`

Where _PathToPrivateKey_ is the path to the private key file. 

If you are running the script for the first time, then a new instance takes about 1 minute to become available. Re-run the script again after 1 minute to connect to the recently created ec2 instance.

## Terminating the Instance

You can terminate all instances in the VPC using the script

`bash ./scripts/ec2_stop_all.sh`

Instances will also be terminated if they receive no network traffic for approximately 2 hours.
