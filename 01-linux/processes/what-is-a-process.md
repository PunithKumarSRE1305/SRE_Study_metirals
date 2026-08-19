# What a process is

**Week:** W04 · **Visual:** [`../weeks/week-04/visuals/processes.md`](../weeks/week-04/visuals/processes.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

A **process** is a running program: an address space, a pid, a parent, credentials, a cwd, file descriptors, and a state. It is not the binary on disk. The binary is just bytes until `exec`.

## 2. Why does it exist?

The kernel multiplexes the CPU by switching among processes. Isolation (memory, fds) is the point of the OS.

## 3. Why do I need to know this as an SRE?

Every incident bottoms out as 'which pid, what is it waiting on, what uid, what cwd, what fds?' If you cannot answer those, you only restart.

## 4. Real-world analogy

A cook (process) following a recipe (binary) at a station (cwd) with utensils (fds).

## 5. How does it work internally?

`fork` clones a process. `execve` replaces the memory with a new program. pid 1 is special (systemd): it reaps orphans and starts the world. Threads share an address space; on Linux they are tasks with the same tgid. cwd is process-global (shared by threads).

## 6. Syntax / structure

```bash
ps -p $$ -o pid,ppid,uid,user,stat,wchan,cmd
ls -l /proc/$$/cwd /proc/$$/fd
cat /proc/$$/status | head
```

## 7. Basic example

```bash
ps -p $$ -o pid,ppid,user,stat,cmd
readlink /proc/$$/cwd
```

## 8. Step-by-step execution

1. The kernel allocates a pid and task_struct.
2. Memory mappings, fds, and cwd are set (inherited or reset).
3. The scheduler may run it.
4. On exit, the parent (or pid 1) reaps the exit status.

## 9. Why would I use this?

Identify *what* is running before you kill or restart it.

## 10. When should I NOT use it?

Do not kill pid 1. Do not assume one process = one container = one pod (later).

## 11. Alternative ways

A container is a process with namespaces and cgroups. Same object, extra fences.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| process | unit of execution | kernel-native | many per app | always |
| thread | shared memory worker | cheap | cwd/fd shared surprises | inside one pid |
| container | isolated process | portable | hides the pid on the node | later |

## 13. Common mistakes

- 'The server' as if it were one process
- Killing the wrong pid because you grepped `ps` sloppily
- Forgetting children keep running if you only kill the parent poorly

## 14. Troubleshooting

**Zombie (Z):** parent is not reaping — usually a bug in the parent, not 'the zombie is using CPU'. **No such pid:** it already exited.

## 15. Production relevance

A Deployment with 3 replicas is 3+ processes (plus sidecars) across nodes. You still debug *one* pid first.

## 16. Security considerations

A process with uid 0 is root, even if the binary lives in `/tmp`. Capabilities can grant slices of root.

## 17. Performance considerations

Context switches, fd leaks, and thread explosions are process-level performance bugs you already saw as 'throughput collapsed'.

## 18. Related concepts

```text
kernel vs user → fork/exec → ps/top → signals → /proc
```

## 19. Visual diagram

```text
pid 1 systemd
  └─ sshd
       └─ bash  pid 2201  cwd=/home/you  uid=you
            └─ ps
```

## 20. Hands-on exercise

```bash
ps -p $$ -o pid,ppid,uid,user,stat,cmd
readlink /proc/$$/cwd
ls /proc/$$/fd
cat /proc/$$/status | egrep 'Name|Pid|PPid|Uid|State'
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

Is `cd` changing a file or a field on the process? Draw it.

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** Process vs program?
- **Intermediate:** What does fork+exec do?
- **Advanced:** Why can kill -9 fail?

## 23. SRE scenario

Load test shows 503. You find 200 `python` pids stuck in D. Disk, not 'the app is slow'.

## 24. Summary

A process is a live kernel object: pid, uid, cwd, fds, state. The binary is just the recipe.

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

- Here is what you already know from performance testing: You already watch 'the service' as a blob.
- Here is the SRE equivalent: The blob is pids. Split it.
- Here is what you need to learn next: ps, top, signals.
