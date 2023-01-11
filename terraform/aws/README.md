## AWS Setup for Terraform

> prerequisites 

* Need an AWS Account ( can be free tier )

* Create an IAM Admin User 

## AWS Setup creds (access key & Secret Key)

> `there are multiple ways we can provide the credentials with which we get authenticated to AWS APIs using the IAM User`

* ***provide in main terrform configuration file along with resource configuration***
```
ex: 
        provider "aws" {
            region  = "us-east-2"
            access_key  =  "accesskey"
            secret_key  =  "secretkey"
        }

        resource "aws_instance" "test" {
            ami = "ami-00399ec92321828f5"
            instance_type = "t2.micro"

            tags = {
                Name  =  "test"
                type  = "appserver"
            }
        }
```
* ***provide in a centralized file in a terraform module, ex: create provider.tf in root module & add the details in it***
```
ex: 
    touch provider.tf   ## in your terraform working directory 

        provider "aws" {
            region  = "us-east-2"
            access_key  =  "accesskey"
            secret_key  =  "secretkey"
        }
```
* ***register as environment variables on terraform server***
```
    export AWS_ACCESS_KEY_ID="accesskey"
    export AWS_SECRET_ACCESS_KEY="secretkey"
    export AWS_DEFAULT_REGION="us-east-2"
```
