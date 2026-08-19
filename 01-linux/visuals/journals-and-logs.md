# Visual: journalctl and /var/log

Full doc: [`../logs/journals-and-logs.md`](../logs/journals-and-logs.md)


```text
app stdout  →  journald  →  journalctl
app file    →  /var/log/app/app.log  →  tail -F / logrotate
```

## Walk it

**journald** collects stdout/stderr and syslog into a binary journal. **`journalctl`** queries it. Classic text files still live under `/var/log` (nginx, auth, older apps). You need both.

**SRE why:** `journalctl -u myapp -b --since '10 min ago'` is the default. `-f` follows. `-p err` filters priority. `/var/log` is where non-journal apps still write — and where disks fill.

## 5-minute lab

```bash
journalctl -b -n 15
ls /var/log
journalctl --since '15 min ago' -p warning | tail
```

## Check yourself

Unit is running, journal is empty, but /var/log/myapp/app.log grows. Where do you look, and why did status lie?
