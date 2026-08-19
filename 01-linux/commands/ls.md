# ls — list directory contents

## 1. What is it?

`ls` asks the kernel for the names (and optionally metadata) in a directory, then prints them.

It does **not** "show files on the computer." It shows **one directory's entries** (or the arguments you gave it).

## 2. Why does it exist?

Directories are just lists of names → inodes. Humans cannot read inodes. `ls` is the readable view.

## 3. Why do I need to know this as an SRE?

You use `ls` constantly — and misread it constantly. Hidden files, symlink arrows, "empty" directories that are not, and `ls` vs `ls -l` vs `ls -ld` are daily distinctions.

## 4. Real-world analogy

Opening a single drawer and reading the folder tabs. Not an inventory of the building.

## 5. How does it work internally?

```text
ls -l /var/log
  openat(/var/log)
  getdents64  →  names
  for each name: lstat  →  mode, nlink, owner, size, mtime
  format columns
  write to stdout
```

Without `-l`, many `ls` implementations skip the expensive `stat` (except to know colors / which are dirs). That is why `ls` can be fast and `ls -l` slow on huge directories.

Hidden names: by convention, names starting with `.` are **not special to the kernel**. `ls` just refuses to print them unless `-a` / `-A`.

## 6. Syntax / structure

```bash
ls [OPTIONS] [PATH...]
```

Flags you must know this week:

| Flag | Meaning |
| ---- | ------- |
| `-l` | long: mode, links, owner, group, size, time, name |
| `-a` | include `.` names |
| `-A` | include `.` names except `.` and `..` |
| `-d` | list the directory itself, not its contents |
| `-h` | human sizes (with `-l`) |
| `-i` | inode number |
| `-t` | sort by mtime |
| `-1` | one per line (good for scripts / counts) |

## 7. Basic example

```bash
ls /var/log
ls -l /var/log
ls -ld /var/log
ls -la "$HOME"
```

Compare `ls -l /var/log` vs `ls -ld /var/log`. The first lists children. The second describes the directory inode.

## 8. Step-by-step execution

`ls -l /var/log/syslog`:

1. Shell finds `/usr/bin/ls`.
2. `ls` sees an argument that is a file, not a directory.
3. It `lstat`s that one file and prints one long line.
4. It does not list `/var/log`.

`ls /nope`:

1. `stat` fails with `ENOENT`.
2. `ls` prints to **stderr**, exits **2** (GNU ls).
3. `$?` is not 0.

## 9. Why would I use this?

- See what exists
- Read permission bits (Week 3 will finish this)
- See symlink targets (`lrwxrwxrwx ... name -> target`)
- See size 0 vs huge logs

## 10. When should I NOT use it?

- Parsing `ls` in scripts (the output is for humans; use `find`, globs, or `stat`)
- Listing a directory with 5 million files in an incident (you will wait; use `find ... | head`)
- Using `ls` to see if a *process* is running (that is `ps`)

## 11. Alternative ways

| Need | Better tool |
| ---- | ----------- |
| Recursive names | `find` |
| Disk usage | `du`, `df` |
| Does this path exist? | `test -e`, `[[ -e ]]` |
| Metadata | `stat` |
| Tree picture | `tree` (if installed) |

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| `ls` | Glance | Fast | Hides `.` files | Humans |
| `ls -la` | Truthful glance | Shows hidden | Noisy | Homes, weird apps |
| `ls -ld path` | The directory itself | Correct question | Easy to forget `-d` | Permissions on the dir |
| `stat` | Precise metadata | Stable fields | Less pretty | Scripts, debug |
| `find` | Search | Powerful | Easy to over-scan | When you do not know the name |

## 13. Common mistakes

- "The directory is empty" because you forgot `-a` and the only file is `.env`
- Reading the `l` in `lrwxrwxrwx` as "full permissions, great" — that is a symlink
- Sorting by *name* when you needed the newest log (`-lt`)
- `ls *` exploding on too many names (shell glob)

## 14. Troubleshooting

`ls` hangs: directory on a stale NFS/FUSE mount, or a dying disk. `ls` of a *local* path should not hang. That hang *is* the incident.

`ls: Permission denied`: you lack **execute** on a parent or **read** on the directory. `cd` into it may also fail. (Week 3.)

## 15. Production relevance

App "isn't logging." `ls /var/log/myapp` looks empty. `ls -la` shows `.hidden.log` or a log behind a symlink to `/mnt/empty`. Or the file is there and size 0 because permissions allow `ls` but not write by the service user.

## 16. Security considerations

`ls -l` leaks existence, owners, and sizes. World-readable home directories are an information leak. Do not `ls` customer upload directories in a shared TMUX for fun.

## 17. Performance considerations

`ls -l` on a huge directory is a `stat` storm. On network filesystems this can look like an outage. Prefer `ls` without `-l`, or `find -maxdepth 1 | wc -l`.

## 18. Related concepts

```text
directory inode → dirent → ls → stat → permissions → hidden files
```

## 19. Visual diagram

```text
ls -l /var/log
        │
        v
   kernel: list dirents
        │
        +--> syslog      inode 10  size 2G
        +--> nginx/      inode 11  dir
        +--> .hidden     (only with -a)
```

## 20. Hands-on exercise

```bash
ls /var/log
ls -l /var/log | head
ls -ld /var/log
ls -la "$HOME" | head
ls -l /etc/os-release
```

Write what each question was.

## 21. Mini challenge

You need to know whether `/var/log/nginx` exists and what its permissions are, *without* listing thousands of access-log files inside it. Exact command?

## 22. Interview questions

- **Beginner:** What does `-a` change?
- **Intermediate:** `ls -l dir` vs `ls -ld dir`?
- **Advanced:** Why is parsing `ls` in a script a bug? What do you use instead?

## 23. SRE scenario

Disk filling. `ls /var/log` shows modest files. `ls -a` reveals `.debug` at 40 GB. Rotation only matched `*.log`. Hidden names are a convention, not a security boundary.

## 24. Summary

`ls` lists names in a directory. `-l` adds metadata. `-a` includes dotfiles. `-d` asks about the directory itself. Do not parse `ls` in scripts.

## 25. Knowledge checklist

- [ ] I understand what this is
- [ ] I understand why it exists
- [ ] I can explain it
- [ ] I can use it
- [ ] I can troubleshoot it
- [ ] I can explain its alternatives
- [ ] I can apply it in production
- [ ] I can answer interview questions
