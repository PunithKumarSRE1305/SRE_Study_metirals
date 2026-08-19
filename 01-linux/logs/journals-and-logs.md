# journalctl and /var/log

**Week:** W07 · **Visual:** [`../visuals/journals-and-logs.md`](../visuals/journals-and-logs.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

**journald** collects stdout/stderr and syslog into a binary journal. **`journalctl`** queries it. Classic text files still live under `/var/log` (nginx, auth, older apps). You need both.

## 2. Why does it exist?

If logs are everywhere, you will miss the line that explains the 503.

## 3. Why do I need to know this as an SRE?

`journalctl -u myapp -b --since '10 min ago'` is the default. `-f` follows. `-p err` filters priority. `/var/log` is where non-journal apps still write — and where disks fill.

## 4. Real-world analogy

A searchable archive (journal) plus a pile of notebooks in a drawer (`/var/log`).

## 5. How does it work internally?

Apps logging to stdout under systemd go to journald. Some still open files. journald can persist under `/var/log/journal` or be volatile in `/run`. Rotation is journald config *and* logrotate for text files.

## 6. Syntax / structure

```bash
journalctl -u UNIT -b
journalctl -f -u UNIT
journalctl --since '1 hour ago' -p err
ls /var/log
tail -F /var/log/nginx/error.log
```

## 7. Basic example

```bash
journalctl -b -n 20
ls /var/log | head
```

## 8. Step-by-step execution

1. Pick the unit or the file.
2. Bound time (`--since`, `-b` this boot).
3. Filter priority or grep.
4. Follow if live.

## 9. Why would I use this?

Every incident. Confirm a restart. Prove a config reload.

## 10. When should I NOT use it?

Do not `journalctl` without a filter on a busy host (it will flood). Do not delete `/var/log/journal` to 'free space' without knowing retention.

## 11. Alternative ways

Splunk/ELK later ship these lines off-box. You still need local logs when the shipper is the incident.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| journalctl -u | unit-centric | structured metadata | binary, needs tool | systemd apps |
| /var/log files | app-centric | grep/tail -F | fill disks | nginx, older stacks |
| central SIEM | fleet | search yesterday | not this host now | later |

## 13. Common mistakes

- No time bound
- Assuming the app uses the journal when it writes a file
- rotation only matching `*.log` leaving `.debug` behind

## 14. Troubleshooting

**No journal:** persistent storage off, or wrong unit name (`systemctl list-units | grep app`). **Permission denied:** you need sudo or the systemd-journal group.

## 15. Production relevance

Disk-full is usually `/var/log`. journald `SystemMaxUse=` and logrotate are prevention.

## 16. Security considerations

auth.log/secure are forensic gold. Logs contain secrets. Access is privileged.

## 17. Performance considerations

Verbose debug to disk is a self-inflicted soak. You have caused this with JMeter + debug.

## 18. Related concepts

```text
systemd → stdout → journald → /var/log → rotation → Splunk later
```

## 19. Visual diagram

```text
app stdout  →  journald  →  journalctl
app file    →  /var/log/app/app.log  →  tail -F / logrotate
```

## 20. Hands-on exercise

```bash
journalctl -b -n 15
ls /var/log
journalctl --since '15 min ago' -p warning | tail
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

Unit is running, journal is empty, but /var/log/myapp/app.log grows. Where do you look, and why did status lie?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** journalctl vs tail?
- **Intermediate:** How do you follow one unit?
- **Advanced:** How do logs fill a disk?

## 23. SRE scenario

After a debug flag, /var fills in 40 minutes. You revert the flag, vacuum the journal, add SystemMaxUse and an alert.

## 24. Summary

Time-bound journalctl for units. tail -F for files. Rotation is reliability.

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

- Here is what you already know from performance testing: Splunk searches after a test.
- Here is the SRE equivalent: journalctl is the on-box version. Same instinct, local first.
- Here is what you need to learn next: cron/timers.
