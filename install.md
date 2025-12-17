# Installion (rootless podman quadlet)

## Preparation (root)

As root:

```sh
# ensure required software
dnf install podman podman-compose yq git

# enable running processes without interactive login
loginctl enable-linger <user>
```

In addition:

* in `/etc/sysctl.d/` you need a file containing: <br/>
  ```text
  # let podman rootless use port 80+
  net.ipv4.ip_unprivileged_port_start=80
  ```

## Preparation (user)

```sh
cd SonarQubeCompose
cp env.example .env

# IMPORTANT: review and edit .env to your needs
# nano .env

mkdir -p ~/.config/containers/systemd/
mkdir -p ~/.config/SonarQubeCompose/
ln $PWD/.env ~/.config/SonarQubeCompose/
systemctl --user start podman.socket

# network mentioned in quadlets.template/sonarqube.network
podman network create sonarqube
podman network create exporter
podman network create pg_sonar

echo "sonarqube_data sonarqube_extensions sonarqube_logs sonarqube_temp pg_sonar_config pg_sonar_data es_sonar_data grafana prometheus caddy_data caddy_config" | xargs -n 1 podman volume create
```

## Actual installation

```sh
cd SonarQubeCompose

./scripts/quadlet-reinstall.sh
systemctl --user start sonarqube-grafana.service
systemctl --user start sonarqube-caddy.service
```

Started sonarqube will survive reboots. To stop see section 'Stopping sonarqube' below.

## Stopping sonarqube

```sh
```

## Port overview

## URL overview

## Troubleshooting

### Debugging

```sh
journalctl -xe

podman ps
podman ps -a

systemctl --user status podman-exporter.service
# if status fails, one of the best thing to debug is to use nano
# to extract the actual command that was run (and has failed)

journalctl --user -xeu podman-exporter.service
```

```sh
```

