# Signals — SIGTERM vs SIGKILL

**Week:** W04 · **Visual:** [`../visuals/signals.md`](../visuals/signals.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

A **signal** is an asynchronous kernel message to a process. `SIGTERM` (15) asks it to exit. `SIGKILL` (9) destroys it — the process cannot catch it. `SIGHUP` (1) often means reload. `SIGINT` is Ctrl-C.

## 2. Why does it exist?

You need a way to stop, restart, or poke a process that is not listening on HTTP.

## 3. Why do I need to know this as an SRE?

Always TERM before KILL. TERM lets the app close DB connections and flush. KILL leaves locks and half-written files. `D` state ignores even KILL.

## 4. Real-world analogy

TERM is 'please leave the building'. KILL is teleporting you out mid-sentence. HUP is 'reread the briefing'.

## 5. How does it work internally?

`kill PID` sends SIGTERM by default. The kernel delivers the signal when the process is scheduled (except KILL/STOP which are special). A handler can run, or the default action (terminate) occurs. systemd sends TERM, waits `TimeoutStopSec`, then KILL.

## 6. Syntax / structure

```bash
kill PID                 # SIGTERM
kill -TERM PID
kill -HUP PID            # reload if the app says so
kill -9 PID              # SIGKILL, last resort
kill -l                  # list names
```

## 7. Basic example

```bash
sleep 300 &
echo $!
kill $!
# wait; echo $?
```

## 8. Step-by-step execution

1. You call `kill(2)` with a signal number.
2. The kernel marks the task.
3. Unless KILL/STOP, the process may run a handler.
4. Exit status reflects the signal (e.g. 143 = 128+15).

## 9. Why would I use this?

Stop a runaway. Ask systemd to stop the unit (preferred). Reload nginx with HUP if that is the documented method.

## 10. When should I NOT use it?

Do not start with -9. Do not kill -9 java in prod as a daily habit. Do not kill pid 1.

## 11. Alternative ways

`systemctl stop` is the grown-up kill: it knows the unit, the children, and the timeout.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| systemctl stop | managed unit | clean, logged | needs a unit | default for services |
| kill -TERM | raw pid | precise | you must know children | one process |
| kill -9 | force | works if runnable | no cleanup, D-state immune | after TERM wait |

## 13. Common mistakes

- -9 first
- Killing the parent and leaving workers
- HUP on an app that treats HUP as exit
- kill without checking you have the right pid

## 14. Troubleshooting

**kill: no such process:** already dead. **Permission denied:** not your uid and no privilege. **Still there after -9:** state D, or you are looking at a new pid that reused the number — check start time.

## 15. Production relevance

K8s `terminationGracePeriodSeconds` is TERM-then-KILL. If your app ignores TERM, every deploy is a hard kill.

## 16. Security considerations

Any user can signal their own processes. Sending signals as root to the wrong pid is a self-inflicted outage.

## 17. Performance considerations

A KILL during a write can corrupt a file. Cheap signal, expensive consequence.

## 18. Related concepts

```text
process → kill → systemd TimeoutStopSec → container stop
```

## 19. Visual diagram

```text
TERM  → handler or default terminate  → cleanup possible
KILL  → kernel tears down task         → no handler
D     → uninterruptible                → even KILL waits
```

## 20. Hands-on exercise

```bash
sleep 120 & SP=$!
ps -p $SP -o pid,stat,cmd
kill -TERM $SP
sleep 0.2
ps -p $SP || echo 'exited as expected'
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

A java process ignores TERM for 90s. systemd then KILLs it. Connections are reset every deploy. What should change: the app, the timeout, or both?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** Default signal of kill?
- **Intermediate:** Why TERM before KILL?
- **Advanced:** When does kill -9 fail?

## 23. SRE scenario

On-call -9s nginx. In-flight requests die, users see 502. Next time: systemctl reload or TERM and wait.

## 24. Summary

TERM, wait, then KILL. HUP is reload only if documented. D-state is a disk/kernel wait.

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

- Here is what you already know from performance testing: You already 'stop the test' vs 'kill -9 JMeter'.
- Here is the SRE equivalent: Same courtesy for the system under test.
- Here is what you need to learn next: /proc and load average.
