# Load average (honest)

**Week:** W05 · **Visual:** [`../weeks/week-05/visuals/README.md`](../weeks/week-05/visuals/README.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

The **load average** (1/5/15 minute) is the average length of the run queue **plus** (on Linux) tasks in uninterruptible sleep (`D`, usually I/O). It is **not** CPU percent.

## 2. Why does it exist?

You need a single number for 'how long is the line?' across time.

## 3. Why do I need to know this as an SRE?

Load 8 on a 2-CPU box is a line. Load 8 on a 32-CPU box is idle. Always divide by CPU count. High load + high iowait is a disk story.

## 4. Real-world analogy

Cashiers (CPUs) and a queue. Load counts people at the register *and* people waiting in the back for a warehouse fetch (D).

## 5. How does it work internally?

The kernel samples the number of runnable + uninterruptible tasks and exponentially averages. `/proc/loadavg` exposes it. `nproc` or `lscpu` gives CPU count. Steal time is separate (hypervisor).

## 6. Syntax / structure

```bash
cat /proc/loadavg
uptime
nproc
lscpu | grep '^CPU(s)'
```

## 7. Basic example

```bash
uptime
nproc
cat /proc/loadavg
```

## 8. Step-by-step execution

1. Read the three averages.
2. Read CPU count.
3. Compare: load / nproc.
4. If >1 per CPU, look at top STAT and iowait/steal.

## 9. Why would I use this?

First glance during an incident. Trend (1 vs 15) tells you if it is spiking or stuck.

## 10. When should I NOT use it?

Do not page on raw load without capacity context. Do not say 'load is high' in a postmortem without nproc and iowait.

## 11. Alternative ways

CPU% (user/system/iowait/steal) is more specific. Use both.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| loadavg | queue length | one number | mixes CPU and I/O | glance |
| mpstat/iostat | split the why | precise | more to learn | next command |
| APM CPU | app view | user-shaped | blind to steal/iowait | together |

## 13. Common mistakes

- Comparing load 4 on a laptop to load 4 on a 64-vCPU host
- Ignoring D-state contribution
- Alerting load > 1 on a 16-core box

## 14. Troubleshooting

**Load high, top idle:** iowait or many uninterruptible tasks. **Load low, latency high:** you may be waiting on a *remote* dependency, not this CPU.

## 15. Production relevance

Autoscaling on load average will scale out during a disk stall and make it worse. Scale on a user SLI.

## 16. Security considerations

None direct.

## 17. Performance considerations

This *is* a performance signal. Misreading it wastes hardware.

## 18. Related concepts

```text
CPU saturation → iowait → steal → processes D → capacity
```

## 19. Visual diagram

```text
4 CPUs
load 1.0  → spare cashiers
load 4.0  → all busy, no line
load 8.0  → line of 4
Linux also counts D (disk wait) in the load.
```

## 20. Hands-on exercise

```bash
uptime; nproc; cat /proc/loadavg
# interpret: is load/nproc > 1?
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

8 vCPU VM, load 12, iowait 55%, user 10%. Do you add CPUs? What do you inspect?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** Is load a percent?
- **Intermediate:** Why can load be high when CPU% is low?
- **Advanced:** What is a sensible load alert?

## 23. SRE scenario

Black Friday scale-out doubled pods. Load rose (more I/O to the same disk). You stop scaling and fix the datastore.

## 24. Summary

Load is a queue, including I/O waiters. Always pair with nproc and iowait.

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

- Here is what you already know from performance testing: You already watch utilization.
- Here is the SRE equivalent: Utilization without queueing is a lie. Load is the queue.
- Here is what you need to learn next: CPU breakdown: user, system, iowait, steal.
