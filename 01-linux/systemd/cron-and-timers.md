# cron vs systemd timers

**Week:** W07 · **Visual:** [`../visuals/cron-and-timers.md`](../visuals/cron-and-timers.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

**cron** runs a command on a calendar (`*/5 * * * *`). **systemd timers** trigger a `.service` on a calendar or after boot. Both fail in the same ways: cwd, PATH, no TTY, silent errors.

## 2. Why does it exist?

Someone has to rotate logs, refresh certs, and run cleanups when you are asleep.

## 3. Why do I need to know this as an SRE?

A job that works in SSH and fails in cron is cwd/PATH/quoting. Prefer timers if you want journals and dependencies. Prefer cron if that is what the box already has — but make it boring and logged.

## 4. Real-world analogy

A wall timer (cron) vs a stage cue that also files a report (timer → service → journal).

## 5. How does it work internally?

cron daemon reads crontabs and `fork/exec`s `/bin/sh -c` with a minimal environment. systemd timers activate a service unit; you get `journalctl -u`. Neither is your interactive bashrc.

## 6. Syntax / structure

```bash
# crontab -e   (your user)
*/5 * * * * /usr/local/bin/cleanup.sh >> /var/log/cleanup.log 2>&1
# systemd
systemctl list-timers
systemctl cat cleanup.timer
```

## 7. Basic example

```bash
systemctl list-timers --all | head
crontab -l 2>/dev/null || echo 'no user crontab'
```

## 8. Step-by-step execution

1. Decide who should run it (user).
2. Use absolute paths.
3. Redirect stdout/stderr to a file or the journal.
4. Test with the same user: `sudo -u USER /abs/path`.

## 9. Why would I use this?

Periodic maintenance. Cert checks. Lab disk-watchers.

## 10. When should I NOT use it?

Do not put `cd foo; rm *` in cron. Do not run every second. Do not assume mail from cron arrives.

## 11. Alternative ways

Kubernetes CronJobs later. Same bugs, more YAML.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| cron | simple calendar | everywhere | weak logging | existing boxes |
| systemd timer | unit + journal | dependencies, timeout | more files | new work |
| external scheduler | fleet | central | another moving part | later |

## 13. Common mistakes

- relative paths
- relying on aliases
- no logs
- overlapping long jobs every 5 minutes

## 14. Troubleshooting

**Worked in SSH, failed in cron:** print env from the job. **Did not run:** timezone, anacron, or the user crontab vs /etc/cron.d format differences.

## 15. Production relevance

A silent cron that fails for 30 days is how certs expire. Alert on the *effect* (expiry) not only the job.

## 16. Security considerations

Writable cron dirs are persistence for attackers. Least privilege user. No secrets on the command line.

## 17. Performance considerations

Overlapping jobs are a self-DDoS. Use flock or a timer with RandomizedDelaySec.

## 18. Related concepts

```text
shell → PATH → cwd → systemd → logs
```

## 19. Visual diagram

```text
cron   */5 * * * *  /abs/script   →  tiny PATH, cwd=home
timer  cleanup.timer → cleanup.service → journalctl -u cleanup
```

## 20. Hands-on exercise

```bash
crontab -l 2>/dev/null || true
systemctl list-timers --all | head
# write a one-liner you would trust: absolute path + redirected logs
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

Cron: `cd /var/log/myapp && rm *.log`. It deleted something in $HOME. Why?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** Why cron != SSH?
- **Intermediate:** timer vs cron?
- **Advanced:** How do you prevent overlapping jobs?

## 23. SRE scenario

Cleanup cron ran from / and wiped a relative path. You restore from backup, rewrite with absolute paths and flock.

## 24. Summary

Absolute paths. Logs. Same user test. Timers if you want journals.

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

- Here is what you already know from performance testing: Scheduled test runs.
- Here is the SRE equivalent: Scheduled production work — with a worse environment.
- Here is what you need to learn next: SSH — how you arrive.
