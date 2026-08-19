# Week 06 — free resources

**This week:** Disk, filesystems, inodes, I/O

Videos are optional. Cap 20–30 minutes. The week file in this folder is the lesson.

## Concepts this week

| `df` vs `du` | Mount usage vs directory walk. They can disagree. |
| Inode exhaustion | `df -i` at 100% with `df -h` healthy. |
| Deleted-but-open files | The soak-test log you `rm`'d is still filling the disk. |
| I/O wait | The CPU is idle *because* the disk is not. |
| Mounts / fstab idea | A path is a stitch between trees. |

## Official / open tutorials

| Concept | Resource |
| ------- | -------- |
| FHS (revisit) | [FHS 3.0](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html) |
| df / du | `man df` `man du` — [man7 df](https://man7.org/linux/man-pages/man1/df.1.html) |
| Inodes | Shotts + [Linux Journey](https://labex.io/linuxjourney) filesystem pages |
| I/O | [Brendan Gregg — Linux Performance](https://www.brendangregg.com/linuxperf.html) |
| Ubuntu storage | [Ubuntu Server docs](https://documentation.ubuntu.com/server/) |

## YouTube

| Concept | Watch |
| ------- | ----- |
| FHS recap | [How to understand the FHS](https://www.youtube.com/watch?v=1gyFsm9oHzI) |
| Disk commands | [LearnLinuxTV commands](https://www.youtube.com/playlist?list=PLT98CRl2KxKHaKA9-4_I38sLzK134p4GJ) — `df` `du` episodes |

## Free cert / badge

None. The drill is: fill a **lab VM** disk on purpose. Not production.


## Rule

A playlist is not a substitute for the lab. Do not mark this week 🟢 because you watched something.
