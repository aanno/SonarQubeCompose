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

```sh
/usr/libexec/podman/quadlet --dryrun --user ~/.config/containers/systemd/sonarqube.pod
```

### debug pushgateway

```sh
# log into the VM as user that runs the sonarqube services.
echo 'my_job_metric 1' | curl --data-binary @- \
  http://localhost:9091/metrics/job/myjob
```

After that you should see the metric in prometheus.

ATTENTION: Also test from external, i.e.

```sh
echo 'my_job_metric 1' | curl --data-binary @-   http://qs-node2:9091/metrics/job/myjob
```

## portlet

### Known issues

* Podlet --pod with name: sonarqube adds prefix to systemd units but not internal Requires/After. Known issue, manual fix required.​
  + Solution: Rename pg_sonar.service -> sonarqube-pg_sonar.service
    in Requires: After: and others
* Hard links will be destroyed by daemon-reload
  + Solution: Use scripts/compose-to-quadlet.sh to reinstall
* Host names will change, e.g. from caddy to systemd-sonarqube-caddy.
  + Solution use: HostName=caddy in *.container (but only if you don't use Pod=)
  + Well, you can't use HostName at all if you use Pod=
  + If you don't use Pod=, you need PublishPort
* Health check (in HealthCmd=) does not have the required environment variable
  + Solution: HealthCmd=pg_isready -U "$SONAR_JDBC_USERNAME" -d "$SONAR_POSTGRES_DB"
  + Solution: Comment out HealthCmd
* All used required environment variable will disappear, see Health check above
* Double check if EnvironmentFile come BEFORE Environment
  + You probably want EnvironmentFile as FIRST line in section

```sh
``

