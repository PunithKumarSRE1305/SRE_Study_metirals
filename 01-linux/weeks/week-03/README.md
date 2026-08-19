# Week 03 — Users, groups, permissions

**Status:** ⚪ outline only. Opens after Week 02 🟢.

## Objective

Read `-rwxr-x---` without guessing. Predict whether a given process can write a given file. Stop using `chmod 777`.

## Planned days

| Day | Mode | Topics |
| --- | ---- | ------ |
| 1 | Theory | Users, groups, `/etc/passwd`, `/etc/group`, what a uid is |
| 2 | Examples | `rwx` bits, octal, `chmod`, `umask` |
| 3 | Hands-on | Create a user in the *lab*, break and fix write access to a log file |
| 4 | Troubleshooting | App cannot write its log; `ls -l` vs process `uid` |
| 5 | Advanced | `chown`, sticky bit on `/tmp`, setgid directories (idea) |
| 6 | Project | Permission model for a fake app user |
| 7 | Assessment | Includes a hard fail if you recommend `chmod -R 777` |

## PT bridge

The "user" the load generator runs as is not the user the app runs as. Permission bugs look like 500s under load if only the worker threads hit the write path.

## This week also has

- [resources.md](resources.md) — free videos, official courses, OSS labs
- [visuals/](visuals/README.md) — diagram-first concept pages
