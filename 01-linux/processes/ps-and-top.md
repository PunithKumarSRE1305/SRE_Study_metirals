# ps and top — reading process tables

**Week:** W04 · **Visual:** [`../visuals/ps-and-top.md`](../visuals/ps-and-top.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

`ps` is a snapshot of processes. `top`/`htop` is a repeating snapshot with CPU/memory sorted. Columns are kernel bookkeeping: pid, user, %CPU, %MEM, VSZ, RSS, STAT, START, TIME, COMMAND.

## 2. Why does it exist?

You cannot manage what you cannot list. `top` is how you find the pid eating the box.

## 3. Why do I need to know this as an SRE?

CPU 100% is a pid, not a mood. `ps aux --sort=-%cpu | head` is a first move. Learn STAT: R running, S sleep, D uninterruptible, Z zombie, < high priority.

## 4. Real-world analogy

A roll-call (ps) vs a live scoreboard (top).

## 5. How does it work internally?

These tools read `/proc/[pid]/*`. `%CPU` in top is recent usage, not lifetime. `TIME` is accumulated CPU. Load average is a different number (queue). `ps` without `ax` hides other users' processes.

## 6. Syntax / structure

```bash
ps aux | head
ps -fp PID
top          # q to quit
top -p PID
ps aux --sort=-%mem | head
```

## 7. Basic example

```bash
ps -p $$ -o pid,user,stat,%cpu,%mem,cmd
# top -n 1 -b | head -20   # one batch snapshot
```

## 8. Step-by-step execution

1. Tool opens /proc.
2. Reads stat/status/cmdline for each pid.
3. Formats columns.
4. top sleeps and repeats.

## 9. Why would I use this?

Find hogs. Confirm a process exists. See if it is D or Z.

## 10. When should I NOT use it?

Do not leave `top` running as your only monitoring. Do not kill based on COMMAND greps that match themselves.

## 11. Alternative ways

`pidstat`, `htop`, `atop`, and later Prometheus node exporter are richer. Start here.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| ps | snapshot | scriptable | stale immediately | tickets, scripts |
| top | live | interactive | needs a tty | incident |
| /proc | raw | ground truth | ugly | when tools lie |

## 13. Common mistakes

- Killing the grep
- Sorting by TIME instead of %CPU
- Ignoring STAT D
- Thinking %MEM must add to 100% (shared pages)

## 14. Troubleshooting

**Process vanished:** it exited. **top shows 0% but slowness:** wait on disk/lock (D or uninterruptible). Check wchan / iowait.

## 15. Production relevance

A runaway regex in one worker will show as one pid at 100%. Restarting the *service* kills everyone. Prefer killing/restarting the worker if the architecture allows.

## 16. Security considerations

`ps` exposes command lines — secrets as flags will leak. `ps aux` is an information source for attackers on a shared box.

## 17. Performance considerations

`ps aux` on a host with 50k threads is itself expensive. Scope with `-p` or `pgrep`.

## 18. Related concepts

```text
process → /proc → top → signals → load average
```

## 19. Visual diagram

```text
USER PID %CPU %MEM STAT COMMAND
app  4402 98.1 12.0  R    java -jar app.jar     ← CPU hog
app  4403  0.0  4.0  D    java                   ← stuck on disk
```

## 20. Hands-on exercise

```bash
ps -p $$ -o pid,ppid,user,stat,%cpu,%mem,cmd
ps aux --sort=-%cpu | head -8
top -n 1 -b | head -15
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

top shows a process at 0% CPU, STAT D, and users are timing out. What do you *not* do first?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** ps vs top?
- **Intermediate:** What is STAT D?
- **Advanced:** Why can %MEM of all processes exceed 100%?

## 23. SRE scenario

JMeter p99 8s. top: one pid 100% user, rest idle. You capture a stack / restart that worker, not the database.

## 24. Summary

ps is a photo. top is a film. Read STAT, %CPU, RSS, COMMAND. Kill with knowledge.

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

- Here is what you already know from performance testing: The APM CPU graph.
- Here is the SRE equivalent: top is that graph exploded into pids.
- Here is what you need to learn next: signals.
