# Week 01, Day 5 — Advanced: inodes, mounts, and why FHS is opinionated

- Time box: 120 minutes

## Objective

Go one layer under the tree picture:

- A filename is a label on an **inode**
- A directory is a list of names → inode numbers
- A **mount** stitches another tree onto a path
- `df` reports mounts, not "the computer"

You do not need to become a filesystem developer. You need to stop saying "the disk" when you mean "this mount."

## Time plan

```text
Theory                    30 min
Docs reread (FHS + paths) 20 min
Hands-on                  45 min
Challenge                 15 min
Revision                  10 min
```

## Theory

```text
Directory "/var/log"
  name "syslog"  --> inode 204812
                      ├── metadata: owner, mode, timestamps, size
                      └── data blocks: the bytes of the log

Delete the name: the inode may still live if a process has the file open.
That is why "I deleted the log but df still says 100%."
```

```text
Mount table (simplified)

  device          path     type
  /dev/xvda1      /        ext4
  /dev/xvdb       /var     ext4
  tmpfs           /tmp     tmpfs
  proc            /proc    proc

Fill /var,  /  can still be empty.
```

### Why `/etc` vs `/var`

- `/etc` — the *intent* (config). Should be small, backup-able, in git later.
- `/var` — the *life* of the machine (logs, spool, cache). Grows. Rotates. Fills.

Mixing them is how appliances become un-debugable.

### PT bridge

If your soak test writes 2 GB of application logs per hour, you are capacity-planning **the log mount**, not "CPU." SREs who grew up in performance testing often miss this because the APM graph still looks fine until the write() fails.

## Visual first

[`visuals/07-inodes-and-mounts.md`](visuals/07-inodes-and-mounts.md)

## Hands-on

```bash
stat "$HOME"
stat /var/log
ls -li /var/log | head
df -h
df -i
findmnt
mount | head
readlink -f /etc/os-release
```

If `df -i` is new: inodes can exhaust while `df -h` looks fine (millions of tiny files). That is a real outage class.

Create two names for one file (hard link) in your lab dir only:

```bash
LAB="$HOME/sre-lab/week01-inodes"
mkdir -p "$LAB"
echo hello > "$LAB/a.txt"
ln "$LAB/a.txt" "$LAB/b.txt"
ls -li "$LAB"
echo world >> "$LAB/b.txt"
cat "$LAB/a.txt"
```

Write: what did you just prove?

Do **not** hard-link directories. Do **not** run `ln` on system files.

## Challenge

A host has:

```text
df -h
/dev/xvda1   8G   3G   5G  38%  /
/dev/xvdb    4G   4G   0   100% /var

df -i
/dev/xvdb    inodes 100% used
```

The app logs to `/var/log/myapp/` and also sometimes writes `/tmp`.  
Users see 503s.  
What is full? What is not? What do you *not* delete first? What do you check about `/tmp`?

## Revision

From memory: inode vs filename vs mount. Three sentences.

## Log

`df -h`, `df -i`, `ls -li` of your hard-link experiment. No 🟢.
