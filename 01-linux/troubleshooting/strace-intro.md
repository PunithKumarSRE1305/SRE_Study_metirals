# strace — last-mile syscalls

**Week:** W09 · **Visual:** [`../visuals/strace-intro.md`](../visuals/strace-intro.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

**strace** prints the system calls a process makes: `openat`, `connect`, `write`, and the errno. It is how you see the asks when logs lie.

## 2. Why does it exist?

User-space logs are optional. Syscalls happened or they did not.

## 3. Why do I need to know this as an SRE?

Use it when you already know the pid and the layer. 'It cannot find the config' → strace and watch `openat`. 'It hangs' → last syscall is `connect` to the DB.

## 4. Real-world analogy

A wiretap on the conversation between the app and the kernel. Heavy. Precise.

## 5. How does it work internally?

strace uses `ptrace`. Every syscall traps. That is why it is slow. `-e` filters. `-p PID` attaches. `-f` follows children. `-o file` writes output. Detach with Ctrl-C (the process usually survives).

## 6. Syntax / structure

```bash
strace -f -e openat,connect,write -p PID
strace -e openat ls /var/log >/dev/null
```

## 7. Basic example

```bash
strace -e openat cat /etc/os-release >/dev/null
```

## 8. Step-by-step execution

1. Pick a pid or a short command.
2. Filter (`-e`) or you will drown.
3. Reproduce.
4. Read the last failing syscall and its errno.

## 9. Why would I use this?

Missing files, unexpected paths, hung connects, permission denials you cannot see in logs.

## 10. When should I NOT use it?

Do not strace pid 1 on production. Do not strace a latency-sensitive process on all CPUs. Do not start here on Day 1.

## 11. Alternative ways

`perf`, eBPF, and application traces are lighter at scale. strace is a scalpel.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| logs | cheap | always first | can lie | default |
| strace | syscalls | truth | heavy | last mile |
| eBPF later | cheap-ish truth | prod-safe-ish | more skill | year 2 |

## 13. Common mistakes

- No filter
- Attaching to the wrong pid
- Leaving it running
- Using it before df/top/journal

## 14. Troubleshooting

**attach: Operation not permitted:** permissions or Yama ptrace_scope. **Output flood:** add `-e`. **Process died:** you straced a oneshot.

## 15. Production relevance

A 5-second strace on one bad pod in a lab-like env can save a day. A fleet-wide strace is an outage.

## 16. Security considerations

strace sees arguments — tokens, passwords, PII. Treat output as secret. ptrace is a security boundary.

## 17. Performance considerations

10-100x slowdown is normal. That is why it is last.

## 18. Related concepts

```text
kernel vs user → /proc → logs → strace
```

## 19. Visual diagram

```text
myapp  --openat("/etc/myapp.yaml")-->  ENOENT
       --connect(10.0.2.20:5432)-->   ETIMEDOUT
```

## 20. Hands-on exercise

```bash
strace -e openat cat /etc/os-release >/dev/null
strace -e openat cat /no/such 2>&1 | tail
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

strace shows connect to 10.0.2.20:5432 hanging. Logs say 'starting'. What is H1, and what is *not* your next command?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** What does strace show?
- **Intermediate:** Why is it slow?
- **Advanced:** When must you not use it?

## 23. SRE scenario

App 'can't find config'. strace: openat("/opt/app/config.yaml") ENOENT. Unit WorkingDirectory was wrong. Not a code bug.

## 24. Summary

Filter. Short. Last mile. Logs first. Treat output as secret.

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

- Here is what you already know from performance testing: You already wish the SUT would tell you the exact call that waited.
- Here is the SRE equivalent: strace is that wish, expensive.
- Here is what you need to learn next: bash — the language of the first commands.
