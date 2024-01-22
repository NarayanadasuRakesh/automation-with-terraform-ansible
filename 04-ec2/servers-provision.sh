#!/bin/bash
#
# Script Name: servers-provision.sh
# Author: Narayanadasu Rakesh
# Version: 1.0
# Date: January 22, 2024
#
# Description: This script helps to run Ansible playbooks on an Ansible controller.
#
# Usage: user_data = file("servers-provision.sh")
#
#START#
DIR="automation-with-ansible-roles"
components=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")

echo "Installing ansible..."
yum install ansible -y
cd /tmp
echo "Change Directory SUCCESS"
if [ -d $DIR ]
then
    rm -r "$DIR"
    echo "Deleted $DIR"
fi
echo "Cloning git repository"
git clone https://github.com/NarayanadasuRakesh/automation-with-ansible-roles.git    

cd automation-with-ansible-roles

for server in "${components[@]}"
do
    echo "Installing $server"
    ansible-playbook -e component=$server main.yml
done

#END#