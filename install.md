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
* you need `sysctl -w vm.max_map_count=262144` for running sonarqube
  and should probably make this permanent

### Adjust rootless container storage path (IMPORTANT!)

This is NEED because the default storage location for rootless containers
`/home/<user>/.local/share/containers/storage` will get very large soon.

In `/etc/containers/storage.conf` change or add the following line:

```text
rootless_storage_path = "/mnt/data/podman-rootless/$USER"
```

Also ensure that the path is available:

```sh
mkdir -p /mnt/data/podman-rootless
mkdir -p /mnt/data/podman-rootless/<user>
# adjust the owner, example
chown -R pascht:pascht /mnt/data/podman-rootless/pascht

# IMPORTANT: adjust selinux labels
chcon -Rt container_file_t /mnt/data/podman-rootless/

# maybe you need to delete the (already too large) old location (example):
rm -rf /home/pascht/.local/share/containers/storage
```

Maybe you need to reinstall a selinux package with:

```sh
dnf reinstall container-selinux
```

* Whenever graphRoot of a rootless user is changed to a different path, the SELinux labels for this location should also be changed appropriately
* Following commands needs to be run to change the labels

```sh
semanage fcontext -a -t container_var_lib_t 'graphRootDirectory(/.*)?'
restorecon -Rv graphRootDirectory
```

where graphRootDirectory is the new location specified in storage.conf

Reference: <br/>
* https://access.redhat.com/solutions/7007159
* https://github.com/containers/podman/issues/20314

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
systemctl --user stop node-exporter.service
systemctl --user stop sonarqube-caddy.service
```

## Port overview

## URL overview

## Troubleshooting

### Gotchas

* some special characters don't work well for passwords in `.env`: ?

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

### Debug on remote host with firewall in place

```sh
ssh -L 80:localhost:80 -L 443:localhost:443 -L 3010:localhost:3010 -L 9000:localhost:9000 -L 9099:localhost:9099 <user@host>
```

### Test db connection and pw

Use a running container with access to DB:

```sh
podman exec -it systemd-sonarqube-pg_sonar bash
```

Inside the container:

```sh
psql -U sonar postgresql://pg_sonar:5432/sonar
Password for user sonar:
```

## Firewall

```sh
sudo firewall-cmd --zone=public --add-service=http
sudo firewall-cmd --zone=public --add-service=https
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https

sudo firewall-cmd --reload

sudo firewall-cmd --zone=public --add-port=3010/tcp
sudo firewall-cmd --zone=public --add-port=9000/tcp
sudo firewall-cmd --zone=public --add-port=9099/tcp

sudo firewall-cmd --permanent --zone=public --add-port=3010/tcp
sudo firewall-cmd --permanent --zone=public --add-port=9000/tcp
sudo firewall-cmd --permanent --zone=public --add-port=9099/tcp

sudo firewall-cmd --reload
```

```sh
```

