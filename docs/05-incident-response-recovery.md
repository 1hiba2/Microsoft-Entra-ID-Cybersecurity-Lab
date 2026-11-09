# Lab 05 — Incident Response: Account Containment and Recovery

## 1. Objective

Simulate an identity security incident in Microsoft Entra ID and practice account containment and recovery using a dedicated test identity.

The exercise demonstrates a basic incident-response workflow:

**Identify → Contain → Verify → Recover → Document**

## 2. Lab Environment

- Identity platform: Microsoft Entra ID Free
- Administration: Microsoft Entra admin center
- Operating system: Windows 10
- Test identity: Adam Smith
- Account type: Standard test user
- Administrative roles: None assigned to the test user

This was a controlled simulation. No real compromise or malicious activity occurred.

## 3. Incident Scenario

A security administrator receives a hypothetical alert that a test user's credentials may have been compromised.

The immediate objective is to prevent new sign-ins while the suspected incident is investigated.

The account must then be restored after the containment exercise.

## 4. Initial Account State

Before containment, the test account was confirmed to be enabled.

**Observed configuration:**

| Property | Value |
|---|---|
| Account | Adam Smith |
| Account enabled | Yes |
| Administrative roles | None observed |
| Security group | IT-Security-Team |

The administrator account was not modified during the exercise.

## 5. Containment: Disable the Account

### Implementation

1. Opened Microsoft Entra ID.
2. Navigated to **Identity → Users → All users**.
3. Selected the test user.
4. Opened **Properties** (*Propriétés*).
5. Selected **Edit properties** (*Modifier les propriétés*).
6. Changed **Account enabled** (*Compte activé*) from **Yes** (*Oui*) to **No** (*Non*).
7. Saved the change.

### Observed Result

The test account was successfully disabled.

| Property | Before | After |
|---|---|---|
| Account enabled | Yes | No |

### Security Significance

Disabling a compromised account is a containment action that prevents new sign-ins.

**Important limitation:** Disabling a user account does not guarantee that every existing session or previously issued access token is terminated immediately.

Additional session-revocation actions may be needed during a real incident, depending on the environment and available permissions.

## 6. Audit Log Investigation

After disabling the account, the administrative audit logs were inspected.

### Investigation Steps

1. Opened the test user's audit logs.
2. Inspected an available directory audit event.
3. Reviewed its **Modified properties** (*Propriétés modifiées*).

### Observed Result

The inspected event displayed properties including `Target.UserType` and `Member`.

The visible event details did **not** independently confirm that `accountEnabled` changed from `true` to `false`.

**Evidence conclusion:** The account was successfully disabled through the user properties interface, but the specific account-disable audit event was not conclusively verified.

## 7. Recovery: Re-enable the Account

### Implementation

1. Returned to the test user's **Properties** (*Propriétés*).
2. Opened **Edit properties** (*Modifier les propriétés*).
3. Changed **Account enabled** from **No** to **Yes**.
4. Saved the change.
5. Confirmed the account was enabled again.

### Observed Result

| Property | During containment | After recovery |
|---|---|---|
| Account enabled | No | Yes |

The account was successfully restored.

The existing security group and administrative unit configuration were not intentionally modified during this exercise.

## 8. Recovery Audit Review

The audit logs were reviewed again after the account was restored.

An inspected event did not show a confirmed `accountEnabled` transition from `false` to `true`.

Therefore, the recovery action was verified through the account properties, not through conclusive audit-event evidence.

This limitation is intentionally documented rather than overstating the results.

## 9. Incident Response Results

| Control or activity | Result |
|---|---|
| Test account initially enabled | Verified |
| Account disabled for containment | Successful |
| Administrator account left unchanged | Successful |
| Account restored after exercise | Successful |
| Final account-enabled status | Verified |
| Disable audit-event property change | Not conclusively verified |
| Recovery audit-event property change | Not conclusively verified |

## 10. Lessons Learned

- Identity account disabling is an important incident-containment technique.
- Account recovery should be planned before beginning a controlled test.
- Administrative changes should be validated after saving.
- Audit evidence must be inspected carefully before making claims about recorded events.
- Account disabling and session revocation are separate security considerations.
- Controlled testing should use dedicated nonprivileged accounts rather than administrator identities.

## 11. Production Incident Response Considerations

In a real suspected account compromise, a security team may also need to:

- Assess sign-in logs and suspicious activity.
- Revoke active sign-in sessions where appropriate.
- Reset or rotate compromised credentials.
- Investigate authentication methods and affected applications.
- Restore access only after the account is considered safe.
- Record incident timelines and escalation decisions.

These additional actions are described for context and were **not all performed** in this lab.

## 12. Official Microsoft References

- [Disable or delete a user in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/fundamentals/how-to-manage-users)
- [Microsoft Entra audit logs](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-audit-logs)
- [Microsoft Entra sign-in logs](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-sign-ins)
- [Microsoft Graph user resource](https://learn.microsoft.com/en-us/graph/api/resources/user)

## 13. Privacy and Safety

This report documents a controlled lab scenario only. It contains no tenant GUIDs, actual user principal names, passwords, access tokens, or unredacted audit log exports.

All original private evidence remains outside the public GitHub repository.