#!/bin/bash
set -euxfo pipefail

PYTHONUNBUFFERED=1 
ANSIBLE_FORCE_COLOR=true 
ANSIBLE_HOST_KEY_CHECKING=false 
ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null \
 -o IdentitiesOnly=yes \
 -i ~/.vagrant.d/insecure_private_key \ 
 -o ForwardAgent=yes \
 -o UserKnownHostsFile=/dev/null \
 -o StrictHostKeyChecking=false \
 -o ControlMaster=auto \
 -o ControlPersist=60s'
 
ansible-playbook --connection=ssh \
    --timeout=30 \
    --extra-vars="ansible_ssh_user='vagrant'" \
    --limit="base" \
    --inventory-file=dev \
    --extra-vars="{\"ansible_connection\":\"ssh\",\"ansible_ssh_args\":\"-o ForwardAgent=yes\"}" \
    -v base.yml
