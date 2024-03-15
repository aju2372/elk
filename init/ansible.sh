#!/bin/bash

sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y

sudo tee /etc/ansible/hosts << EOF
localhost ansible_connection=local
ansible_python_interpreter="/usr/bin/env python"
EOF

ansible localhost -m ping

ansible all -i "localhost," -c local -m shell -a 'echo hello world'
