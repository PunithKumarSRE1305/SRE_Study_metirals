# All Linux concepts — free resources

Videos are optional. Cap **20–30 minutes/night**. A concept is 🟢 only after assessment.

Standing stack (use all year): [LFS101](https://training.linuxfoundation.org/training/introduction-to-linux/) · [Shotts book](https://linuxcommand.org/tlcl.php) · [Linux Journey](https://labex.io/linuxjourney) ([source](https://github.com/labex-labs/linuxjourney)) · [Bandit](https://overthewire.org/wargames/bandit/) · [Killercoda](https://killercoda.com/) · [man7](https://man7.org/linux/man-pages/) · [LearnLinuxTV crash](https://www.youtube.com/playlist?list=PLT98CRl2KxKHKd_tH3ssq0HPrThx2hESW) · [LearnLinuxTV commands](https://www.youtube.com/playlist?list=PLT98CRl2KxKHaKA9-4_I38sLzK134p4GJ) · [freeCodeCamp crash](https://www.youtube.com/watch?v=ROjZy1WbCIA)

| Concept | Week | Official / OSS | YouTube (search title if renamed) |
| ------- | ---- | -------------- | --------------------------------- |
| What Linux is | W01 | LFS101 ch. philosophy | LearnLinuxTV crash — first intro eps |
| Kernel vs user space | W01 | [docs.kernel.org](https://docs.kernel.org/) (skim) | freeCodeCamp crash — OS basics only |
| Terminal vs shell | W01 | Shotts ch. 1 | LearnLinuxTV commands — shell intro |
| Why SRE needs Linux | W01 | This repo | — |
| FHS | W01 | [FHS 3.0](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html) | [FHS crash course](https://www.youtube.com/watch?v=1gyFsm9oHzI) |
| Paths | W01 | Shotts ch. 2 | LearnLinuxTV — pwd/cd |
| pwd / ls / cd | W01 | `help cd` · `man ls` · [explainshell](https://explainshell.com/) | LearnLinuxTV commands playlist |
| Files, cp/mv/rm | W02 | Shotts ch. 4–5 · Bandit 1–8 | LearnLinuxTV — cp/mv/rm |
| cat/less/head/tail | W02 | `man tail` · Shotts ch. 3, 8 | LearnLinuxTV — viewing files |
| find + globs | W02 | Shotts ch. 17 · `man find` | LearnLinuxTV — find |
| Editors | W02 | LFS101 editors · `vimtutor` (optional 15 min) | — (do the lab, not a vim course) |
| Users and groups | W03 | `man 5 passwd` · Linux Journey users | LearnLinuxTV crash — users |
| Permissions / chmod | W03 | [DO permissions](https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-permissions) · [DO chmod](https://www.digitalocean.com/community/tutorials/how-to-set-permissions-linux) | [LearnLinuxTV permissions](https://www.youtube.com/watch?v=4e669hSjaX8) · [chmod tutorial](https://www.youtube.com/watch?v=SCdAvU46ZUc) |
| Ownership / sticky / setgid | W03 | `man chmod` · `man chown` | LearnLinuxTV permissions (same) |
| sudo | W03 | `man sudoers` · LFS101 security | LearnLinuxTV — sudo |
| What a process is | W04 | Shotts ch. 10 · `man 7 credentials` | LearnLinuxTV — processes |
| ps / top | W04 | `man ps` · `man top` | LearnLinuxTV commands — ps/top |
| Signals | W04 | [man 7 signal](https://man7.org/linux/man-pages/man7/signal.7.html) | LearnLinuxTV — kill |
| Load average | W05 | [Brendan Gregg — Linux Performance](https://www.brendangregg.com/linuxperf.html) | LearnLinuxTV — top / load |
| CPU / iowait / steal | W05 | Gregg · `man vmstat` | LearnLinuxTV crash — monitoring |
| Memory / OOM | W05 | `man free` · Ubuntu server docs | Search LearnLinuxTV “memory” |
| /proc | W05 | [proc(5)](https://man7.org/linux/man-pages/man5/proc.5.html) | — (read /proc yourself) |
| Disk vs inodes | W06 | `man df` · FHS | LearnLinuxTV — df/du |
| I/O wait | W06 | Gregg · `man iostat` | Search “iostat iowait Linux” on LearnLinuxTV |
| Mounts | W06 | `man fstab` · `man findmnt` | LearnLinuxTV crash — storage |
| systemd | W07 | [systemd.io](https://systemd.io/) · [manuals](https://www.freedesktop.org/software/systemd/man/latest/) | Search LearnLinuxTV “Managing Services with systemd” |
| journalctl / /var/log | W07 | `man journalctl` · Ubuntu logs | LearnLinuxTV — journalctl |
| cron vs timers | W07 | `man 5 crontab` · systemd.timer(5) | LearnLinuxTV — cron |
| SSH | W08 | [DO SSH essentials](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys) · Bandit lvl 0 | Search LearnLinuxTV “SSH” |
| Troubleshooting method | W09 | This repo + [failure-engineering](../../system/failure-engineering.md) | Do **not** watch “troubleshoot Linux in 60s” |
| strace | W09 | `man strace` · Gregg | Use after logs/df/top — not a beginner binge |
| Bash essentials | W10 | Shotts ch. 24–26 · [GNU bash manual](https://www.gnu.org/software/bash/manual/) · [tldr](https://tldr.sh/) | LearnLinuxTV — bash (one episode) |
| ip / ss / curl | W07–W11 | `man ip` `man ss` · [Cisco Networking Basics](https://www.netacad.com/courses/networking-basics?courseLang=en-US) | [PowerCert channel](https://www.youtube.com/@PowerCertAnimatedVideos) for layers; LearnLinuxTV networking |

## Free courses / badges (honest)

| Item | Free? | When |
| ---- | ----- | ---- |
| LFS101 Introduction to Linux | Course yes, cert paid | Audit Months 1–3 |
| Cisco Networking Basics | Yes + digital badge | Weeks 11–15 |
| LFS162 Intro to DevOps/SRE | Course yes | After Month 6 |
| LFCA / Linux+ / RHCSA | **Paid exams** | Not this quarter |

## Visual encyclopedia

[`../visuals/README.md`](../visuals/README.md)
