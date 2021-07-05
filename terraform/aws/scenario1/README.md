## Set up the entire infrastructure using a Terraform Configuration.

#### Following resources need to be deployed:
```
    1. Network Setup
        a. Create a VPC
        b. Create an internet gateway
        c. Create a custom Route Table
        d. Create a Subnet
        e. Associate the Subnet with the Route Table

    2. Security Group Setup
        a. Create a new security group
        b. Enable ports 22, 80, 443

    3. Network Interface Setup
        a. Create a new network interface with IP in the previously created subnet
        b. Create an elastic IP associated with the network interface
        
    4. Ec2 instance setup
        a. Create a new ubuntu ec2 instance and attach the network interface to it
        b. Install httpd server on it
```