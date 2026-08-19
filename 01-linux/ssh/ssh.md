# SSH — keys, agent, hardening intro

**Week:** W08 · **Visual:** [`../visuals/ssh.md`](../visuals/ssh.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

**SSH** is an encrypted login and command channel. **Keys** prove identity: a private file you never copy, a public file you place in `authorized_keys`. `sshd` is the server. If sshd is the incident, you need a console.

## 2. Why does it exist?

You will operate almost every Linux box through SSH (or SSM, which is SSH's cousin).

## 3. Why do I need to know this as an SRE?

Key-only auth, no root login, jump/bastion, `ssh-agent`. Permissions: `~/.ssh` 700, private key 600, authorized_keys 600. ssh will refuse sloppy modes — that is a feature.

## 4. Real-world analogy

A wax seal (private key) whose imprint (public key) is on the guest list. The seal never leaves your pocket.

## 5. How does it work internally?

Client offers a key. Server checks `authorized_keys` and a challenge-response. On success it allocates a pty (or not, for `ssh host cmd`) and starts a shell. Agent holds decrypted keys in memory. Tunnels (`-L`/`-R`) move ports.

## 6. Syntax / structure

```bash
ssh user@host
ssh -i ~/.ssh/lab  user@host
ssh-keygen -t ed25519 -f ~/.ssh/lab -C 'sre-lab'
ssh-copy-id -i ~/.ssh/lab.pub user@host   # lab only
ssh -J bastion user@privatehost
```

## 7. Basic example

```bash
ls -la ~/.ssh 2>/dev/null || echo 'no ~/.ssh yet'
# generate only in lab if you need a key:
# ssh-keygen -t ed25519 -f "$HOME/.ssh/sre-lab" -N ''
```

## 8. Step-by-step execution

1. Client resolves host, TCP 22 (or configured).
2. Auth: key (preferred) or password (lab only).
3. Session: pty + shell, or a single command.
4. On failure: read the *server* log (`journalctl -u ssh`) from console.

## 9. Why would I use this?

Daily access. Git over SSH. Port forwards to a lab DB. Copy with `scp`/`rsync -e ssh`.

## 10. When should I NOT use it?

Do not password-auth on the internet. Do not copy private keys to Slack. Do not debug a downed sshd by SSHing harder.

## 11. Alternative ways

AWS SSM Session Manager and serial console are the break-glass paths.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| key auth | identity | phishing-resistant-ish | key management | default |
| password | easy | simple | brute force | lab only |
| SSM/serial | break-glass | independent of sshd | cloud-specific | when SSH is the incident |

## 13. Common mistakes

- 644 private key
- root login + password
- ssh-agent forwarding to untrusted hops
- disabling StrictHostKeyChecking globally

## 14. Troubleshooting

**Permission denied (publickey):** wrong key, wrong user, wrong authorized_keys, or modes. **Connection refused:** sshd down or wrong port. **Timeout:** SG/NACL/route, not 'SSH is broken' yet.

## 15. Production relevance

Bastion + private subnets. Or SSM and no 22 to the world. Known_hosts pin identity.

## 16. Security considerations

This whole page is security. Treat keys like passwords that never travel. Rotate. One key per laptop.

## 17. Performance considerations

ControlMaster multiplexing helps many short sessions. Not your first problem.

## 18. Related concepts

```text
terminal → sshd → keys → sudo → console
```

## 19. Visual diagram

```text
laptop private key ──challenge──► sshd ──authorized_keys (public)
                                      │
                                      └── pty → login shell
```

## 20. Hands-on exercise

```bash
ls -la ~/.ssh 2>/dev/null || true
# if a private key exists: stat -c '%a %n' ~/.ssh/* 2>/dev/null | head
man ssh | col -b | head -5
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

ssh says 'UNPROTECTED PRIVATE KEY FILE'. What mode is wrong, and why is ssh correct to refuse?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** public vs private key?
- **Intermediate:** Why 600 on the private key?
- **Advanced:** How do you get in when sshd is down?

## 23. SRE scenario

sshd config typo after 'hardening'. You use the cloud serial console, revert, then change via a tested drop-in.

## 24. Summary

Keys, strict modes, no root passwords. Console when SSH is the fire.

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

- Here is what you already know from performance testing: You already use SSH or a jump to reach load generators sometimes.
- Here is the SRE equivalent: Now you operate the *target* the same way, with less privilege.
- Here is what you need to learn next: troubleshooting method.
