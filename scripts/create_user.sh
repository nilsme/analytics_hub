#!/bin/bash

function usage {
  echo "Usage: $0 [ -i UID ] [ -u USER ] [ -p PASSWORD] [ -h HELP ]" 1>&2
}

exit_abnormal() {
  usage
  exit 1
}

while getopts i:u:p:h option; do
  case "${option}" in
    i)NEW_USER_ID=${OPTARG};;
    u)NEW_USER=${OPTARG};;
    p)NEW_PASSWORD=${OPTARG};;
    h | *)
      usage
      exit 0
      ;;
  esac
done

# Create user for RStudio
echo "RStudio: Create user ${NEW_USER}"
docker exec hub_docker_rstudio useradd \
  --uid "${NEW_USER_ID}" \
  --create-home \
  "${NEW_USER}"

echo "RStudio: Set password for user ${NEW_USER}"
echo -e "$NEW_PASSWORD\n$NEW_PASSWORD" | \
  docker exec -i hub_docker_rstudio \
  sh -c "echo \"${NEW_USER}:${NEW_PASSWORD}\" | sudo chpasswd"

# Create user for JupyterHub
echo "JupyterHub: Create user ${NEW_USER}"
docker exec hub_docker_jupyterhub useradd \
  --uid "${NEW_USER_ID}" \
  --create-home \
  "${NEW_USER}"

echo "JupyterHub: Set password for user ${NEW_USER}"
echo -e "$NEW_PASSWORD\n$NEW_PASSWORD" | \
  docker exec -i hub_docker_jupyterhub \
  sh -c "echo \"${NEW_USER}:${NEW_PASSWORD}\" | sudo chpasswd"
