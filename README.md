<!-- 
TODO: Note that backend is created locally.
TODO: emphasize that we create a launch config, not an instance.
 -->

# AWS Sandbox EC2 Instance using Terraform

Terraform template to create a AWS Virtual Private Cloud running a single EC2
instance.

# Requirements

This template requires that AWS CLI is correctly configured on the local
machine, in particular the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
are correctly set. For further information see this 
[link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs).

In addition, you must also have a key pair associated with your AWS CLI 
configuration. To check if a key exists use the command

`aws ec2 describe-key-pairs`

This outputs a list of keys that are known to the CLI. You need to know two
things about these keys:

* Of all the output fields, in `describe-key-pairs`, the field `KeyName` is
required.
* The corresponding private key file for that key pair.

# Starting the VPC and Connecting to the EC2 Instance

You must specify the name of the AWS key that you will use to SSH into the
EC2 instance that is created. To start the VPC run

`terraform apply -var key_name=KeyName`

Where _KeyName_ is the name of the key used to authenticate SSH access to
the EC2 instance. **This is not the same as the private key file itself.**

In order to connect to the EC2 instance run the command

`bash ./scripts/ec2_connect.sh PathToPrivateKey`

Where _PathToPrivateKey_ is the path to the private key file.

If you are running the script for the first time, or approximately 20 minutes
has passed since the instance received network traffic, then a new EC2 instance
will be created and the script will exit. A new instance takes about 1 minute
to become available. Rerunning the script again after 1 minute should connect
you to the EC2 instance.

# Infrastructure in Detail

Below is a detailed summary of the infrastructure that this Terraform template
creates.
