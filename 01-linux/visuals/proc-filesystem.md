# Visual: /proc as an API

Full doc: [`../processes/proc-filesystem.md`](../processes/proc-filesystem.md)


```text
/proc/self/cwd   →  kernel's cwd pointer
/proc/self/fd/   →  open file descriptors
/proc/meminfo    →  memory counters
/proc/sys/       →  tunables (sysctl)
```

## Walk it

`/proc` is not a disk. It is the kernel exporting live state as files: processes, cpu, mem, mounts, net. `cat /proc/uptime` is a syscall dressed as a read.

**SRE why:** `ls /proc/PID/fd` is 'what files does this process have open?'. `cwd`, `environ`, `limits`, `status` — this is how you debug without strace first.

## 5-minute lab

```bash
ls /proc/$$
readlink /proc/$$/cwd
ls /proc/$$/fd | wc -l
grep 'open files' /proc/$$/limits
```

## Check yourself

An app dies with 'too many open files'. Which two /proc files prove it?
