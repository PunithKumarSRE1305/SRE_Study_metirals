# Week 01, Day 6 — Mini-project: map a real system

- Time box: 120 minutes
- This is a project day. The artifact is a markdown map, not a feeling of familiarity.

## Objective

Produce `01-linux/projects/week01-system-map.md` (or `progress/daily-logs/` if you prefer privacy) that another engineer could use to land on *your* lab box.

## Time plan

```text
Collect facts             50 min
Write the map             40 min
Self-review against rubric 20 min
Cleanup / notes           10 min
```

## What to collect (commands are suggestions, not a script to paste blindly)

```bash
hostnamectl 2>/dev/null || hostname
cat /etc/os-release
uname -a
whoami; id
echo "$SHELL"
pwd
ls /
df -h
df -i
findmnt
ls /var/log
ls /etc | wc -l
```

Then **walk** five paths and write what they are for on this box:

- `/`
- `/etc`
- `/var/log`
- `/home` or your home
- `/proc`

## Map template

```markdown
# System map — <hostname>
Date:
Distro:
Kernel:
Why this box exists (lab VM / WSL / cloud):

## Identity
- hostname:
- user:
- shell:

## Mounts
| Mount | Size | Used | Inodes used | Notes |
| ----- | ---- | ---- | ----------- | ----- |

## Top-level /
| Path | What it holds here | Anything surprising |

## Logs I would open first
|

## How I navigate
- Home:
- A command that failed today and why:

## PT bridge
If I load-tested an app on this box, which mount would logs fill first?

## Unknowns
Things I still cannot explain:
```

## Rubric (self-score, honestly)

| Dimension | Weight | 0–2 |
| --------- | -----: | --- |
| Facts collected (not guessed) | 30 |  |
| Mounts understood | 20 |  |
| FHS applied to *this* box | 20 |  |
| Honest unknowns | 15 |  |
| Readable by future you | 15 |  |

Passing this *project* is informal. It does **not** complete Week 1. Day 7 does.

If you score yourself below 70%, add the gaps to `progress/weak-areas.md` as self-reported.

## Challenge

Add a section "If disk is 100% at 02:00" with the first five commands you would run **on this box**, in order, and why the order is that order.

## What not to do

- Do not spend the evening ricing your prompt
- Do not install a new distro
- Do not start `vim` tutorials
- Do not "just peek" at systemd

## Log

Link to the map file. Minutes. Self-score. No 🟢.
