# Kernel vs user space

## 1. What is it?

A CPU privilege split.

- **Kernel space** — privileged mode. The Linux kernel runs here. It may touch any memory and any device.
- **User space** — unprivileged mode. Your shell, `ls`, nginx, JMeter, Python. To touch devices or other processes' memory, they must **ask**.

The ask is a **system call** (syscall).

## 2. Why does it exist?

If every program ran privileged, one bug would own the machine. Isolation is the whole point of an OS.

## 3. Why do I need to know this as an SRE?

"The server is up" often means "the kernel still schedules." Your *service* lives in user space. Outages are usually user-space failures that the kernel is faithfully reporting (or enforcing).

When you see `Permission denied`, `Too many open files`, `Cannot allocate memory`, you are reading a **syscall return**.

## 4. Real-world analogy

A bank vault (kernel) and customers (processes). Customers fill out slips (syscalls). The teller may refuse. Customers cannot walk into the vault.

## 5. How does it work internally?

```text
User process                    Kernel
────────────                    ──────
mov ..., %rax   (syscall #)
syscall  ──────────────────►    save registers
                                check arguments
                                check credentials
                                do work or fail
         ◄──────────────────    return code in %rax
interpret 0 or -errno
```

Common syscalls you already trigger without knowing:

| You type | Syscalls (simplified) |
| -------- | --------------------- |
| `ls /var/log` | `openat`, `getdents64`, `stat`, `write` (to the terminal) |
| `cd /tmp` | `chdir` |
| `cat file` | `openat`, `read`, `write` |
| `curl https://...` | `socket`, `connect`, `sendto`, `recvfrom` |

`strace` (Month 3) makes this visible. Do not start `strace` on production pid 1 this week.

## 6. Syntax / structure

There is no `user-space` command. You observe the split:

```bash
# a user-space program
ls /

# asking the kernel "who am I?"
id

# reading a kernel-exported file
cat /proc/self/status | head
```

`/proc` is kernel memory presented as files — a user-space *view* of kernel *state*.

## 7. Basic example

```bash
cat /proc/self/stat
```

`self` is the process doing the read. The contents are kernel bookkeeping. You did not read a document someone typed.

## 8. Step-by-step execution

Take `cat /etc/hostname`:

1. Shell (user) locates `cat`.
2. `fork` + `execve` (syscalls) create the `cat` process.
3. `cat` calls `openat("/etc/hostname", O_RDONLY)`.
4. Kernel: resolve path, walk dentries, check `search` on each directory, check `read` on the file, allocate a file descriptor.
5. If any check fails, `openat` returns `-EACCES` or `-ENOENT`. `cat` prints an error and exits non-zero.
6. If ok, `read` copies bytes from page cache / disk into `cat`'s memory.
7. `write` on fd 1 copies those bytes to the terminal driver.
8. `exit_group(0)`.

Every failure you will debug for years lives in steps 4–5.

## 9. Why would I use this?

To decide *which side* is sick:

- Kernel sick: oops, panic, hung tasks, insane steal time, dead disk driver
- User space sick: crashlooping app, leaked fds, bad config, OOM-killed process (kernel *enforced* a user-space problem)

## 10. When should I NOT use it?

Do not explain every ticket with "it's a syscall." Do not edit `/proc/sys` randomly. Do not blame "the kernel" for a 404.

## 11. Alternative ways

| View | Tool |
| ---- | ---- |
| Syscall trace | `strace` |
| Kernel log | `dmesg`, `journalctl -k` |
| User-space log | app logs, `journalctl -u` |
| Metrics | `/proc/stat`, node exporter |

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| Read app log | User-space story | Fast | App may be lying or silent | First |
| `dmesg` | Kernel story | Honest about hardware/OOM | Noisy | OOM, disk, net driver |
| `strace` | Exact asks | Ground truth | Heavy, privacy | Last mile |

## 13. Common mistakes

- "Linux crashed" when one JVM did
- Thinking `/proc` files are on disk (they are not; `df` will not shrink if you "delete" them)
- Assuming more privilege (`sudo`) fixes a *logic* bug
- Forgetting that containers share a kernel: one kernel panic takes every container on the node

## 14. Troubleshooting

App says `Too many open files`. That is `EMFILE` from `open`. User-space leaked fds *or* the limit is too low. The kernel is doing its job. Next: `ls /proc/<pid>/fd | wc -l` vs `ulimit -n`. (You will do this for real in Month 2.)

## 15. Production relevance

A node is "NotReady" in Kubernetes. Is kubelet (user space) wedged, or is the kernel hung on a disk? That fork decides whether you drain the node or replace the hardware.

## 16. Security considerations

The entire security model is "user space cannot touch kernel memory." Privilege escalation is usually "trick the kernel" or "trick a privileged user-space daemon." Least privilege is a user-space identity the kernel will enforce.

## 17. Performance considerations

Syscalls are not free. Chatty apps (tiny reads, `fsync` per request) spend their life crossing the boundary. Your JMeter p99 sometimes *is* syscall + storage, not "business logic."

## 18. Related concepts

```text
CPU modes → kernel vs user → syscall → process → file descriptor → permissions
```

## 19. Visual diagram

```text
┌─────────────────────────────────────┐
│              User space             │
│   bash   ls   nginx   python        │
└──────────────┬──────────────────────┘
               │ syscall interface
┌──────────────▼──────────────────────┐
│            Linux kernel             │
│  scheduler  VFS  net  mm  drivers   │
└──────────────┬──────────────────────┘
               │
         CPU  RAM  disk  NIC
```

## 20. Hands-on exercise

```bash
id
cat /proc/self/status | egrep 'Name|Pid|Uid|Cap'
ls /proc/self/fd
```

Write: how many file descriptors does this `ls`/`cat` pipeline have open?

## 21. Mini challenge

A process is in state `D` (uninterruptible sleep) for 40 seconds. Is that typically a user-space bug or a kernel/hardware wait? What would you *not* do? (`kill -9` is a hint.)

## 22. Interview questions

- **Beginner:** What is a system call?
- **Intermediate:** Why can't `cd` be implemented as `/usr/bin/cd`?
- **Advanced:** Why can `kill -9` fail to stop a process in `D` state?

## 23. SRE scenario

Latency 200ms → 5s. CPU 30%. You assume "app slowness" (user space). `iowait` is 60%. The kernel is waiting on disk. Your next graph is not the JVM heap.

## 24. Summary

User space asks. The kernel decides. Most "Linux errors" are the kernel refusing a bad or excessive ask. Learn to read the refusal.

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

- Utilization graphs are kernel counters.
- A "slow response" may be a blocked syscall.
- Next: the program that sends your asks — the shell.
