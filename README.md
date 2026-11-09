# Microsoft Entra ID — Cybersecurity & Identity Security Lab

## Project Overview

A hands-on cybersecurity project focused on Identity and Access Management (IAM) using Microsoft Entra ID Free, Microsoft Graph PowerShell, and Azure Cloud Shell.

The project demonstrates practical experience in managing identities, implementing MFA, validating least-privilege access, investigating security logs, automating identity security checks, and responding to a simulated account compromise.

## Technologies Used

- Microsoft Entra ID Free
- Microsoft Azure Portal
- Microsoft Authenticator
- Microsoft Graph PowerShell SDK
- Azure Cloud Shell
- Windows 10
- GitHub and Markdown

## Technical Labs Completed

| Lab | Technical Area | Documentation |
|---|---|---|
| 01 | Identity and Access Management | [IAM Configuration](docs/01-identity-access-management.md) |
| 02 | MFA and Security Defaults | [MFA Implementation](docs/02-mfa-security-defaults.md) |
| 03 | Security Monitoring and Audit Logs | [Security Auditing](docs/03-security-monitoring-audit-logs.md) |
| 04 | Microsoft Graph PowerShell Automation | [PowerShell Automation](docs/04-microsoft-graph-powershell.md) |
| 05 | Incident Containment and Recovery | [Incident Response](docs/05-incident-response-recovery.md) |

## Key Technical Achievements

- Created and managed a dedicated test identity.
- Configured an assigned Microsoft Entra security group.
- Added and verified group membership.
- Created an administrative unit and assigned the test user.
- Enabled tenant-wide Security Defaults.
- Registered Microsoft Authenticator MFA.
- Investigated sign-in logs and validated MFA requirements.
- Reviewed directory audit logs.
- Verified least-privilege role configuration.
- Connected to Microsoft Graph using Azure Cloud Shell.
- Executed PowerShell identity and group queries.
- Generated a CSV membership report.
- Simulated account containment and recovery.

## PowerShell Automation

The repository includes a reusable, read-only Microsoft Graph PowerShell audit script:

[View PowerShell Security Audit Script](scripts/entra-security-audit.ps1)

The script is a portfolio adaptation of commands exercised individually during the lab. It has not been separately validated end-to-end.

## Technical Evidence

- [Security Group Configuration](evidence/01-security-group-configuration.png)
- [MFA Authentication Verification](evidence/02-mfa-authentication-verification.png)

Evidence images have been cropped to exclude private directory information. The MFA screenshot shows an authentication requirement satisfied by an existing authentication claim, not necessarily a new MFA challenge.

## Official References

See [Official Microsoft Documentation](REFERENCES.md).

## Scope and Limitations

The project uses Microsoft Entra ID Free and available Azure Cloud Shell functionality.

Premium Conditional Access, Privileged Identity Management, and paid hybrid infrastructure were not implemented.

The account-disable and account-recovery audit transitions were not conclusively verified from the inspected log details. The account status changes themselves were confirmed through the administration interface.

## Privacy and Security

This public portfolio excludes tenant IDs, user principal names, subscription IDs, passwords, access tokens, and original directory CSV exports. Private evidence is maintained separately from the repository.

## Skills Demonstrated

**Identity and Access Management · MFA · Microsoft Entra ID · Microsoft Graph PowerShell · RBAC Principles · Security Auditing · Incident Response · Security Reporting**