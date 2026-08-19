# Visual: Ownership, chown, sticky bit, setgid

Full doc: [`../users-permissions/ownership.md`](../users-permissions/ownership.md)


```text
shared/   drwxrwsr-x  app  deploy   (setgid)
   new.log  -rw-rw-r--  app  deploy  ← group inherited
/tmp      drwxrwxrwt                 (sticky t)
```

## Walk it

**Ownership** is the uid/gid stored on the inode. `chown`/`chgrp` change it. The **sticky bit** on a directory (like `/tmp`) means only the file's owner (or root) can delete the name. **setgid** on a directory makes new files inherit the directory's group — the shared-team-dir pattern.

**SRE why:** A deploy user writes logs as `deploy`. The app runs as `app`. Without the right group + setgid, you get 403/500 after every release.

## 5-minute lab

```bash
ls -ld /tmp
stat -c '%a %A %U %G' /tmp
mkdir -p "$HOME/sre-lab/shared"
chmod 2775 "$HOME/sre-lab/shared"
ls -ld "$HOME/sre-lab/shared"
```

## Check yourself

Design mode+owner+group for `/var/log/myapp` so the app can write, a `support` group can read, and others cannot.
