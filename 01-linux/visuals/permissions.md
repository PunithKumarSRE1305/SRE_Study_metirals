# Visual: Permission bits, chmod, octal

Full doc: [`../users-permissions/permissions.md`](../users-permissions/permissions.md)

![Permission bits, chmod, octal](../weeks/week-03/visuals/images/permission-bits.png)

```text
-rwxr-x---  app deploy  app.sh
 USER rwx=7  GROUP r-x=5  OTHER ---=0   →  750
dir: r=list  w=create/delete  x=enter
```

## Walk it

Every inode has a **mode**: type plus three triads of `rwx` for **user** (owner), **group**, and **other**. `chmod` changes those bits. Octal `754` is 7=rwx, 5=r-x, 4=r--.

**SRE why:** `chmod 777` is not a fix. It is an incident. You must predict whether *this* uid can write *this* file.

## 5-minute lab

```bash
f=$HOME/sre-lab/perm.txt; echo x > "$f"
chmod 600 "$f"; ls -l "$f"
chmod 644 "$f"; ls -l "$f"
mkdir -p "$HOME/sre-lab/locked"; chmod 700 "$HOME/sre-lab/locked"
```

## Check yourself

A teammate cannot `cd /opt/app/conf` but can `ls /opt/app`. Which bit is missing, on which inode?
