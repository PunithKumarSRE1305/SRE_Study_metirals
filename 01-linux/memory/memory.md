# Memory — RSS, cache, available, OOM

**Week:** W05 · **Visual:** [`../visuals/memory.md`](../visuals/memory.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

**RSS** is a process's resident pages. **Page cache** is file data the kernel keeps and can drop instantly. **Available** (from `free -h`) is what an SRE should read — it includes reclaimable cache. **OOM killer** is the kernel murdering a process to keep the box alive.

## 2. Why does it exist?

RAM is a cache hierarchy. Treating 'used' as 'full' causes panic-reboots of healthy machines.

## 3. Why do I need to know this as an SRE?

Linux using 95% of RAM with huge cache is often *healthy*. OOM is not. `dmesg`/`journalctl -k` names the victim. A leak shows as RSS climbing across a soak — your home turf.

## 4. Real-world analogy

A desk (RSS), a library cart of recently used books (cache) you can put back instantly, and a bouncer (OOM) who throws someone out when the room cannot breathe.

## 5. How does it work internally?

The kernel reclaim path evicts cache and inactive anon pages, then swaps (if any), then OOM. `free -h` shows total/used/free/shared/buff/cache/available. `oom_score` in `/proc/PID` influences who dies. cgroup limits (containers) have their own OOM.

## 6. Syntax / structure

```bash
free -h
ps aux --sort=-%mem | head
# after a suspected OOM:
journalctl -k | grep -i oom
```

## 7. Basic example

```bash
free -h
cat /proc/meminfo | egrep 'MemTotal|MemAvailable|Cached|Swap'
```

## 8. Step-by-step execution

1. Read MemAvailable, not MemFree.
2. Check swap in/out in vmstat.
3. Sort processes by RSS.
4. If something died, read the OOM dump.

## 9. Why would I use this?

Decide if you have a leak, a cache-filled healthy box, or an imminent OOM.

## 10. When should I NOT use it?

Do not disable the OOM killer. Do not drop caches (`echo 3 > drop_caches`) on production as a ritual.

## 11. Alternative ways

cgroup memory.max, JVM -Xmx, and node-exporter metrics are how you productionize this.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| free -h | host summary | fast | not per-cgroup | first |
| ps RSS | per process | find the hog | misses shared nuance | next |
| OOM log | who died | ground truth | after the fact | always check |

## 13. Common mistakes

- Rebooting because 'used is 90%' (it is cache)
- No swap and no limits → surprise OOM
- Forgetting container memory limits

## 14. Troubleshooting

**Process vanished, exit 137:** often SIGKILL from OOM (128+9). Confirm in kernel log. **Available falling during soak:** leak or working set growth.

## 15. Production relevance

A pod OOMKilled is this picture inside a cgroup. The node may still look fine in `free`.

## 16. Security considerations

OOM can kill security agents first if scores are wrong. Watch who dies.

## 17. Performance considerations

Reclaim and swap thrash destroy tail latency. You have seen this as a soak that gets worse after hour two.

## 18. Related concepts

```text
process RSS → meminfo → OOM → cgroup → soak tests
```

## 19. Visual diagram

```text
RAM: [ RSS apps | page cache (droppable) | free ]
                └──────── available ──────────┘
If available → 0 and reclaim fails → OOM killer
```

## 20. Hands-on exercise

```bash
free -h
ps aux --sort=-%mem | head -8
grep -i oom /var/log/kern.log 2>/dev/null | tail || journalctl -k | grep -i oom | tail
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

free says used 92%, available 8 GB, cache 40 GB. Is the host in trouble? Why?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** RSS vs cache?
- **Intermediate:** What should you read in free -h?
- **Advanced:** How do you prove OOM?

## 23. SRE scenario

API pods restart every night. exit 137. Kernel log: oom-kill of java. You cap the heap and the cgroup, add an alert on available.

## 24. Summary

Available, not used. Cache is not the enemy. OOM is a named murder — read the log.

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

- Here is what you already know from performance testing: Soak tests and memory leaks are your craft.
- Here is the SRE equivalent: RSS slope *is* the leak. OOM is the production ending.
- Here is what you need to learn next: /proc as an API.
