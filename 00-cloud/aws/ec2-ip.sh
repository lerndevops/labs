#!/bin/bash
# print Private IP
echo "PrivateIP: `curl -s http://169.254.169.254/latest/meta-data/local-ipv4`"
echo " "

# print Public IP
echo "PublicIP: `curl -s http://169.254.169.254/latest/meta-data/public-ipv4`"
