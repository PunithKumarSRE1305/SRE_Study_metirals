# sudo vs logging in as root

**Week:** W03 · **Visual:** [`../visuals/sudo-intro.md`](../visuals/sudo-intro.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

**sudo** lets a permitted user run a *specific* command as another user (often root), with a log line. Logging in as root is an unbounded session as uid 0.

## 2. Why does it exist?

Root is necessary and toxic. You want a paper trail and a smaller blast radius.

## 3. Why do I need to know this as an SRE?

You will `sudo systemctl restart` and `sudo journalctl -xe`. You will not `sudo -i` and wander. A bad sudoers line can lock out every admin.

## 4. Real-world analogy

A signed work order to enter the vault vs being handed the master key for the day.

## 5. How does it work internally?

sudo consults `/etc/sudoers` and `/etc/sudoers.d/*` (edit only with `visudo`). It authenticates you, then `fork`/`exec` as the target uid with a (usually) cleaned environment. `sudo -u app` is as important as `sudo` (root).

## 6. Syntax / structure

```bash
sudo -l                    # what *you* may run
sudo systemctl status ssh
sudo -u app id
sudo visudo
```

## 7. Basic example

```bash
sudo -l
sudo id
sudo -u nobody id
```

## 8. Step-by-step execution

1. You type `sudo CMD`.
2. sudo checks sudoers and your groups.
3. It may ask for *your* password (not root's).
4. It execs CMD as the target user.

## 9. Why would I use this?

Privileged one-shots that are logged. Run a command as the *app* user to reproduce a permission bug.

## 10. When should I NOT use it?

Do not `sudo su -` as a lifestyle. Do not `sudo chmod 777`. Do not edit sudoers with raw vi.

## 11. Alternative ways

PolicyKit, SSH as a role account, and cloud IAM are cousins. On a box, sudo is the default.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| sudo CMD | one command | logged, limited | can still be too broad | default |
| sudo -u app | become the service | honest repro | easy to forget | permission debug |
| root login | unlimited | sometimes break-glass | no trail, huge blast | console only |

## 13. Common mistakes

- sudo su - every session
- NOPASSWD: ALL for convenience
- visudo skipped
- assuming sudo bypasses the need to understand permissions

## 14. Troubleshooting

**user is not in sudoers:** you are on the wrong account or the image is locked down (good). Use the break-glass path. **sudo: command not found:** root's PATH is not yours — use absolute paths.

## 15. Production relevance

A compromised user with `ALL=(ALL) NOPASSWD: ALL` is root. Treat sudoers like IAM.

## 16. Security considerations

Least privilege in sudoers. `!root` shells. Log aggregation of sudo. Never put secrets in the command line (`sudo cat /secret` still shows in history/audit).

## 17. Performance considerations

Negligible.

## 18. Related concepts

```text
users → permissions → sudo → ssh → auditd later
```

## 19. Visual diagram

```text
you ──sudo──► policy check ──► exec as root or -u app
                 │
                 └── syslog / journal  'sudo: you : CMD'
```

## 20. Hands-on exercise

```bash
sudo -l
id
sudo -u nobody id
# if you have no sudo, write that fact — it is data
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

You can reproduce a write failure only as the app user. Write the exact sudo command. Why is `sudo -i` the wrong move?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** sudo vs root login?
- **Intermediate:** Why visudo?
- **Advanced:** How do you debug a permission issue with sudo safely?

## 23. SRE scenario

On-call uses `sudo -i` and `chmod`s around. You revert, add a documented `sudo -u app` repro, tighten sudoers.

## 24. Summary

sudo is a logged, limited become. Root login is break-glass. visudo or nothing.

## 25. Knowledge checklist

- [ ] I understand what this is
- [ ] I understand why it exists
- [ ] I can explain it
- [ ] I can use it
- [ ] I can troubleshoot it
- [ ] I can explain its alternatives
- [ ] I can apply it in production
- [ ] I can answer interview questions

### Performance-testing bridge

- Here is what you already know from performance testing: You already separate 'test runner' from 'system under test'.
- Here is the SRE equivalent: sudo -u app is how you become the system under test.
- Here is what you need to learn next: processes — who is actually running.
