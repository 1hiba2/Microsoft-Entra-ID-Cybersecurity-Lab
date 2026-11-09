# Lab 02 — Multi-Factor Authentication and Security Defaults

## 1. Objective

Implement and validate baseline identity security controls using Microsoft Entra ID Free, Microsoft Authenticator, and Security Defaults.

The lab demonstrates how multi-factor authentication can reduce the risk of unauthorized access from compromised passwords.

## 2. Lab Environment

- **Identity platform:** Microsoft Entra ID Free
- **Authentication application:** Microsoft Authenticator
- **Administration portal:** Microsoft Entra admin center
- **Monitoring:** Microsoft Entra sign-in logs
- **Test identity:** Adam Smith (demonstration account)
- **Operating system:** Windows 10

No Microsoft Entra ID P1 or P2 licenses were purchased for this exercise.

## 3. Configure Security Defaults

### Implementation

1. Opened the Microsoft Entra admin center.
2. Navigated to **Microsoft Entra ID → Overview → Properties**.
3. Opened **Manage security defaults** (*Gérer les paramètres de sécurité par défaut*).
4. Confirmed **Security defaults: Enabled** (*Activé*).
5. Left Security Defaults enabled throughout the validation tests.

### Security Purpose

Security Defaults provides a baseline set of tenant-wide protections, including MFA-related safeguards and blocking legacy authentication.

Security Defaults is not the same as Microsoft Entra Conditional Access. No custom Conditional Access policies were implemented in this lab.

## 4. Register Microsoft Authenticator

### Implementation

1. Signed in using the lab test account.
2. Completed the required initial password change.
3. Followed the security information registration process.
4. Registered Microsoft Authenticator as an authentication method.
5. Completed the authentication challenge successfully.

### Security Purpose

Microsoft Authenticator provides a second authentication factor beyond a password, helping protect the account if the password is exposed.

## 5. Validate Authentication Using Sign-in Logs

### Implementation

1. Navigated to **Identity → Users → All users**.
2. Opened the test user.
3. Selected **Sign-in logs** (*Journaux de connexion*).
4. Opened a successful interactive sign-in event.
5. Reviewed **Authentication details** (*Détails d'authentification*).

### Observed Evidence

A successful sign-in showed the following authentication information:

| Field | Observed value |
|---|---|
| Authentication policy | Application required multifactor authentication |
| Authentication method | Previously satisfied |
| Operation successful | True |
| MFA result | Requirement satisfied |

### Interpretation

The sign-in log confirmed that the MFA requirement was satisfied using an existing authentication claim or session.

**Important distinction:** The `Previously satisfied` result does not prove that a new Microsoft Authenticator challenge occurred during that particular sign-in. It indicates that MFA had already been satisfied.

The test account separately completed Microsoft Authenticator registration and an MFA authentication flow during the lab.

## 6. Security Validation Results

| Test | Result |
|---|---|
| Security Defaults enabled | Verified |
| Microsoft Authenticator registration | Completed |
| Initial password change | Completed |
| Successful authenticated sign-in | Verified |
| MFA requirement satisfied in sign-in logs | Verified |
| Custom Conditional Access policies | Not implemented — premium licensing required |

## 7. Security Lessons Learned

- MFA improves account protection beyond password-only authentication.
- Authentication policies must be validated using actual sign-in evidence.
- An MFA requirement may be satisfied by an existing authentication session.
- Security Defaults provides useful free-tier identity protections.
- Security Defaults and custom Conditional Access policies should not be confused.
- Sign-in logs are useful evidence during identity investigations.

## 8. Scope and Limitations

This was a controlled test environment, not a production deployment.

The lab validated authentication settings and observed sign-in events. It did not perform penetration testing, implement premium Identity Protection policies, or prove that every future sign-in would generate a fresh MFA challenge.

## 9. Official Microsoft References

- [Security Defaults in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/fundamentals/security-defaults)
- [Microsoft Authenticator documentation](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-authentication-authenticator-app)
- [Sign-in logs in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-sign-ins)
- [Authentication details in sign-in logs](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-sign-in-log-activity-details)

## 10. Privacy and Evidence Handling

This public document intentionally excludes tenant IDs, real user principal names, authentication secrets, access tokens, and unredacted sign-in screenshots.

Any screenshots published as supporting evidence must be reviewed and redacted before upload.