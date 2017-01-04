#!/bin/bash

usage="$(basename "$0") [-h] [-s n] -- panda nano-services deployment to base virtual host

where:
    -h  show this help text
    -s  service to deploy (default: all). 
        Available params are:
            -s static-panda - for static-panda service deployment 
            -s counting-panda  - for counting-panda service deployment
            -s all - for both services.
        The latest verstion will be pulled from the GIT repository and deployed onto base virtual host.
        After the deployment is finished the service will be re-started.
        "

SERVICE=all
while getopts ':hs:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    s) SERVICE=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

AVAILABLE_SERVICES=("all" "static-panda" "counting-panda")
CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GIT_REPO=https://github.com/victorziv/bigpandaio-devops-exercise.git
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
 
update_latest_version() {
    cd $CURDIR
    git checkout master
    git checkout .
    git pull -X theirs origin master
}

validate_input() {
    available=0
    for available_service in "${AVAILABLE_SERVICES[@]}"
    do
        if [ "${available_service}" == "${SERVICE}" ];then
            available=1
        fi
    done

    if [ "${available}" -eq 0 ];then
        echo "ERROR: unknown service ${SERVICE} - aborting"
        exit 1
    fi
}

deploy_services() {

    ansible-playbook --connection=ssh \
        --timeout=30 \
        --extra-vars="ansible_ssh_user='vagrant'" \
        --limit="base" \
        --inventory-file=dev \
        --extra-vars="{\"ansible_connection\":\"ssh\",\"ansible_ssh_args\":\"-o ForwardAgent=yes\"}" \
        -v ${SERVICE}.yml
}

main() {
    validate_input
    update_latest_version
    deploy_services
}

main "$@"
