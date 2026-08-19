# Users and groups

**Week:** W03 · **Visual:** [`../visuals/users-and-groups.md`](../visuals/users-and-groups.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

A **user** is a number (`uid`) the kernel stamps on processes and files. A **group** is another number (`gid`) plus a membership list. Names in `/etc/passwd` and `/etc/group` are a phone book. The kernel does not love names. It loves integers.

## 2. Why does it exist?

Isolation. Your app should not be able to read `/etc/shadow` or another tenant's files. Identity is how the permission system has anyone to talk about.

## 3. Why do I need to know this as an SRE?

The app cannot write `/var/log/myapp` because it runs as `www-data` (uid 33) and the directory is owned by `root`. 'Permission denied' is an identity mismatch until proven otherwise.

## 4. Real-world analogy

Employee badge numbers vs names on the badge. The door reader uses the number.

## 5. How does it work internally?

At login or `sudo`, PAM and the login path set the real/effective uid and the supplementary groups. Every syscall that creates a file stores the process's fsuid/fsgid on the inode. `/etc/passwd` fields: name, x, uid, gid, gecos, home, shell. `/etc/shadow` holds the password hash (mode 640).

## 6. Syntax / structure

```bash
id
whoami
getent passwd $USER
getent group sudo
# lab only:
sudo useradd -m -s /bin/bash applab
sudo passwd applab
```

## 7. Basic example

```bash
id
getent passwd $(whoami)
ls -n /etc/passwd | head
```

## 8. Step-by-step execution

1. `id` asks the kernel who *this* process is.
2. `getent` asks the name service (files, sssd, etc.).
3. A new user in a lab is an entry in passwd/shadow/group plus a home.
4. The next process started as that user carries that uid.

## 9. Why would I use this?

Diagnose 'who is this process?' before you chmod anything. Create *lab* users to practice.

## 10. When should I NOT use it?

Do not create users on production by hand if an IdM/IAM flow exists. Do not share the `ubuntu` login.

## 11. Alternative ways

Cloud instances often use SSM/os-login instead of local users. Same idea: a number the kernel will enforce.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| local passwd | simple boxes | always there | does not scale | labs, pets |
| sssd/LDAP | central identity | one place | more moving parts | fleets |
| IAM/IRSA later | cloud identity | no long-lived keys | not a Linux uid | AWS year 2 |

## 13. Common mistakes

- Thinking the username *is* the identity
- Deleting a user without checking running processes
- Assuming uid 1000 is always 'you' on every box

## 14. Troubleshooting

**Unknown user in ls -l:** the uid has no name in this box's phone book (`ls -n` shows numbers). **App wrote files as root:** it was started as root. Fix the unit's `User=` inter alia.

## 15. Production relevance

A container that runs as uid 0 and writes into a host bind-mount is how host files become root-owned and then undeletable by the app user.

## 16. Security considerations

`/etc/shadow` is secret. Unused users with `/bin/bash` and a weak password are a door. Lock shells with `nologin` for service accounts.

## 17. Performance considerations

getent against a hung LDAP is an outage that looks like 'login is slow'.

## 18. Related concepts

```text
uid → permissions → sudo → systemd User= → containers
```

## 19. Visual diagram

```text
/etc/passwd   name → uid, gid, home, shell
/etc/group    name → gid, members
process       euid, egid, groups[]   ← what the kernel checks
```

## 20. Hands-on exercise

```bash
id
getent passwd $(whoami)
getent group $(id -gn)
ls -n /home | head
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

`ls -l` shows `unknown 1002`. The app still runs. What is 1002, and is the app broken?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** What is a uid?
- **Intermediate:** Why might ls show a number not a name?
- **Advanced:** How does a container uid 0 map onto the host?

## 23. SRE scenario

Deploy created files as root in `/var/lib/myapp`. Next start, the app user cannot write. You chown to the unit's User=, then fix the deploy.

## 24. Summary

Names are a phone book. The kernel checks numbers. Always `id` the process, not the human.

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

- Here is what you already know from performance testing: You already run JMeter as *some* OS user.
- Here is the SRE equivalent: That user is not the app user. Permission bugs look like 500s under load if only workers hit the write path.
- Here is what you need to learn next: Permission bits and sudo.
