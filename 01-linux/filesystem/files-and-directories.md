# Files and directories — create, copy, move, remove

**Week:** W02 · **Visual:** [`../visuals/files-and-directories.md`](../visuals/files-and-directories.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

A **file** is bytes plus an inode. A **directory** is a list of names → inode numbers. `touch`/`mkdir` create names. `cp` copies bytes into a new inode. `mv` usually only changes a name. `rm` removes a name (unlink). It does not securely erase, and it does not always free disk.

## 2. Why does it exist?

Programs and humans need to create, relocate, and delete data. Unix split 'the name' from 'the object' so many names can point at one inode, and so a running process can keep a deleted file alive.

## 3. Why do I need to know this as an SRE?

The classic 02:00 ticket: 'I deleted the 40 GB log and `df` is still 100%.' If you think `rm` always frees space, you will reboot instead of finding the open file descriptor.

## 4. Real-world analogy

A library card (the name) vs the book in the stacks (the inode). Throwing away the card does not burn the book if someone is still reading it.

## 5. How does it work internally?

`mkdir` creates a directory inode and a name in the parent. `touch` creates an empty regular file or updates timestamps. `cp` reads the source and writes a new inode (unless you copy a directory recursively). `mv` on the **same filesystem** is `rename(2)` — a directory-entry change. `mv` **across** filesystems is copy + delete. `rm` is `unlink(2)`: drop one name. When the link count hits 0 **and** no process has the file open, the kernel frees the blocks.

## 6. Syntax / structure

```bash
mkdir -p PATH
touch FILE
cp -a SRC DST
mv SRC DST
rm -i FILE
rmdir DIR   # empty dirs only
```

## 7. Basic example

```bash
mkdir -p "$HOME/sre-lab/w02"
echo hello > "$HOME/sre-lab/w02/a.txt"
cp "$HOME/sre-lab/w02/a.txt" "$HOME/sre-lab/w02/b.txt"
mv "$HOME/sre-lab/w02/b.txt" "$HOME/sre-lab/w02/c.txt"
ls -li "$HOME/sre-lab/w02"
```

## 8. Step-by-step execution

1. Shell expands globs and quotes, then `exec`s `/usr/bin/cp` (or `mv`, `rm`).
2. The tool issues `open`/`read`/`write`/`rename`/`unlink` syscalls.
3. The kernel updates directory entries and inode link counts.
4. If a name is gone but an fd is open, `df` does not drop.
5. A failed `rm` of a directory without `-r` leaves everything in place.

## 9. Why would I use this?

Build lab trees. Relocate configs you own. Remove logs **after** you confirm rotation and that nothing has the file open (`lsof` / `/proc/*/fd`).

## 10. When should I NOT use it?

Do not `rm -rf /` or `rm -rf *` after a failed `cd`. Do not `cp` huge data across a dying disk as a 'backup' during an incident. Do not `mv` a live database file.

## 11. Alternative ways

Prefer explicit paths. Prefer `rm -i` until muscle memory is safe. Prefer `find … -delete` only when you can state the predicate out loud.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| `cp -a` | preserve mode, times, links | honest copy | doubles space | archives, deploys |
| `mv` same fs | rename | fast, atomic-ish | not a backup | reorganize |
| `rm` | drop a name | simple | open files linger | after you checked fds |
| truncate / empty | keep the name, drop bytes | app keeps the inode | data gone | live log you must not unlink |

## 13. Common mistakes

- `rm -rf` after a failed `cd`
- Assuming `mv` is copy+delete on the same disk
- `cp` without `-a` losing mode/owner
- Deleting `/var/log/app` the directory the app still has open

## 14. Troubleshooting

**Disk still full after rm:** `sudo lsof +L1` or `ls -l /proc/*/fd | grep deleted`. Restart or send the signal that reopens the log. **Permission denied:** you lack `w`+`x` on the *directory*, not the file.

## 15. Production relevance

Log rotation that only unlinks, while the JVM keeps writing the old fd, is a weekly outage class. Mitigation: restart or `kill -USR1` if the app supports reopen; then confirm `df`.

## 16. Security considerations

`rm` is not wipe. Recoverable on many filesystems until overwritten. Do not copy secrets to `/tmp`. `mv` of a setuid binary is a change-control event.

## 17. Performance considerations

`cp` of multi-GB files is an I/O event — it will show up in your soak. `mv` on the same filesystem is metadata-cheap.

## 18. Related concepts

```text
paths → inodes → permissions → open fds → df vs du
```

## 19. Visual diagram

```text
cp   name1 → inode A     plus new name2 → inode B (new bytes)
mv   name1 → inode A     becomes name2 → inode A
rm   name1 gone          inode A lives if any fd is open
```

## 20. Hands-on exercise

```bash
LAB=$HOME/sre-lab/files
mkdir -p "$LAB"
echo data > "$LAB/keep.txt"
cp -a "$LAB/keep.txt" "$LAB/copy.txt"
ls -li "$LAB"
# open-but-deleted demo
exec 3> "$LAB/open.log"
echo hello >&3
rm "$LAB/open.log"
ls "$LAB"
ls -l /proc/$$/fd/3
echo still >&3
exec 3>&-
```

Log the output (redacted) in `progress/daily-logs/`.

## 21. Mini challenge

You `rm` a 20 GB `app.log`. `du` dropped. `df` did not. What is still holding the inode, and what is the *smallest* safe action?

Do not look up the answer in this file. Write yours first.

## 22. Interview questions

- **Beginner:** What does `rm` actually delete?
- **Intermediate:** When is `mv` not a rename?
- **Advanced:** How do you find deleted-but-open files on a full disk?

## 23. SRE scenario

02:10. `/var` 100%. Junior deleted `app.log`. Errors continue. You find `(deleted)` in `lsof`. You restart the unit, space returns, then you fix rotation.

## 24. Summary

`cp` creates. `mv` renames (usually). `rm` unlinks a name. Open files still occupy space. Never `rm -rf` without `pwd`.

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

- Here is what you already know from performance testing: Soak tests that write huge logs.
- Here is the SRE equivalent: Those bytes are inodes on a mount. Unlink ≠ free if the writer still holds the fd.
- Here is what you need to learn next: `df` vs `du` vs `lsof` — Week 06.
