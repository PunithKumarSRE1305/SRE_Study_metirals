# Week 08 — visual explainers

**Theme:** SSH, sudo, Linux admin mini-project

Diagram-first. Full 25-section docs are written when the week opens.

## Concept 1: Keys not passwords

A key pair is identity. Protect the private half.

## Concept 2: `~/.ssh` permissions

ssh will refuse a world-readable key. That is a feature.

## Concept 3: sudoers

Least privilege, not ‘everyone is root with extra steps’.

## Concept 4: Lockout recovery

Break-glass console exists because SSH dies.

## Concept 5: Mini-project

User + unit + logs on a lab box.


## Concept: SSH is a tunnel for a shell

```text
you ──ssh client──► network ──► sshd ──► pty ──► login shell
                         ▲
                         └── auth: key (preferred) or password (lab only)
```

If `sshd` is the incident, you need a **serial / cloud console**, not more SSH.


## Performance-testing bridge

Whatever this week names (files, perms, CPU, disk, packets) is something you already *saw from the outside* in a load test. The picture here is how that number is born.

## Check yourself

Close the page. Redraw one diagram from memory. If you cannot, you watched, you did not learn.
