# Visual: ps and top — reading process tables

Full doc: [`../processes/ps-and-top.md`](../processes/ps-and-top.md)


```text
USER PID %CPU %MEM STAT COMMAND
app  4402 98.1 12.0  R    java -jar app.jar     ← CPU hog
app  4403  0.0  4.0  D    java                   ← stuck on disk
```

## Walk it

`ps` is a snapshot of processes. `top`/`htop` is a repeating snapshot with CPU/memory sorted. Columns are kernel bookkeeping: pid, user, %CPU, %MEM, VSZ, RSS, STAT, START, TIME, COMMAND.

**SRE why:** CPU 100% is a pid, not a mood. `ps aux --sort=-%cpu | head` is a first move. Learn STAT: R running, S sleep, D uninterruptible, Z zombie, < high priority.

## 5-minute lab

```bash
ps -p $$ -o pid,ppid,user,stat,%cpu,%mem,cmd
ps aux --sort=-%cpu | head -8
top -n 1 -b | head -15
```

## Check yourself

top shows a process at 0% CPU, STAT D, and users are timing out. What do you *not* do first?
