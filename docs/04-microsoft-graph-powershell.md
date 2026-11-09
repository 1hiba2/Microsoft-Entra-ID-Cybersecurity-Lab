# Lab 04 — Microsoft Graph PowerShell Automation

## 1. Objective

Use Microsoft Graph PowerShell to perform read-only identity and access security checks and export an auditable security group membership report.

This lab demonstrates practical IAM automation, troubleshooting, and security reporting without purchasing premium Microsoft Entra licenses.

## 2. Lab Environment

- Microsoft Entra ID Free
- Azure Cloud Shell (PowerShell)
- Microsoft Graph PowerShell SDK
- Windows 10
- Test user: Adam Smith
- Test security group: `IT-Security-Team`

All commands use demonstration display names rather than real user principal names or tenant identifiers.

## 3. Authentication and Environment Setup

The lab initially attempted Microsoft Graph authentication through local Windows PowerShell. Device-code and interactive authentication attempts did not establish a working directory connection.

To continue, the environment was changed to Azure Cloud Shell using PowerShell and the **No storage account required** option.

The authenticated Azure session was verified using:

```powershell
Get-AzContext | Select-Object Account, Tenant, Subscription
```

Microsoft Graph was connected using:

```powershell
Connect-MgGraph -Identity -NoWelcome
```

The Microsoft Graph context was inspected:

```powershell
Get-MgContext |
  Select-Object AuthType, TenantId, ClientId, ContextScope
```

**Observed result:** An AppOnly / managed identity Graph context was established. Subsequent read-only directory queries succeeded.

**Security note:** Managed identity authentication does not automatically grant Microsoft Graph permissions. Access is limited by permissions configured for the identity.

## 4. Microsoft Graph Modules

During the lab, the `Microsoft.Graph.Users` module was required to run `Get-MgUser`.

The module was installed and loaded:

```powershell
Install-Module Microsoft.Graph.Users -Scope CurrentUser -Repository PSGallery -Force

Get-Module -ListAvailable Microsoft.Graph.Users |
  Select-Object Name, Version

Import-Module Microsoft.Graph.Users -ErrorAction Stop
```

The Users module version observed in the lab was `2.41.2`.

The Cloud Shell environment was ephemeral, so any module installations or files without persistent storage could be lost when the session ended.

## 5. Verify the Test User

```powershell
Get-MgUser -Filter "displayName eq 'Adam Smith'" `
  -Property DisplayName,AccountEnabled |
  Select-Object DisplayName,AccountEnabled
```

**Observed result:**

| DisplayName | AccountEnabled |
|---|---|
| Adam Smith | True |

The query confirmed the test account existed and was enabled at the time of verification.

## 6. Verify the Security Group

```powershell
Get-MgGroup -Filter "displayName eq 'IT-Security-Team'" `
  -Property DisplayName,SecurityEnabled |
  Select-Object DisplayName,SecurityEnabled
```

**Observed result:**

| DisplayName | SecurityEnabled |
|---|---|
| IT-Security-Team | True |

This confirmed that the directory group was configured as a security group.

## 7. Verify Group Membership

```powershell
$group = Get-MgGroup -Filter "displayName eq 'IT-Security-Team'"

Get-MgGroupMember -GroupId $group.Id -All |
  ForEach-Object {
    Get-MgUser -UserId $_.Id -ErrorAction SilentlyContinue
  } |
  Select-Object DisplayName, UserPrincipalName
```

**Observed result:** Adam Smith appeared in the direct group membership results.

The command was read-only and did not change directory membership.

In this portfolio, actual user principal names are deliberately excluded.

## 8. Export Group Membership to CSV

The following PowerShell pipeline was used to produce a membership report:

```powershell
$group = Get-MgGroup -Filter "displayName eq 'IT-Security-Team'"

Get-MgGroupMember -GroupId $group.Id -All |
  ForEach-Object {
    Get-MgUser -UserId $_.Id -ErrorAction SilentlyContinue
  } |
  Select-Object DisplayName, UserPrincipalName, AccountEnabled |
  Export-Csv -Path "$HOME/IT-Security-Team-Members.csv" -NoTypeInformation
```

**Observed result:** A CSV file was created and verified as nonempty.

The CSV contained a header and a row for the test user. The original CSV was saved locally for private evidence retention.

**Important:** The exported `AccountEnabled` field appeared blank in the inspected CSV. It is not presented as a verified value in that report; the separate `Get-MgUser` user query confirmed the account was enabled.

## 9. Evidence Preservation

Azure Cloud Shell's normal file download dialog was unsuccessful in the storage-free temporary session.

The CSV contents were displayed using:

```powershell
Get-Content "$HOME/IT-Security-Team-Members.csv"
```

The report was then saved manually on the Windows laptop.

The original CSV is stored **outside** the public GitHub repository folder.

No actual user principal names, access tokens, tenant GUIDs, or unredacted directory exports are included in this public documentation.

## 10. Security Outcomes

| Security activity | Result |
|---|---|
| Microsoft Graph PowerShell connection | Successful |
| Test user lookup | Successful |
| Security group lookup | Successful |
| Group membership verification | Successful |
| CSV membership report creation | Successful |
| Private report preservation | Completed |

## 11. Lessons Learned

- Microsoft Graph PowerShell provides repeatable ways to inspect directory security.
- A successful authentication connection must be distinguished from sufficient API permissions.
- PowerShell modules may need to be installed or imported separately.
- Read-only identity checks can be automated without changing account settings.
- CSV exports provide useful evidence, but their contents must be validated before reporting.
- Temporary Cloud Shell environments require deliberate evidence preservation.

## 12. Official Microsoft References

- [Microsoft Graph PowerShell overview](https://learn.microsoft.com/en-us/powershell/microsoftgraph/overview)
- [Get-MgUser](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/get-mguser)
- [Get-MgGroup](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.groups/get-mggroup)
- [Get-MgGroupMember](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.groups/get-mggroupmember)
- [Azure Cloud Shell overview](https://learn.microsoft.com/en-us/azure/cloud-shell/overview)

## 13. Privacy

All examples use demonstration display names. The public repository must not contain the original membership CSV, real UPNs, tenant identifiers, tokens, passwords, or unredacted screenshots.