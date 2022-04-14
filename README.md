# README

Set up an analytics environment with RStudio and Jupyterhub with docker
containers.

## Requirements

- Docker/ Podman
- docker-compose

## Quickstart

### Build all images

Go to the main directory and run `docker-compose -f docker-build.yml build`.

### Run

Go to the main directory and run `docker-compose up -d` to start all
containers in detached mode.

### Create a user

Create a user with UID "1000", username "analytics" and password "analytics".

```shell
./scripts/create_user.sh -i 1000 -u analytics -p analytics
```

The user's home directory is on a NFS store and shared on RStudio and
Jupyterhub.

### Access Web UI

- Access RStudio at <https://localhost>
- Access Jupyterhub at <https://localhost/jupyterhub/>
- Access Traefik dashboard at <https://localhost/traefik/>

## Traefik Proxy

The dashboard is available on `/traefik/` the configured `HOST` or as default
<https://localhost/traefik/>.

Traefik is used as a reverse proxy that also manages ssl connections
to all services. Thus, a daemon with active socket communication is required.
Docker provides this by default. For podman sockets can be used as well.
E.g. for RHEL/ Fedora install the  following packages and enable the service.

```shell
sudo yum install -y podman podman-docker docker-compose
sudo systemctl enable --now podman.socket

# Check if the socket is available
sudo curl -H "Content-Type: application/json" \
  --unix-socket /var/run/docker.sock http://localhost/_ping
```

Allow rootless container and run as a user.

```shell
systemctl --user enable --now podman.socket
echo -e "export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock" >> ~/.profile
```

## RStudio

RStudio is available on the configured `HOST` or as default
<https://localhost>.

## Jupyterhub

Jupyterhub is available on `/jupyterhub/` the configured `HOST` or as default
<https://localhost/jupyterhub/>.

## Storage

A separate container runs a NFS server with a share available only within the
deployment. It holds the user's home directory and persists that storage
on a local Docker volume.

## Users

Users are local users in the running containers. They are lost when the
deployment is stopped. However, their home directory is kept persistent
on the Docker volume that is used for the NFS share.
