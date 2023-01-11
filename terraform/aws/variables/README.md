## Multiple ways we can assign variables

* Environemnt Variables
* Command Line args
* From a file
* Defaults

### * terraform plan will show the assignment

### * terraform plan -var="instancetype=t2.small"

### * If we dont define any default, if we dont give anything as commandline arg,  it explicitly asks to enter value.

### * terraform.tfvars ----> This file can be used to give values of variables. This is stanard name

### * If we want to use custom Name for tfvars say custom.tfvars, then we need to explicitly give it like  terraform plan -var-file="custom.tfvars"

### * IF we want to use Linux Environment variable,  export TF_VAR_instancetype="t2.medium"

