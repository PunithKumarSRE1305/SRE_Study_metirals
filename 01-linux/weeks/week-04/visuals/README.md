# Week 04 — visual explainers

Dedicated page + image: [processes.md](processes.md)

**Theme:** Processes + Month 1 gate

Diagram-first. Full 25-section docs are written when the week opens.

## Concept 1: What a process is

A running program: pid, ppid, uid, cwd, fds.

## Concept 2: `ps` and `top`

Columns are kernel bookkeeping, not decoration.

## Concept 3: Signals

SIGTERM is polite. SIGKILL is a kernel sledgehammer.

## Concept 4: State `D`

Uninterruptible sleep. Usually disk. `-9` will not help.

## Concept 5: pid 1

If systemd dies, the box is not a box anymore.


## Concept: process tree and signals

![Process and signals](images/process-and-signals.png)

```text
SIGTERM  →  please stop, flush, close fds     (app can ignore — badly)
SIGKILL  →  kernel destroys the task          (cannot be caught)
SIGHUP   →  often “reload config”
state D  →  stuck in kernel/disk              (kill -9 fails)
```


## Performance-testing bridge

Whatever this week names (files, perms, CPU, disk, packets) is something you already *saw from the outside* in a load test. The picture here is how that number is born.

## Check yourself

Close the page. Redraw one diagram from memory. If you cannot, you watched, you did not learn.
