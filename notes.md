# Notes

* [community support](https://community.sonarsource.com)

## GitLab

* [Setting up GitLab integration at global level](https://docs.sonarsource.com/sonarqube-server/devops-platform-integration/gitlab-integration/global-setup)
* [Setting up GitLab integration at project level](https://docs.sonarsource.com/sonarqube-server/devops-platform-integration/gitlab-integration/setting-up-at-project-level)
* [GitLab CI](https://docs.sonarsource.com/sonarqube-cloud/advanced-setup/ci-based-analysis/gitlab-ci)
  + needs: [Docker executor](https://docs.gitlab.com/runner/executors/#docker-executor)

## Configuration

* GitLab _is_ supported
* Choose baseline between:
  + previous version
    - https://community.sonarsource.com/t/how-does-sonarqube-determine-previous-version/36871
  + number of days
  + reference branch

## Integration with build system

* mvn _is_ supported
* npm (pnpm) _is_ supported

## gaeko


## gaeko ui

* There are problems with file encoding in the source code. Please check the scanner logs for more details.
* ScannerEngine: The property "sonar.tests" is not set. To improve the analysis accuracy, we categorize a file as a test file if any of the following is true:
  * The filename starts with "test"
  * The filename contains "test." or "tests."
  * Any directory in the file path is named: "doc", "docs", "test" or "tests"
  * Any directory in the file path has a name ending in "test" or "tests"

## Sonarqube Plugins

* [install plugin](https://docs.sonarsource.com/sonarqube-server/server-installation/plugins/install-a-plugin)
* [marketplace](https://docs.sonarsource.com/sonarqube-server/server-update-and-maintenance/update/marketplace)
  + [marketplace json files](https://downloads.sonarsource.com/?prefix=sonarqube/update)
  + [official downloads](https://binaries.sonarsource.com/)
  + most free plugins are on github
* [Plugin version matrix](https://docs.sonarsource.com/sonarqube-server/server-installation/plugins/plugin-version-matrix)

Interesting:

* https://github.com/jborgers/sonar-pmd
* https://github.com/SonarQubeCommunity/sonar-jmeter

Commercial but interesting:

* https://www.hello2morrow.com/products/sonargraph

### Develop own Plugin

* https://docs.sonarsource.com/sonarqube-server/extension-guide/developing-a-plugin/plugin-basics
* https://github.com/SonarSource/sonar-plugin-api

### Community Plugins

* https://github.com/orgs/SonarQubeCommunity/repositories?type=all

### Commercial and free Plugins

* https://www.sonarplugins.com/
  A third-party website called sonarplugins.com also exists. This website is not the same as the Marketplace and is not endorsed by, affiliated with, maintained, authorized, or sponsored by Sonar.

## JaCoCo

* [Code Coverage with SonarQube and JaCoCo](https://www.baeldung.com/sonarqube-jacoco-code-coverage)
* https://github.com/jacoco/jacoco
* https://www.jacoco.org/jacoco/

## Monitoring

* [Prometheus Monitoring (9.9)](https://docs.sonarsource.com/sonarqube-server/9.9/instance-administration/monitoring)
* [Monitoring JMX](https://docs.sonarsource.com/sonarqube-server/server-update-and-maintenance/monitoring/instance)
* [Setting up with Prometheus server](https://docs.sonarsource.com/sonarqube-server/server-installation/on-kubernetes-or-openshift/set-up-monitoring/prometheus)
* [List of Prometheus metrics](https://docs.sonarsource.com/sonarqube-server/server-installation/on-kubernetes-or-openshift/set-up-monitoring/prometheus-metrics)

### local monitoring

* http://localhost:9000/api/monitoring/metrics
  simple text based
* http://localhost:9000/api/system/health
  health only

## Sonarqube API

* [API documentation](https://next.sonarqube.com/sonarqube/web_api/api/measures)

## Sonarqube Rules

* https://rules.sonarsource.com/
* [custom rules](https://docs.sonarsource.com/sonarqube-server/extension-guide/adding-coding-rules)
