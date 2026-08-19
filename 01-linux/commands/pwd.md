# pwd — print working directory

## 1. What is it?

A way to ask: **what directory is this process in right now?**

Usually a shell builtin (`pwd`) and also an external program (`/usr/bin/pwd`). Both print the current working directory (cwd).

## 2. Why does it exist?

Relative paths are meaningless without cwd. Humans get lost. Scripts that log `pwd` become debuggable.

## 3. Why do I need to know this as an SRE?

Every "file not found" ticket starts with two facts: *what path* and *from where*. `pwd` is the second fact. If you do not print it, you are guessing.

## 4. Real-world analogy

Looking up at the street sign before you give directions.

## 5. How does it work internally?

The kernel stores cwd as a pointer to a dentry/inode on the process.

- `pwd` (bash builtin, default `-L`) prints the **logical** path the shell remembers, including how you walked through symlinks.
- `pwd -P` or `/usr/bin/pwd -P` asks the kernel for the **physical** path with symlinks resolved.

```text
$ ln -s /var/log ~/mylogs
$ cd ~/mylogs
$ pwd        # /home/you/mylogs
$ pwd -P     # /var/log
```

## 6. Syntax / structure

```bash
pwd           # logical (shell)
pwd -L        # logical, explicit
pwd -P        # physical
/usr/bin/pwd  # external binary (physical by default on GNU)
```

## 7. Basic example

```bash
pwd
cd /var/log
pwd
```

## 8. Step-by-step execution

1. You type `pwd`.
2. Bash recognizes a builtin — no `fork` required for the common case.
3. Bash prints its `PWD` variable (logical).
4. If you used `-P`, bash walks `getcwd()` from the kernel.

If cwd was deleted, `pwd` may still print the old logical path; `pwd -P` may error. That is a real incident shape (deleted-but-current directory).

## 9. Why would I use this?

- Before any relative operation you do not trust
- In scripts, log it once at start
- To confirm a `cd` actually happened

## 10. When should I NOT use it?

Do not poll `pwd` in a hot loop. Do not use it as a lock or a uniqueness key across hosts (every container may print `/`).

## 11. Alternative ways

| Approach | Notes |
| -------- | ----- |
| `echo "$PWD"` | Shell variable; logical |
| `ls -ld .` | Shows metadata of cwd, not the path string |
| `/proc/self/cwd` | Kernel symlink to the real cwd |

```bash
readlink /proc/self/cwd
```

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| `pwd` | Human | Fast | Logical vs physical confusion | Interactive |
| `pwd -P` | Truth | Resolves links | Longer | When links matter |
| `$PWD` | Scripts | No extra command | May be stale if something else chdir'd | Bash scripts |
| `/proc/self/cwd` | Debug | Kernel truth | Linux-specific | Weird cwd bugs |

## 13. Common mistakes

- Trusting `pwd` after a failed `cd` (cwd did **not** change)
- Mixing logical and physical when writing paths into configs
- Assuming `pwd` in two SSH windows is the same (it is not shared)

## 14. Troubleshooting

`pwd` says `/opt/app` but the files you expect are missing: you are on the wrong host, in a different mount namespace, or `/opt/app` is an empty overlay. Next: `hostname`, `findmnt .`, `ls -la`.

## 15. Production relevance

A postmortem that says "we ran the cleanup script" without `pwd` in the log is how `/` gets cleaned. Print cwd. Quote variables. Use absolute paths anyway.

## 16. Security considerations

The path may contain sensitive directory names. Logs leave the box. Be mindful in multi-tenant systems.

## 17. Performance considerations

None that matter. Builtin is cheap.

## 18. Related concepts

```text
process → cwd → pwd → cd → paths → /proc/self/cwd
```

## 19. Visual diagram

```text
Process bash
  cwd inode ──► /home/you
  PWD=" /home/you "
          │
          v
        pwd prints PWD
```

## 20. Hands-on exercise

```bash
pwd
pwd -P
readlink -f .
readlink /proc/self/cwd
```

Are they identical? If not, you are on a symlink.

## 21. Mini challenge

You `cd` into a directory, then in another terminal `rm -rf` that directory. What do `pwd`, `pwd -P`, `ls`, and `cd .` do? Try it only under `$HOME/sre-lab`.

## 22. Interview questions

- **Beginner:** What does `pwd` print?
- **Intermediate:** `pwd` vs `pwd -P`?
- **Advanced:** How can cwd exist for a process after the path is unlinked?

## 23. SRE scenario

On-call runs a "safe" `rm -rf ./*` after a `cd` that failed because of a typo. cwd was still `$HOME`. `pwd` was not in the muscle memory. You will never skip it again.

## 24. Summary

`pwd` tells you where *this process* is. Failed `cd` does not change it. Logical and physical paths can differ. Print it before you destroy things.

## 25. Knowledge checklist

- [ ] I understand what this is
- [ ] I understand why it exists
- [ ] I can explain it
- [ ] I can use it
- [ ] I can troubleshoot it
- [ ] I can explain its alternatives
- [ ] I can apply it in production
- [ ] I can answer interview questions
