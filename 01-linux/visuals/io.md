# Visual: I/O wait and disk saturation

Full doc: [`../io/io.md`](../io/io.md)


```text
app write()  →  page cache  →  disk queue  →  device
                 │                 │
              fast if hit      await grows when saturated
```

## Walk it

**iowait** is CPU idle time spent waiting on I/O. **Disk saturation** is a device with a full queue (high await, high util in iostat). The app feels this as latency, not as 'CPU busy'.

**SRE why:** CPU 30%, latency 5s, iowait 60% — do not profile Java first. Look at the disk, the NFS mount, or the log volume.

## 5-minute lab

```bash
vmstat 1 5
# note the wa column; one sentence: is this host I/O waiting?
```

## Check yourself

wa=40, one disk at 100% util, it is the log volume. Immediate mitigation?
