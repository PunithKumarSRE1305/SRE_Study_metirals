# CPU saturation — user, system, iowait, steal

**Week:** W05 · **Visual:** [`../visuals/cpu-saturation.md`](../visuals/cpu-saturation.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

CPU time is split. **user**: app code. **system**: kernel. **iowait**: idle, waiting on I/O. **steal**: the hypervisor ran someone else. **idle**: truly nothing to do. Saturation means a queue — not just 'percent high'.

## 2. Why does it exist?

A single 'CPU%' hides the story. 30% CPU with 60% iowait is a disk incident.

## 3. Why do I need to know this as an SRE?

Your JMeter p99 often *is* iowait or steal. Adding app replicas will not fix a saturated disk or a noisy neighbor.

## 4. Real-world analogy

A factory: workers (user), supervisors (system), waiting on parts (iowait), landlord shut the power (steal).

## 5. How does it work internally?

`/proc/stat` counters. `vmstat 1`, `mpstat -P ALL 1`, `top` header. iowait means the CPU could run something else if it existed; if other tasks run, iowait drops. Steal is visible mostly in VMs/clouds.

## 6. Syntax / structure

```bash
vmstat 1 5
mpstat -P ALL 1 5
top          # look at the %Cpu line
```

## 7. Basic example

```bash
vmstat 1 5
grep cpu /proc/stat
```

## 8. Step-by-step execution

1. Sample /proc/stat twice.
2. Diff the counters.
3. Express as percent of interval.
4. Map to user/system/iowait/steal/idle.

## 9. Why would I use this?

Decide whether to profile the app, the disk, or open a cloud ticket about noisy neighbors.

## 10. When should I NOT use it?

Do not 'nice' everything randomly. Do not add CPUs when steal or iowait dominates.

## 11. Alternative ways

perf, flame graphs (later), and cgroup CPU limits (containers) refine this.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| vmstat | cheap split | everywhere | coarse | first |
| mpstat | per-CPU | find a hot core | more output | next |
| APM | user function | code-level | blind to steal | together |

## 13. Common mistakes

- 'CPU 30% so the app is fine' while iowait 60%
- Ignoring steal on EC2
- Scaling horizontally into the same disk

## 14. Troubleshooting

**One CPU 100%, others idle:** a single-threaded bottleneck. **All CPUs steal 40%:** hypervisor contention.

## 15. Production relevance

A 'slow after migrate to new instance family' is often steal or noisy neighbors. Check `steal` before rewriting the app.

## 16. Security considerations

None direct.

## 17. Performance considerations

This section *is* performance.

## 18. Related concepts

```text
load average → vmstat → iostat → process STAT D
```

## 19. Visual diagram

```text
%Cpu  us 30  sy 10  wa 50  st 5  id 5
         │        │       │
        app     kernel   disk wait
```

## 20. Hands-on exercise

```bash
vmstat 1 5
# write the us/sy/wa/st you saw and one sentence of meaning
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

CPU us=15 wa=0 st=45. Latency 10x. What is your first hypothesis?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** What is iowait?
- **Intermediate:** What is steal?
- **Advanced:** Why can CPU% be low and users unhappy?

## 23. SRE scenario

After moving to burstable instances, p99 explodes whenever credits empty. steal/throttle, not a code regression.

## 24. Summary

Split CPU. iowait is disk. steal is the neighbor. Saturation is a queue.

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

- Here is what you already know from performance testing: You already look at CPU graphs during a test.
- Here is the SRE equivalent: Now you split the graph into truths.
- Here is what you need to learn next: memory and OOM.
