# Visual: Signals — SIGTERM vs SIGKILL

Full doc: [`../processes/signals.md`](../processes/signals.md)


```text
TERM  → handler or default terminate  → cleanup possible
KILL  → kernel tears down task         → no handler
D     → uninterruptible                → even KILL waits
```

## Walk it

A **signal** is an asynchronous kernel message to a process. `SIGTERM` (15) asks it to exit. `SIGKILL` (9) destroys it — the process cannot catch it. `SIGHUP` (1) often means reload. `SIGINT` is Ctrl-C.

**SRE why:** Always TERM before KILL. TERM lets the app close DB connections and flush. KILL leaves locks and half-written files. `D` state ignores even KILL.

## 5-minute lab

```bash
sleep 120 & SP=$!
ps -p $SP -o pid,stat,cmd
kill -TERM $SP
sleep 0.2
ps -p $SP || echo 'exited as expected'
```

## Check yourself

A java process ignores TERM for 90s. systemd then KILLs it. Connections are reset every deploy. What should change: the app, the timeout, or both?
