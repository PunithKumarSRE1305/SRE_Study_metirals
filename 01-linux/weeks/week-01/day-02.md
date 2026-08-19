# Week 01, Day 2 — The filesystem is a map, not a junk drawer

- Time box: 120 minutes

## Objective

Predict where things live on a Linux box, and explain *why* `/etc` is not `/var` and `/proc` is not a disk.

## Time plan

```text
Theory + examples        40 min
Concept docs             20 min
Hands-on                 40 min
Challenge                10 min
Revision                 10 min
```

## Theory

A filesystem is a **namespace** — a way to name bytes — that happens to look like a tree.

```text
                         /
         ┌──────┬────────┼────────┬─────────┐
       bin    etc       home     usr       var
        │      │         │        │         │
      ls     passwd    you     share      log
                         │                  │
                       files             syslog
```

Important opinions of the Filesystem Hierarchy Standard (FHS):

| Path | Kind of thing | Survives reboot? | You edit it? |
| ---- | ------------- | ---------------- | ------------ |
| `/bin`, `/usr/bin` | programs | yes | no (package manager does) |
| `/etc` | configuration | yes | yes, carefully |
| `/home`, `/root` | people | yes | yes |
| `/var` | variable data: logs, caches, queues | yes, and it *grows* | rarely by hand |
| `/tmp` | scratch | often **no** | yes, expect deletion |
| `/proc` | kernel's live view of itself | no — not real files | you read; writes are knobs |
| `/sys` | devices / kernel objects | no | sometimes knobs |
| `/dev` | device nodes | nodes recreated | special |
| `/opt` | optional third-party | yes | app-specific |
| `/boot` | kernel + bootloader | yes | almost never at 02:00 |

### The SRE instinct

When something is "full," **which branch grew?**  
When a config "didn't apply," **which file did the process actually read?**  
When a teammate says "check the logs," **which directory, which unit, which permission?**

### `/proc` is not a folder of documents

```text
cat /proc/uptime
```

That is the kernel answering a question, dressed as a file. This pattern — **everything is a file** — is not cute. It is the API.

### PT bridge

Your monitoring agent that reports disk % is usually watching a *mount*, not "the computer." A 100% `/var` and a healthy `/` can coexist. Load tests that write logs can fill `/var` and then look like "the app died" — it did, because it could not write.

## Visual first

[`visuals/04-filesystem-hierarchy.md`](visuals/04-filesystem-hierarchy.md)

## Docs

- [`../../filesystem/filesystem-hierarchy.md`](../../filesystem/filesystem-hierarchy.md)
- start [`../../filesystem/paths.md`](../../filesystem/paths.md)

## Hands-on

```bash
ls -l /
readlink -f /bin /usr/bin || true
ls /etc | head
ls /var
ls /var/log
ls /proc | head
cat /proc/uptime
cat /proc/sys/kernel/hostname
df -h
findmnt
```

Write a table in your log:

| Path I opened | What I think it is | Evidence |
| ------------- | ------------------ | -------- |

Include at least `/`, `/etc`, `/var/log`, `/proc`, and whatever `df` says is largest.

## Challenge

`df -h` shows `/` at 40% used. The application cannot write logs and is returning 500s. Give **three** hypotheses that are still possible. You do not need to prove them today.

## Revision

From memory: list 8 top-level directories and one sentence each. Then check.

## Log

Paste `df -h` and `ls /`. No 🟢.
