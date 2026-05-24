#!/bin/bash

#aws ec2 describe-instances  --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --filters Name=instance-state-name,Values=running --output text
aws ec2 describe-instances  --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value}" --filters Name=instance-state-name,Values=running --output text
