# Quadlets

## Debugging

Examples:
```sh
systemctl --user list-units '*sonarqube*' --all
  UNIT                                LOAD      ACTIVE   SUB     DESCRIPTION                        
  sonarqube-caddy.service             loaded    active   running sonarqube-caddy.service
  sonarqube-grafana.service           loaded    inactive dead    sonarqube-grafana.service
  sonarqube-pg_sonar.service          loaded    active   running sonarqube-pg_sonar.service
  sonarqube-pg_sonar_exporter.service loaded    inactive dead    sonarqube-pg_sonar_exporter.service
  sonarqube-pod.service               loaded    active   running sonarqube-pod.service
  sonarqube-prometheus.service        loaded    inactive dead    sonarqube-prometheus.service
  sonarqube-sonarqube.service         loaded    inactive dead    sonarqube-sonarqube.service
● sonarqube.service                   not-found inactive dead    sonarqube.service

systemctl --user list-unit-files '*sonarqube*' --all
UNIT FILE                           STATE     PRESET
sonarqube-caddy.service             generated -     
sonarqube-grafana.service           generated -     
sonarqube-network.service           generated -     
sonarqube-pg_sonar.service          generated -     
sonarqube-pg_sonar_exporter.service generated -     
sonarqube-pod.service               generated -     
sonarqube-prometheus.service        generated -     
sonarqube-sonarqube.service         generated -     

8 unit files listed.

# Test parsing
/usr/libexec/podman/quadlet --dryrun --user ~/.config/containers/systemd/sonarqube.pod

``

## portlet

### Known issues

* Podlet --pod with name: sonarqube adds prefix to systemd units but not internal Requires/After. Known issue, manual fix required.​
  Example: pg_sonar.service -> sonarqube-pg_sonar.service
* Hard links will be destroyed by daemon-reload, use scripts/compose-to-quadlet.sh to reinstall
```sh
``

