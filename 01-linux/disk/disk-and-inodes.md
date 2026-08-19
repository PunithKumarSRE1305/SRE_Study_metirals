# Disk full vs inode full

**Week:** W06 · **Visual:** [`../visuals/disk-and-inodes.md`](../visuals/disk-and-inodes.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

A filesystem can run out of **bytes** (`df -h`) or **inodes** (`df -i`) independently. Millions of tiny files exhaust inodes while `df -h` looks fine. `du` walks names; `df` asks the filesystem — they disagree when files are deleted but open, or when a mount hides a full directory.

## 2. Why does it exist?

Two different resources, two different outages, one 'disk full' ticket.

## 3. Why do I need to know this as an SRE?

Always run both `df -h` and `df -i`. Then `du -x` on the guilty mount. Then look for deleted-open files.

## 4. Real-world analogy

A warehouse can be out of floor space (bytes) or out of inventory stickers (inodes) while the floor looks empty.

## 5. How does it work internally?

Creating a file allocates an inode + data blocks. Tiny files still consume an inode each. `unlink` frees the inode only when nlink=0 and no fds remain. Mounts stitch devices onto paths; `du` without `-x` crosses them.

## 6. Syntax / structure

```bash
df -h
df -i
du -xh --max-depth=1 /var 2>/dev/null
# deleted-open:
sudo lsof +L1 | head
```

## 7. Basic example

```bash
df -h; df -i
```

## 8. Step-by-step execution

1. Identify the mount (`df -h PATH`).
2. Check inodes (`df -i`).
3. If bytes: `du -x`.
4. If mismatch: lsof deleted.
5. If inodes: find directories with huge file counts.

## 9. Why would I use this?

Any 503 that smells like writes failing. Capacity of log mounts.

## 10. When should I NOT use it?

Do not `rm -rf /var/log` blindly. Do not reboot as the first inode fix (it may close fds — sometimes that is the mitigation, but know why).

## 11. Alternative ways

ncdu is a nicer du. logrotate is prevention.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| df -h | bytes | fast | not inodes | always |
| df -i | inodes | fast | not which dir | always |
| du -x | where | answers which tree | slow | next |
| lsof +L1 | deleted-open | explains df-du gap | needs privilege | when they disagree |

## 13. Common mistakes

- Only checking `/`
- du without -x
- Deleting the directory the app has open

## 14. Troubleshooting

**df 100%, du small:** deleted-open or a mount overlay. **df -i 100%:** lots of tiny files (caches, session dirs, bad deploy).

## 15. Production relevance

Debug logging + no rotation = this ticket every quarter. Prevention is rotation + alerts on mount % and inode %.

## 16. Security considerations

Do not delete unknown files in /var to 'make space' — you may remove audit logs.

## 17. Performance considerations

du on a huge tree is I/O heavy. nice it. Scope it.

## 18. Related concepts

```text
inodes → mounts → logs → lsof → logrotate
```

## 19. Visual diagram

```text
df -h 100%  → bytes on that mount
df -i 100%  → no inodes left
du << df    → deleted-open or hidden under a mount
```

## 20. Hands-on exercise

```bash
df -h; df -i
du -xh --max-depth=1 "$HOME" 2>/dev/null | sort -h | tail
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

df -h / 38%, df -h /var 100%, df -i /var 100%. What is full? What do you not delete first?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** df vs du?
- **Intermediate:** What is inode exhaustion?
- **Advanced:** How can deleting a log not free space?

## 23. SRE scenario

503s after a soak. /var inodes 100%. Session files in /var/lib/app/tmp. You purge with a known predicate, add a tmp cleaner, alert df -i.

## 24. Summary

Bytes and inodes are different. df both. du -x. lsof for ghosts.

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

- Here is what you already know from performance testing: Soak tests that create many tiny result files.
- Here is the SRE equivalent: That is inode capacity planning.
- Here is what you need to learn next: I/O wait.
