# Runbooks

Empty on purpose. A runbook written before you have ever seen the failure is fiction.

When a catalog item is run, add `Fxx-short-name.md` with:

- How we would detect it without being told
- First five commands
- Mitigation
- When to escalate (even if the only escalate is "stop and write notes")

Template seed:

```markdown
# Runbook: <name>
Symptoms:
Detection:
First actions:
Mitigation:
Do not:
Rollback / recover:
```
