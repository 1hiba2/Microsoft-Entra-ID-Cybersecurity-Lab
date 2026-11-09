# Lab 01 — Identity and Access Management (IAM)

## Objective

Deploy and validate identity and access management controls using Microsoft Entra ID Free.

## Lab Environment

- Identity platform: Microsoft Entra ID Free
- Operating system: Windows 10
- Administrative interface: Microsoft Entra admin center
- Automation interface: Azure Cloud Shell and Microsoft Graph PowerShell
- Licensing: Free-tier functionality only

## 1. User Account Management

Created a dedicated test account named **Adam Smith** in Microsoft Entra ID.

**Implementation:**
1. Opened Microsoft Entra admin center.
2. Navigated to **Identity → Users → All users**.
3. Created a new internal test user.
4. Configured the account with a temporary password.
5. Completed the initial password-change process.
6. Verified that the account was enabled.

**Security purpose:** Separate test identities from administrator accounts and practice secure identity lifecycle management.

**Validation:** Confirmed `AccountEnabled = True` through Microsoft Graph PowerShell.

## 2. Security Group Configuration

Created an assigned security group called `IT-Security-Team`.

**Implementation:**
1. Navigated to **Identity → Groups → All groups**.
2. Created a group with type **Security**.
3. Selected **Assigned** membership.
4. Added the test user as a member.
5. Verified group membership through the Entra portal and Microsoft Graph PowerShell.

**Security purpose:** Organize access through security groups rather than managing users individually.

**Validation:** Confirmed `SecurityEnabled = True` and verified the test user's membership.

## 3. Administrative Unit Configuration

Created an administrative unit called `CyberLab-IT-Department`.

**Implementation:**
1. Opened **Administrative units** in Microsoft Entra.
2. Created a new administrative unit.
3. Added the test user.
4. Verified the user's administrative unit membership.

**Security purpose:** Understand how directory objects can be organized for scoped administration.

**Limitation:** Premium licensing requirements prevented testing paid scoped role-assignment features. Administrative unit membership alone does not give a user administrative privileges.

## 4. Least-Privilege Validation

Reviewed the test user's assigned administrative roles.

**Validation:**
- No administrative roles assigned to the test user were observed.
- No privileged administrative role was intentionally assigned as part of the lab.
- The test user remained a standard member account.

**Security purpose:** Reduce unnecessary privileges and exposure from compromised accounts.

## 5. Technical Verification Commands

The following commands illustrate the read-only Microsoft Graph verification operations used in the lab.

```powershell
# Retrieve the test user
Get-MgUser -Filter "displayName eq 'Adam Smith'" `
  -Property DisplayName,AccountEnabled |
  Select-Object DisplayName,AccountEnabled

# Retrieve the security group
Get-MgGroup -Filter "displayName eq 'IT-Security-Team'" `
  -Property DisplayName,SecurityEnabled |
  Select-Object DisplayName,SecurityEnabled

# Retrieve direct group members
$group = Get-MgGroup -Filter "displayName eq 'IT-Security-Team'"

Get-MgGroupMember -GroupId $group.Id -All |
  ForEach-Object {
    Get-MgUser -UserId $_.Id -ErrorAction SilentlyContinue
  } |
  Select-Object DisplayName
```

These read-only commands assume a Microsoft Graph connection with appropriate permissions.

## 6. Results

| Security control | Result |
|---|---|
| Test identity created | Verified |
| Test account enabled | Verified |
| Assigned security group configured | Verified |
| Test user added to security group | Verified |
| Administrative unit membership | Verified |
| No assigned administrative roles observed | Verified |

## 7. Lessons Learned

- Security groups simplify identity and access management.
- Administrative units organize directory objects but do not independently grant permissions.
- Least privilege should be validated, not assumed.
- Microsoft Graph PowerShell helps automate identity verification.

## 8. Official References

- [Microsoft Entra ID documentation](https://learn.microsoft.com/en-us/entra/identity/)
- [Administrative units](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/administrative-units)
- [Microsoft Graph PowerShell](https://learn.microsoft.com/en-us/powershell/microsoftgraph/)

## Privacy

This document uses lab-only display names and contains no actual tenant IDs, user principal names, passwords, access tokens, or confidential CSV data.