# /proc as an API

**Week:** W05 · **Visual:** [`../visuals/proc-filesystem.md`](../visuals/proc-filesystem.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

`/proc` is not a disk. It is the kernel exporting live state as files: processes, cpu, mem, mounts, net. `cat /proc/uptime` is a syscall dressed as a read.

## 2. Why does it exist?

Everything-is-a-file lets ordinary tools inspect the kernel without a special debugger.

## 3. Why do I need to know this as an SRE?

`ls /proc/PID/fd` is 'what files does this process have open?'. `cwd`, `environ`, `limits`, `status` — this is how you debug without strace first.

## 4. Real-world analogy

A live dashboard behind a filing-cabinet UI.

## 5. How does it work internally?

procfs is a virtual filesystem. Reads call into kernel functions that format current state. Writes to some files (`/proc/sys/...`) change knobs (sysctl). Namespaces mean a container's `/proc` view is filtered.

## 6. Syntax / structure

```bash
ls /proc/$$
readlink /proc/$$/cwd
ls /proc/$$/fd
cat /proc/$$/limits
cat /proc/meminfo | head
cat /proc/mounts
```

## 7. Basic example

```bash
readlink /proc/$$/exe
wc -l /proc/$$/fd/* 2>/dev/null | tail
```

## 8. Step-by-step execution

1. open(2) on a /proc path.
2. The kernel builds the content.
3. You read a snapshot (it can change next read).

## 9. Why would I use this?

Open files, cwd, limits (nofile), environment (careful), mounts, loadavg.

## 10. When should I NOT use it?

Do not `rm` /proc. Do not write sysctls you cannot explain. Do not dump `/proc/PID/environ` into Slack (secrets).

## 11. Alternative ways

`ps`, `lsof`, `ss` are pretty printers on top of /proc and netlink.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| /proc | raw API | always there | ugly | source of truth |
| ps/lsof/ss | pretty | faster to read | hide fields | daily |
| sysctl | knobs | named | easy to persist wrong | with care |

## 13. Common mistakes

- Treating /proc as disk space you can free
- cat environ in a ticket
- Assuming container /proc is the host /proc

## 14. Troubleshooting

**Permission denied on other pid:** you are not root and ptrace_scope/hidepid applies. **No such file:** process exited.

## 15. Production relevance

Too many open files: compare `ls /proc/PID/fd | wc -l` to `Max open files` in `limits`.

## 16. Security considerations

environ and fd links leak secrets and paths. hidepid=2 exists for a reason.

## 17. Performance considerations

Reading /proc for 100k pids in a tight loop is a load test of the kernel.

## 18. Related concepts

```text
process → /proc → limits → fds → strace
```

## 19. Visual diagram

```text
/proc/self/cwd   →  kernel's cwd pointer
/proc/self/fd/   →  open file descriptors
/proc/meminfo    →  memory counters
/proc/sys/       →  tunables (sysctl)
```

## 20. Hands-on exercise

```bash
ls /proc/$$
readlink /proc/$$/cwd
ls /proc/$$/fd | wc -l
grep 'open files' /proc/$$/limits
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

An app dies with 'too many open files'. Which two /proc files prove it?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** Is /proc on disk?
- **Intermediate:** How do you list a process's fds?
- **Advanced:** What is hidepid?

## 23. SRE scenario

503s, CPU low. fd count = 65535 = limit. Leak. Restart mitigates; you file the leak.

## 24. Summary

/proc is the kernel's API as files. Read it. Do not 'clean' it. Do not paste environ.

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

- Here is what you already know from performance testing: Monitoring agents scrape kernel counters.
- Here is the SRE equivalent: Those counters live here.
- Here is what you need to learn next: disk vs inodes.
