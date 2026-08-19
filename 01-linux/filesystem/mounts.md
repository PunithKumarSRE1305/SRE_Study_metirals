# Mounts and fstab

**Week:** W06 · **Visual:** [`../visuals/mounts.md`](../visuals/mounts.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

A **mount** attaches a filesystem (device, NFS, tmpfs, proc) onto a directory in the tree. After mount, that path *is* the other filesystem. `fstab` is the table of mounts to apply at boot.

## 2. Why does it exist?

One tree, many devices. Capacity, performance, and failure domains are per mount.

## 3. Why do I need to know this as an SRE?

`df -h /` is not `df -h /var`. A full `/var` with a healthy `/` is the default lie. A stale NFS mount makes `ls` hang forever.

## 4. Real-world analogy

A hallway (the path) that suddenly becomes a different building when you cross the mat (the mount point).

## 5. How does it work internally?

The kernel VFS walks components. When it hits a mount point, it continues in the mounted superblock. `findmnt`/`cat /proc/mounts` lists them. `umount` fails if busy (open fds, cwd inside).

## 6. Syntax / structure

```bash
findmnt
df -h
lsblk
# inspect, do not change fstab on a whim
cat /etc/fstab
```

## 7. Basic example

```bash
findmnt
df -hT
```

## 8. Step-by-step execution

1. Look up the path's mount (`findmnt PATH` or `df PATH`).
2. Note fstype (ext4, xfs, nfs, tmpfs, overlay).
3. Ask: is this local? size? options (ro, noexec)?

## 9. Why would I use this?

Every disk ticket. Understand /tmp as tmpfs. Understand container overlay vs volumes.

## 10. When should I NOT use it?

Do not umount production data to 'see if it helps'. Do not edit fstab without a console path.

## 11. Alternative ways

bind mounts and overlayfs (containers) are mounts too.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| findmnt | the map | clear | busy output | first |
| df -hT | space + type | familiar | one line per mount | tickets |
| /proc/mounts | raw | complete | ugly | when tools disagree |

## 13. Common mistakes

- Assuming one disk
- Filling a bind-mount and blaming the wrong device
- fstab typo → box will not boot

## 14. Troubleshooting

**ls hangs:** likely stale NFS. **umount: target is busy:** lsof/fuser the mount, or you have a cwd there. **tmpfs /tmp full:** memory, not disk.

## 15. Production relevance

Separating /var/log onto its own volume is a reliability decision so logs cannot kill the OS.

## 16. Security considerations

noexec, nosuid, nodev on user-writable mounts. NFS root_squash. Secrets on the wrong mount get snapshotted.

## 17. Performance considerations

NFS latency becomes app latency. Local SSD vs network disk is a p99 story.

## 18. Related concepts

```text
FHS → mounts → df → NFS hang → containers later
```

## 19. Visual diagram

```text
/dev/xvda1  →  /        ext4
/dev/xvdb   →  /var     ext4     ← often the one that fills
tmpfs       →  /tmp
proc        →  /proc
```

## 20. Hands-on exercise

```bash
findmnt | head -20
df -hT
findmnt -T /var/log
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

df / is 20%. App cannot write /tmp. What kind of filesystem might /tmp be, and what is actually exhausted?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** What is a mount?
- **Intermediate:** Why can / and /var disagree?
- **Advanced:** Why does umount fail with busy?

## 23. SRE scenario

New AMI put /var on the root disk. Logs filled `/` and SSH keys could not be written. You split the volume in Terraform next sprint.

## 24. Summary

Paths hide devices. Always ask which mount. fstab is boot-critical.

## 25. Knowledge checklist

- [ ] I understand what this is
- [ ] I understand why it exists
- [ ] I can explain it
- [ ] I can use it
- [ ] I can troubleshoot it
- [ ] I can explain its alternatives
- [ ] I can apply it in production
- [ ] I can answer interview questions

### Performance-testing bridge

- Here is what you already know from performance testing: You already know tests can fill a disk.
- Here is the SRE equivalent: They fill a *mount*. Name it.
- Here is what you need to learn next: systemd — who starts the writer.
