# Visual: Load average (honest)

Full doc: [`../cpu/load-average.md`](../cpu/load-average.md)

![Load average (honest)](../weeks/week-05/visuals/images/load-average.png)

```text
4 CPUs
load 1.0  → spare cashiers
load 4.0  → all busy, no line
load 8.0  → line of 4
Linux also counts D (disk wait) in the load.
```

## Walk it

The **load average** (1/5/15 minute) is the average length of the run queue **plus** (on Linux) tasks in uninterruptible sleep (`D`, usually I/O). It is **not** CPU percent.

**SRE why:** Load 8 on a 2-CPU box is a line. Load 8 on a 32-CPU box is idle. Always divide by CPU count. High load + high iowait is a disk story.

## 5-minute lab

```bash
uptime; nproc; cat /proc/loadavg
# interpret: is load/nproc > 1?
```

## Check yourself

8 vCPU VM, load 12, iowait 55%, user 10%. Do you add CPUs? What do you inspect?
