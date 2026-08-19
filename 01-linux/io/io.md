# I/O wait and disk saturation

**Week:** W06 · **Visual:** [`../visuals/io.md`](../visuals/io.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

**iowait** is CPU idle time spent waiting on I/O. **Disk saturation** is a device with a full queue (high await, high util in iostat). The app feels this as latency, not as 'CPU busy'.

## 2. Why does it exist?

Storage is slower than RAM by orders of magnitude. Queues form. Tails explode.

## 3. Why do I need to know this as an SRE?

CPU 30%, latency 5s, iowait 60% — do not profile Java first. Look at the disk, the NFS mount, or the log volume.

## 4. Real-world analogy

Cashiers idle because the warehouse elevator is stuck. The store looks 'not busy' from the street.

## 5. How does it work internally?

`iostat -xz 1` (sysstat) shows r/s w/s, await, %util. %util ~100% means the device had work the whole interval — a saturation hint, not a perfect metric on modern SSDs/NVMe. `vmstat` `wa` column is iowait.

## 6. Syntax / structure

```bash
vmstat 1 5
# if installed:
iostat -xz 1 5
```

## 7. Basic example

```bash
vmstat 1 5
```

## 8. Step-by-step execution

1. Confirm wa in vmstat.
2. Identify the device (iostat or /proc/diskstats).
3. See if it is reads or writes.
4. Map to the mount (`lsblk`, `df`).
5. Ask: logs? database? swap?

## 9. Why would I use this?

Latency without CPU. Soak tests that degrade. Swap storms.

## 10. When should I NOT use it?

Do not buy faster CPUs. Do not drop_caches as a cure.

## 11. Alternative ways

eBPF/iosnoop later. Cloud disk burst credits are the same idea as CPU steal.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| vmstat wa | host iowait | everywhere | not which disk | first |
| iostat | per device | the truth-ish | may be missing | next |
| APM | user latency | what users feel | not the device | together |

## 13. Common mistakes

- Ignoring burst-credit disks
- Logging at DEBUG to the same disk as the database
- Swap + database on one volume

## 14. Troubleshooting

**High await, low util:** maybe many slow ops or a remote volume. **High util, low await:** busy but keeping up. **wa high, iostat idle:** I/O is network/NFS not a local disk.

## 15. Production relevance

Co-locating WAL and logs on gp2-without-credits is a Friday outage.

## 16. Security considerations

None direct.

## 17. Performance considerations

This is performance. Queueing, not averages.

## 18. Related concepts

```text
iowait → iostat → mounts → logs → capacity
```

## 19. Visual diagram

```text
app write()  →  page cache  →  disk queue  →  device
                 │                 │
              fast if hit      await grows when saturated
```

## 20. Hands-on exercise

```bash
vmstat 1 5
# note the wa column; one sentence: is this host I/O waiting?
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

wa=40, one disk at 100% util, it is the log volume. Immediate mitigation?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** What is iowait?
- **Intermediate:** Why can CPU be idle and users wait?
- **Advanced:** Limitations of %util on NVMe?

## 23. SRE scenario

p99 tracks disk await after a 'debug=true' flag. You turn it off, rotate, add an alert on log volume util.

## 24. Summary

iowait is waiting, not working. Find the device. Stop the write storm.

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

- Here is what you already know from performance testing: Disk graphs during a soak.
- Here is the SRE equivalent: await and wa are those graphs' parents.
- Here is what you need to learn next: mounts.
