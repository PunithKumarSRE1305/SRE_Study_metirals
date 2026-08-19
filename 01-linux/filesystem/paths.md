# Paths

## 1. What is it?

A path is a **string that names an inode** by walking the directory tree.

- **Absolute** — starts with `/`. Same meaning from any cwd.
- **Relative** — does not. Meaning depends on the process's current working directory.

Special components:

| Piece | Means |
| ----- | ----- |
| `/` at start | begin at the root of *this* namespace |
| `.` | this directory |
| `..` | parent directory |
| `~` | **shell** shortcut for `$HOME` (not the kernel) |
| `*` `?` | **shell** globs (not the kernel) |

The kernel does not understand `~` or `*`. The shell expands them *before* the syscall.

## 2. Why does it exist?

Files need names humans and programs can speak. A single global tree (unlike `C:\` `D:\`) is the Unix answer. Paths are how we point into it.

## 3. Why do I need to know this as an SRE?

Cron, systemd, containers, and "it works on my SSH" all disagree about cwd. Relative paths are the bug. Absolute paths in anything that is not a human typing are the fix.

Also: one typo in a path is a different file, a missed log, or `rm` of the wrong tree.

## 4. Real-world analogy

"Meet me at the cafe" (relative) vs "Meet me at 12 Oak Street" (absolute). The first depends on which city you are already in.

## 5. How does it work internally?

The kernel starts at either `/` (absolute) or the process cwd (relative) and walks each component:

```text
path: /var/log/nginx/error.log

start at /
  look up "var"   → inode A  (must be a dir, must have search/exec)
  look up "log"   → inode B
  look up "nginx" → inode C
  look up "error.log" → inode D  (the file)
```

Each step needs **execute (search)** permission on the directory. The final step needs the permission for the operation (read/write/exec) on the object.

Symlinks: the kernel replaces that component with the target and continues (with a hop limit). `..` after a symlink is a classic surprise (`..` is the parent of the *real* directory in traditional Unix resolution — know that it can confuse you; use `pwd -P` and `readlink -f`).

## 6. Syntax / structure

```text
/absolute/path
relative/path
./same-dir
../parent
~/home-shortcut     # shell only
```

## 7. Basic example

```bash
pwd                 # /home/you
ls /var/log         # absolute
ls ../../var/log    # relative equivalent only if cwd is /home/you
ls ~/sre-lab        # shell expands ~
```

## 8. Step-by-step execution

You type `cat ../app.log` while cwd is `/var/log/nginx`:

1. Shell does not see `~` or globs here. It passes `../app.log` to `cat`.
2. `cat` calls `openat` with that string.
3. Kernel starts at cwd `/var/log/nginx`, applies `..` → `/var/log`, then `app.log` → `/var/log/app.log`.
4. If that inode is not a readable file, error.

If you *meant* the app's directory, you asked the wrong tree.

## 9. Why would I use this?

- Humans: relative paths are faster (`cd ../`)
- Automation: absolute paths are honest
- Debugging: print `pwd` and the exact path you opened

## 10. When should I NOT use it?

Do not use relative paths in:

- cron
- systemd units
- CI
- code running as a service

Do not use `~` in those either; it may not expand.

## 11. Alternative ways

| Need | Approach |
| ---- | -------- |
| Canonical path | `readlink -f`, `realpath` |
| Stay relative but safe | `cd -- "$(dirname "$0")"` in scripts, then still prefer abs |
| Home | `$HOME` (variable) not `~` (shell syntax) |

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| Absolute | Unambiguous | Works from any cwd | Verbose | Services, cron, docs |
| Relative | Short | Nice interactively | Lies when cwd changes | Humans typing |
| `~` | Home | Short | Not kernel-visible | Interactive only |
| `realpath` | Resolve links | Truth | May fail if missing | Debugging |

## 13. Common mistakes

- `cd ~/Sre-Lab` on a case-sensitive filesystem (`sre-lab` ≠ `Sre-Lab`)
- Globs that do not match: bash (with `nullglob` unset) passes the literal `*.log`
- Spaces in paths without quoting
- Assuming `..` undoes a symlink the way you picture it
- Windows brain: `\` is not a separator here

## 14. Troubleshooting

`No such file or directory` is **ENOENT**. It means a *component* is missing, not necessarily the last one. `ls` each parent. `namei -l /the/full/path` (if installed) shows the walk.

## 15. Production relevance

A unit file:

```ini
ExecStart=./bin/app
WorkingDirectory=/opt/app
```

Someone changes `WorkingDirectory` and forgets. The process looks for `./bin/app` from `/`. Fail. Health check down. Rolling deploy "hangs." The YAML/Helm was fine. The path was relative.

## 16. Security considerations

`../` traversal in web apps is this concept used as a weapon. In shells, unquoted variables in paths become extra arguments. `cd -- "$dir"` — the `--` stops dirs named `-e` from being flags.

## 17. Performance considerations

Path lookup is cached (dentry cache). Millions of lookups of *missing* paths (bad stat loops) still show up as syscall storms. Rare in Week 1; real in hot apps.

## 18. Related concepts

```text
FHS → paths → cwd → cd / pwd / ls → permissions → symlinks
```

## 19. Visual diagram

```text
cwd = /home/you/sre-lab

relative "week01/a"
        → /home/you/sre-lab/week01/a

absolute "/var/log"
        → /var/log
        (cwd ignored)
```

## 20. Hands-on exercise

```bash
cd /var/log
echo relative=$(readlink -f ./)
echo home_tilde=~
echo home_var=$HOME
printf '%s\n' *
```

Observe that `*` expanded in the shell before `printf` ran.

## 21. Mini challenge

A script contains `cd $DIR` and `DIR=/tmp/My Files`. What happens? Write the correct line.

## 22. Interview questions

- **Beginner:** Absolute vs relative?
- **Intermediate:** Why is `~` dangerous in cron?
- **Advanced:** How does a chroot or container mount namespace change what `/` means?

## 23. SRE scenario

Two containers. Both log to `/var/log/app.log`. On the node those are *different* files in different mount namespaces. You `ls /var/log/app.log` on the host and see nothing. Paths are namespace-relative. You exec into the container.

## 24. Summary

A path is a walk. `/` starts at root. Anything else starts at cwd. `~` and `*` are shell fiction. Automation speaks absolute paths.

## 25. Knowledge checklist

- [ ] I understand what this is
- [ ] I understand why it exists
- [ ] I can explain it
- [ ] I can use it
- [ ] I can troubleshoot it
- [ ] I can explain its alternatives
- [ ] I can apply it in production
- [ ] I can answer interview questions
