# Week 09 — free resources

**This week:** Linux troubleshooting method

Videos are optional. Cap 20–30 minutes. The week file in this folder is the lesson.

## Concepts this week

| Observe → hypothesize → test | Random commands are not a method. |
| What layer is sick? | CPU, mem, disk, net, perms, config, dependency. |
| `strace` intro | Last-mile: the syscalls the process is actually issuing. |
| Resource exhaustion playbook | Full disk, OOM, fd limit, load. |
| Write a postmortem of a drill | If you only restarted it, the exercise failed. |

## Official / open tutorials

| Concept | Resource |
| ------- | -------- |
| Method | This repo — `01-linux/troubleshooting/` |
| strace | `man strace` · [Linux Journey](https://labex.io/linuxjourney) |
| Perf map | [Brendan Gregg](https://www.brendangregg.com/linuxperf.html) |
| Postmortem template | [`../../../system/templates/postmortem.md`](../../../system/templates/postmortem.md) |
| Failure loop | [`../../../system/failure-engineering.md`](../../../system/failure-engineering.md) |

## YouTube

| Concept | Watch |
| ------- | ----- |
| Recap under pressure | Re-watch only the **one** LearnLinuxTV episode that matches the failing layer |
| Avoid | “Linux troubleshooting in 60 seconds” list videos |

## Free cert / badge

None. A written drill postmortem is the artifact.


## Rule

A playlist is not a substitute for the lab. Do not mark this week 🟢 because you watched something.
