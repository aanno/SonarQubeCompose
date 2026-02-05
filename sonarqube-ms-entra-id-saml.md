# Microsoft Entra ID SAML Configuration for SonarQube

### Errors

###

Problem<br/>

Invalid assertion for SAML response : Condition '{urn:oasis:names:tc:SAML:2.0:assertion}AudienceRestriction' of type 'null' in assertion  was not valid.: None of the audiences within Assertion matched the list of valid audiances

Solution<br/>

Probably a invisible space (or other character) in the MS Entra Setup. Best thing is to start over and be careful when copying/pasting values.

* https://community.sonarsource.com/t/after-upgrade-to-sonarqube-developer-edition-v2025-1-102418-saml-authentication-failed/135832/3
* https://github.com/structurizr/onpremises/discussions/99
* https://community.blackduck.com/s/article/401-Unauthorized-error-when-logging-in-with-SAML (case #5)


## References

* https://docs.sonarsource.com/sonarqube-server/instance-administration/authentication/saml/ms-entra-id
* https://learn.microsoft.com/en-us/entra/identity/saas-apps/sonarqube-tutorial
* https://www.tothenew.com/blog/sonarqube-azure-entra-id-saml-authentication-step-by-step-guide/
* https://www.miniorange.com/atlassian/saml-single-sign-on-sso-sonarqube-using-azure-ad
