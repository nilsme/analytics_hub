# README

Set up an analytics environment with RStudio and Jupyterhub with docker
containers.

## Quickstart

### Build all images

Go to the main directory and run `docker-compose -f docker-build.yml build`.

### Run

Go to the main directory and run `docker-compose up -d` to start all
containers in detached mode.

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

> If the volume mounts to the host system are used, the container has to be
> run by root user.

```shell
systemctl --user enable --now podman.socket
echo -e "export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock" >> ~/.profile
```

### RStudio

RStudio is available on the configured `HOST` or as default
<https://localhost>.

The container for RStudio will use the `/home` directory of the host as its
`/home` directory and also use the `/etc/passwd`, `/etc/group`, and
`/etc/shadow` from the host machine. If you don't want this, you have to
change the `docker-compose.yml` and also the dockerfile for rstudio according
to your needs.

> If you mount the suggested volumes from the host, it does need the user
> `rstudio-server` on the host system, otherwise the service will fail to start.
> You can add such a user on your host with `sudo adduser rstudio-server`.

### Jupyterhub

Jupyterhub is available on `/jupyterhub/` the configured `HOST` or as default
<https://localhost/jupyterhub/>.

Jupyterhub will use the `/home` directory of the host as its `/home` directory
and also use the `/etc/passwd`, `/etc/group`, `/etc/shadow`, `/etc/gshadow`,
`/etc/pamd.d`, and `/etc/authselect/` from the host machine. Which means
that the Jupyterhub admin group (`jupyterhub-admins`) must exist on the host,
even if no user is a member of the group.
