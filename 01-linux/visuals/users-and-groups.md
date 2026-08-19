# Visual: Users and groups

Full doc: [`../users-permissions/users-and-groups.md`](../users-permissions/users-and-groups.md)

![Users and groups](images/users-groups-sudo.png)

```text
/etc/passwd   name → uid, gid, home, shell
/etc/group    name → gid, members
process       euid, egid, groups[]   ← what the kernel checks
```

## Walk it

A **user** is a number (`uid`) the kernel stamps on processes and files. A **group** is another number (`gid`) plus a membership list. Names in `/etc/passwd` and `/etc/group` are a phone book. The kernel does not love names. It loves integers.

**SRE why:** The app cannot write `/var/log/myapp` because it runs as `www-data` (uid 33) and the directory is owned by `root`. 'Permission denied' is an identity mismatch until proven otherwise.

## 5-minute lab

```bash
id
getent passwd $(whoami)
getent group $(id -gn)
ls -n /home | head
```

## Check yourself

`ls -l` shows `unknown 1002`. The app still runs. What is 1002, and is the app broken?
