# Viewing text — cat, less, head, tail

**Week:** W02 · **Visual:** [`../visuals/viewing-text.md`](../visuals/viewing-text.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

Tools to **read** bytes as text. `cat` dumps everything. `less` pages. `head`/`tail` take a window. `tail -f` follows a growing file — the incident tool.

## 2. Why does it exist?

Logs and configs are text. You cannot fix what you cannot see. Dumping a 4 GB log into your SSH session is how people freeze a laptop.

## 3. Why do I need to know this as an SRE?

`tail -f /var/log/myapp/error.log` while you reproduce is the cheapest tracer. `less +G` jumps to the end. `head` confirms format before you `grep` a monster.

## 4. Real-world analogy

`cat` is pouring the whole bucket on the table. `less` is a book. `tail -f` is watching the faucet.

## 5. How does it work internally?

These programs `open` and `read`. `less` keeps a position and talks to the tty (it wants a terminal). `tail -f` loops: read to EOF, sleep, `stat`/inotify, read again. If the file is **rotated** (new inode, same name), naive `tail -f` stays on the old inode. `tail -F` follows the *name*.

## 6. Syntax / structure

```bash
cat FILE
less FILE
head -n 50 FILE
tail -n 100 FILE
tail -f FILE
tail -F FILE
```

## 7. Basic example

```bash
tail -n 50 /var/log/syslog
# follow a lab file
echo start > /tmp/sre-follow.log
tail -f /tmp/sre-follow.log   # other terminal: echo more >> /tmp/sre-follow.log
```

## 8. Step-by-step execution

1. Shell finds the binary and `exec`s it with the path you gave.
2. `openat` the file (needs `r` on the file, `x` on parents).
3. `cat`/`head`/`tail` `read` and `write` to stdout.
4. `less` puts the tty in a different mode; `q` restores it.
5. `tail -f` does not exit until you Ctrl-C.

## 9. Why would I use this?

Read configs. Sample logs. Follow an error while you hit the endpoint.

## 10. When should I NOT use it?

Do not `cat` a binary. Do not `cat` a multi-GB log over SSH. Do not `less` in a script (no TTY).

## 11. Alternative ways

`grep`, `journalctl`, and your APM/Splunk are cousins. Use the smallest tool that answers the question.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| `cat` | whole file | simple | floods the session | tiny files |
| `less` | page | search, jump | needs TTY | humans |
| `head`/`tail` | window | safe on huge files | can miss context | first look |
| `tail -F` | follow name | survives rotation | still just one host | live incident |
| `journalctl -f -u` | unit logs | systemd-native | not every app | units |

## 13. Common mistakes

- `cat` huge files
- `tail -f` across a rotation and wondering why it froze
- piping `less` in cron
- assuming the log path in the unit file is the path the process *actually* opened

## 14. Troubleshooting

**Empty tail:** wrong file, permissions, or the app logs to stdout/journal. **Stuck tail -f:** watching a deleted inode. Switch to `-F` and confirm with `ls -l` / `stat`.

## 15. Production relevance

During a 503, one `tail -F` on one box beats opening twelve dashboards you do not understand yet.

## 16. Security considerations

Logs contain tokens, cookies, PII. Do not paste `tail` output into Slack unredacted. `less` of `/etc/shadow` as root is an audit event.

## 17. Performance considerations

Reading a huge file sequentially is cheap. Reading it over a 2G Wi-Fi SSH session is not. Filter on the box (`grep`, `journalctl --since`).

## 18. Related concepts

```text
paths → permissions → logs → journalctl → grep
```

## 19. Visual diagram

```text
app ──write──► app.log inode
                 ▲
                 │ tail -f   (this inode)
rotation ──► new inode, same name
tail -F ──► reopen the name
```

## 20. Hands-on exercise

```bash
printf 'line %s\n' $(seq 1 200) > "$HOME/sre-lab/lines.txt"
head -n 5 "$HOME/sre-lab/lines.txt"
tail -n 5 "$HOME/sre-lab/lines.txt"
# less: press q to quit
# less "$HOME/sre-lab/lines.txt"
```

Log the output (redacted) in `progress/daily-logs/`.

## 21. Mini challenge

An app rotated logs at 02:00. Your `tail -f` is silent but the new `app.log` is growing. What flag did you want, and why?

Do not look up the answer in this file. Write yours first.

## 22. Interview questions

- **Beginner:** cat vs less?
- **Intermediate:** tail -f vs tail -F?
- **Advanced:** How do you read the last 200 errors without downloading a 4 GB file?

## 23. SRE scenario

p95 explodes. You `tail -F` the app log, see `No space left on device`, and you already know the mount picture from Week 1.

## 24. Summary

Window first (`head`/`tail`). Page if needed (`less`). Follow the *name* in production (`tail -F`). Never `cat` a monster.

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

- Here is what you already know from performance testing: You already stare at listeners and log panels during a test.
- Here is the SRE equivalent: `tail -F` is the host-local version of a live listener.
- Here is what you need to learn next: `grep`/`journalctl` to filter; later Splunk.
