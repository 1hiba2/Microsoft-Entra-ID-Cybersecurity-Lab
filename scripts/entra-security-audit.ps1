# Microsoft Entra ID - Read-Only Security Audit
# Requires Microsoft.Graph.Users and Microsoft.Graph.Groups
# Connect to Microsoft Graph with authorized read permissions first.
# Example:
# .\entra-security-audit.ps1 -UserDisplayName "Example User" -GroupDisplayName "Example-Security-Group"

param(
    [Parameter(Mandatory = $true)]
    [string]$UserDisplayName,

    [Parameter(Mandatory = $true)]
    [string]$GroupDisplayName
)

$ErrorActionPreference = "Stop"

Import-Module Microsoft.Graph.Users -ErrorAction Stop
Import-Module Microsoft.Graph.Groups -ErrorAction Stop

if (-not (Get-MgContext)) {
    throw "Microsoft Graph is not connected."
}

$escapedUser = $UserDisplayName.Replace("'", "''")
$escapedGroup = $GroupDisplayName.Replace("'", "''")

$users = @(Get-MgUser -Filter "displayName eq '$escapedUser'" -Property Id,DisplayName,AccountEnabled)

if ($users.Count -ne 1) {
    throw "Expected exactly one matching user. Found $($users.Count)."
}

$user = $users[0]

$groups = @(Get-MgGroup -Filter "displayName eq '$escapedGroup'" -Property Id,DisplayName,SecurityEnabled)

if ($groups.Count -ne 1) {
    throw "Expected exactly one matching group. Found $($groups.Count)."
}

$group = $groups[0]

$memberIds = @(
    Get-MgGroupMember -GroupId $group.Id -All |
        Select-Object -ExpandProperty Id
)

$isMember = $user.Id -in $memberIds

[PSCustomObject]@{
    UserDisplayName = $user.DisplayName
    AccountEnabled = $user.AccountEnabled
    GroupDisplayName = $group.DisplayName
    SecurityEnabled = $group.SecurityEnabled
    DirectGroupMember = $isMember
} | Format-List

# No directory settings are modified.
# No CSV or sensitive data is saved automatically.