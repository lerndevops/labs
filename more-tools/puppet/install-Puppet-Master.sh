#!/bin/bash

cd /tmp ; sudo curl -O https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
cd /tmp ; sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt-get update
sudo apt-get install -y puppetserver

sudo systemctl start puppetserver
sudo systemctl status puppetserver
# sudo systemctl enable puppetserver  # for enabling boot time start time
