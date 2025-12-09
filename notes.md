# Notes

## Challenges

* Access Token does not work. Is it a problem for the external setup only?

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

Interesting:

* https://github.com/jborgers/sonar-pmd

### Develop own Plugin

* https://docs.sonarsource.com/sonarqube-server/extension-guide/developing-a-plugin/plugin-basics

### Community Plugins

* https://github.com/orgs/SonarQubeCommunity/repositories?type=all

### Commercial and free Plugins

* https://www.sonarplugins.com/

## JaCoCo
