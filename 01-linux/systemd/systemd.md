# systemd units — start, enable, restart

**Week:** W07 · **Visual:** [`../visuals/systemd.md`](../visuals/systemd.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

**systemd** is pid 1 on most servers. A **unit** (`.service`, `.timer`, `.socket`) is a file that declares how to start, stop, and depend on something. **start** means now. **enable** means at boot. They are not the same.

## 2. Why does it exist?

Somebody has to start sshd, your app, and journald in a known order, restart them on crash, and collect their logs.

## 3. Why do I need to know this as an SRE?

`systemctl status UNIT` is the first command on a 'service is down' ticket. `Restart=on-failure` plus a crash is a crash loop — read the journal, do not only restart again.

## 4. Real-world analogy

A theatre stage manager: cues (dependencies), who is on stage (active), and what happens if an actor faints (Restart=).

## 5. How does it work internally?

Unit files live in `/lib/systemd/system` (packages) and `/etc/systemd/system` (local). `daemon-reload` after edits. systemd forks/execs `ExecStart=`, tracks the main pid, sends TERM then KILL on stop. `WantedBy=multi-user.target` is how enable works.

## 6. Syntax / structure

```bash
systemctl status UNIT
systemctl start|stop|restart UNIT
systemctl enable|disable UNIT
systemctl daemon-reload
systemctl cat UNIT
```

## 7. Basic example

```bash
systemctl status ssh || systemctl status sshd
systemctl is-enabled ssh 2>/dev/null || true
```

## 8. Step-by-step execution

1. status reads the unit + the process + recent logs.
2. start asks pid 1 to exec ExecStart.
3. enable creates a symlink into a target.wants/.
4. restart is stop then start (watch TimeoutStopSec).

## 9. Why would I use this?

Operate any modern Linux service. Write a unit for your lab app in the mini-project.

## 10. When should I NOT use it?

Do not `kill -9` a unit's process and expect systemd to be happy forever (it will restart it if told). Do not edit files under /lib — override in /etc.

## 11. Alternative ways

SysV init scripts still exist on old boxes. You will meet them; do not seek them.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| systemctl | the manager | state + logs | systemd-only | default |
| raw exec | debug | simple | no restart policy | lab |
| cron @reboot | ancient | works | no supervision | avoid |

## 13. Common mistakes

- start without enable (surprise after reboot)
- forgetting daemon-reload
- Restart=always hiding a crashloop
- editing the vendor unit in place

## 14. Troubleshooting

**activating (auto-restart):** crashloop — `journalctl -u UNIT -b`. **failed:** read status, then the journal. **inactive (dead):** not started, or finished a oneshot.

## 15. Production relevance

A deploy that forgets daemon-reload + restart leaves the old binary running. Health checks may still pass until the next reboot.

## 16. Security considerations

Units can run as User=/Group=. AmbientCapabilities. Do not run internet-facing apps as root 'because the port is 80' — use a listener or capabilities.

## 17. Performance considerations

Restart storms (RestartSec=0) can DoS the box. Back off.

## 18. Related concepts

```text
process → signals → unit → journald → timers
```

## 19. Visual diagram

```text
myapp.service  →  systemd (pid 1)  →  myapp pid
       │                                  │
    enable@boot                      stdout → journald
```

## 20. Hands-on exercise

```bash
systemctl status ssh || systemctl status sshd
systemctl cat ssh 2>/dev/null || systemctl cat sshd | head -30
systemctl is-enabled ssh 2>/dev/null || systemctl is-enabled sshd
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

After reboot the app is down. systemctl status says disabled. What was forgotten, and how do you tell start from enable?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** start vs enable?
- **Intermediate:** Where do unit files live?
- **Advanced:** How do you debug a crashloop?

## 23. SRE scenario

On-call restarts a crashlooping unit 15 times. You show them the journal: missing config after a deploy. Roll back.

## 24. Summary

start=now, enable=boot. status+journal before another restart. Reload after edits.

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

- Here is what you already know from performance testing: You already start/stop test engines.
- Here is the SRE equivalent: systemd is how production starts/stops the SUT.
- Here is what you need to learn next: journals.
