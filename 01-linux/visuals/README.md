# Linux visual encyclopedia

**Every Linux concept in this module** has a diagram-first page here (or linked from Week 1).  
Read the picture, narrate it, then open the full 25-section doc.

Videos and free courses: [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## Fundamentals

| Concept | Visual | Full doc |
| ------- | ------ | -------- |
| What Linux is | [week-01](../weeks/week-01/visuals/01-what-is-linux.md) | [doc](../fundamentals/what-is-linux.md) |
| Kernel vs user space | [week-01](../weeks/week-01/visuals/02-kernel-vs-user-space.md) · [img](../weeks/week-01/visuals/images/kernel-vs-userspace.png) | [doc](../fundamentals/kernel-vs-user-space.md) |
| Terminal vs shell | [week-01](../weeks/week-01/visuals/03-terminal-vs-shell.md) · [img](../weeks/week-01/visuals/images/terminal-shell-kernel.png) | [doc](../fundamentals/shell-vs-terminal.md) |
| Why SRE needs Linux | [week-01](../weeks/week-01/visuals/01-what-is-linux.md) | [doc](../fundamentals/why-sre-needs-linux.md) |

## Filesystem & files

| Concept | Visual | Full doc |
| ------- | ------ | -------- |
| FHS | [week-01](../weeks/week-01/visuals/04-filesystem-hierarchy.md) · [img](../weeks/week-01/visuals/images/fhs-tree.png) | [doc](../filesystem/filesystem-hierarchy.md) |
| Paths | [week-01](../weeks/week-01/visuals/05-paths.md) · [img](../weeks/week-01/visuals/images/paths-absolute-relative.png) | [doc](../filesystem/paths.md) |
| Files, cp/mv/rm | [files-and-directories.md](files-and-directories.md) · [img](images/files-cp-mv-rm.png) | [doc](../filesystem/files-and-directories.md) |
| Inodes | [week-01](../weeks/week-01/visuals/07-inodes-and-mounts.md) · [img](../weeks/week-01/visuals/images/inode-vs-name.png) | [doc](../disk/disk-and-inodes.md) |
| Mounts | [week-01](../weeks/week-01/visuals/07-inodes-and-mounts.md) · [img](../weeks/week-01/visuals/images/mounts-and-full-disk.png) | [doc](../filesystem/mounts.md) |

## Commands

| Concept | Visual | Full doc |
| ------- | ------ | -------- |
| pwd / ls / cd | [week-01](../weeks/week-01/visuals/06-pwd-ls-cd.md) · [img](../weeks/week-01/visuals/images/cd-internal.png) | [pwd](../commands/pwd.md) · [ls](../commands/ls.md) · [cd](../commands/cd.md) |
| cat / less / head / tail | [viewing-text.md](viewing-text.md) | [doc](../commands/viewing-text.md) |
| find and globs | [find-and-glob.md](find-and-glob.md) | [doc](../commands/find-and-glob.md) |
| Editors | [editors.md](editors.md) | [doc](../commands/editors.md) |

## Users & permissions

| Concept | Visual | Full doc |
| ------- | ------ | -------- |
| Users and groups | [users-and-groups.md](users-and-groups.md) · [img](images/users-groups-sudo.png) | [doc](../users-permissions/users-and-groups.md) |
| Permissions / chmod | [../weeks/week-03/visuals/permissions.md](../weeks/week-03/visuals/permissions.md) · [img](../weeks/week-03/visuals/images/permission-bits.png) | [doc](../users-permissions/permissions.md) |
| Ownership / sticky / setgid | [ownership.md](ownership.md) | [doc](../users-permissions/ownership.md) |
| sudo | [sudo-intro.md](sudo-intro.md) · [img](images/users-groups-sudo.png) | [doc](../users-permissions/sudo-intro.md) |

## Processes, CPU, memory

| Concept | Visual | Full doc |
| ------- | ------ | -------- |
| What a process is | [../weeks/week-04/visuals/processes.md](../weeks/week-04/visuals/processes.md) · [img](../weeks/week-04/visuals/images/process-and-signals.png) | [doc](../processes/what-is-a-process.md) |
| ps and top | [ps-and-top.md](ps-and-top.md) | [doc](../processes/ps-and-top.md) |
| Signals | [signals.md](signals.md) | [doc](../processes/signals.md) |
| /proc | [proc-filesystem.md](proc-filesystem.md) | [doc](../processes/proc-filesystem.md) |
| Load average | [../weeks/week-05/visuals/README.md](../weeks/week-05/visuals/README.md) · [img](../weeks/week-05/visuals/images/load-average.png) | [doc](../cpu/load-average.md) |
| CPU / iowait / steal | [cpu-saturation.md](cpu-saturation.md) · [img](images/cpu-iowait-steal.png) | [doc](../cpu/cpu-saturation.md) |
| Memory / OOM | [memory.md](memory.md) · [img](images/memory-rss-cache-oom.png) | [doc](../memory/memory.md) |

## Disk, I/O, systemd, logs, SSH

| Concept | Visual | Full doc |
| ------- | ------ | -------- |
| Disk full vs inode full | [disk-and-inodes.md](disk-and-inodes.md) | [doc](../disk/disk-and-inodes.md) |
| I/O wait | [io.md](io.md) | [doc](../io/io.md) |
| systemd | [systemd.md](systemd.md) · [img](images/systemd-units.png) | [doc](../systemd/systemd.md) |
| journalctl / logs | [journals-and-logs.md](journals-and-logs.md) | [doc](../logs/journals-and-logs.md) |
| cron vs timers | [cron-and-timers.md](cron-and-timers.md) · [img](images/cron-vs-timers.png) | [doc](../systemd/cron-and-timers.md) |
| SSH | [ssh.md](ssh.md) · [img](images/ssh-keys.png) | [doc](../ssh/ssh.md) |

## Troubleshooting, bash, this-host networking

| Concept | Visual | Full doc |
| ------- | ------ | -------- |
| Troubleshooting method | [linux-troubleshooting-method.md](linux-troubleshooting-method.md) | [doc](../troubleshooting/linux-troubleshooting-method.md) |
| strace | [strace-intro.md](strace-intro.md) · [img](images/strace-syscalls.png) | [doc](../troubleshooting/strace-intro.md) |
| Bash essentials | [bash-essentials.md](bash-essentials.md) · [img](images/bash-quoting-pipes.png) | [doc](../bash/bash-essentials.md) |
| ip / ss / curl | [ip-ss-curl.md](ip-ss-curl.md) · [img](images/linux-net-ip-ss.png) | [doc](../networking/ip-ss-curl.md) |

## How to use

1. Open the visual. Narrate it without scrolling.
2. Do the 5-minute lab on the visual page.
3. Open the full doc only for the sections you cannot explain.
4. Resources are optional and capped at 20–30 min/night.
