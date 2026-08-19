# Visual: Mounts and fstab

Full doc: [`../filesystem/mounts.md`](../filesystem/mounts.md)


```text
/dev/xvda1  →  /        ext4
/dev/xvdb   →  /var     ext4     ← often the one that fills
tmpfs       →  /tmp
proc        →  /proc
```

## Walk it

A **mount** attaches a filesystem (device, NFS, tmpfs, proc) onto a directory in the tree. After mount, that path *is* the other filesystem. `fstab` is the table of mounts to apply at boot.

**SRE why:** `df -h /` is not `df -h /var`. A full `/var` with a healthy `/` is the default lie. A stale NFS mount makes `ls` hang forever.

## 5-minute lab

```bash
findmnt | head -20
df -hT
findmnt -T /var/log
```

## Check yourself

df / is 20%. App cannot write /tmp. What kind of filesystem might /tmp be, and what is actually exhausted?
