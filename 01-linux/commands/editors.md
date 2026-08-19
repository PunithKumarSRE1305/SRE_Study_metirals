# Editors enough to survive — nano and vi

**Week:** W02 · **Visual:** [`../visuals/editors.md`](../visuals/editors.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

An **editor** changes a file in place on the box. `nano` is guided. `vi`/`vim` is everywhere — including rescue environments. You need enough `vi` to change one line and exit without panic.

## 2. Why does it exist?

There is no VS Code on a broken bastion. There is `vi`. Incidents are lost when someone cannot edit `/etc/hosts` or a unit file.

## 3. Why do I need to know this as an SRE?

You will edit a unit, a sudoers snippet (via `visudo`), a nginx config, a crontab. Doing it wrong without a backup is a second incident.

## 4. Real-world analogy

A field radio vs a recording studio. Ugly, reliable, always there.

## 5. How does it work internally?

The editor reads the file into a buffer, lets you change the buffer, then writes (often via a temp file + rename). If the disk is full, the write fails and you can lose the buffer. `vim` swap files exist so a crash can recover — they also litter `/var/tmp`.

## 6. Syntax / structure

```bash
# nano
nano FILE          # Ctrl-O save, Ctrl-X exit
# vi
vi FILE
  i          insert
  Esc        normal mode
  :w         write
  :q         quit
  :q!        quit discarding
  :wq        write and quit
```

## 7. Basic example

```bash
printf 'listen 80;\n' > "$HOME/sre-lab/demo.conf"
nano "$HOME/sre-lab/demo.conf"   # or vi — add a comment, save, exit
cat "$HOME/sre-lab/demo.conf"
```

## 8. Step-by-step execution

1. Open the file (needs `r`; write needs `w` on file and directory).
2. Edit the buffer — the file on disk is unchanged until save.
3. Save issues `write`/`rename`.
4. If you cannot save: write to `/tmp` and copy later. Do not keep bashing `:w`.

## 9. Why would I use this?

One-line config fixes. Commit-worthy changes still belong in git when you have it.

## 10. When should I NOT use it?

Do not compose a 200-line script in `vi` on production. Do not edit `/etc` without knowing how to revert. Do not use `vim` tutorials as today's entire 2 hours.

## 11. Alternative ways

`sed -i` is an editor you cannot see. Use it only when you can say exactly what will change.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| nano | guided | obvious keys | not always installed | beginners |
| vi | universal | on every box | modal, easy to get stuck | rescue, servers |
| `sed -i.bak` | scripted | repeatable | easy to destroy | known replace |
| git + deploy | proper change | reviewable | slower | anything that should last |

## 13. Common mistakes

- Stuck in vi insert mode, typing `:q` into the file
- Saving a broken sudoers with `vi` instead of `visudo`
- No backup
- Editing the running binary's config and not reloading the process

## 14. Troubleshooting

**vi beeps and won't quit:** Esc, then `:q!`. **Read-only:** you opened as the wrong user; `:w /tmp/x` then copy with sudo. **nano missing:** use `vi`.

## 15. Production relevance

A bad edit of a unit file + `daemon-reload` + `restart` is a self-inflicted outage. Keep the previous working copy.

## 16. Security considerations

`visudo` syntax-checks sudoers. Raw `vi /etc/sudoers` can lock everyone out. Never edit secrets in a shared tmux without knowing who is attached.

## 17. Performance considerations

Irrelevant compared to saving a broken file.

## 18. Related concepts

```text
permissions → sudo → systemd → git
```

## 19. Visual diagram

```text
disk file ──open──► editor buffer ──save──► disk file
                     │
                     └── abandon (:q!) ──► disk unchanged
```

## 20. Hands-on exercise

```bash
# Survive vi in 5 minutes
printf 'old\n' > "$HOME/sre-lab/vi-practice.txt"
# Open with vi, press i, change to new, Esc, :wq
vi "$HOME/sre-lab/vi-practice.txt"
cat "$HOME/sre-lab/vi-practice.txt"
```

Log the output (redacted) in `progress/daily-logs/`.

## 21. Mini challenge

You opened `/etc/hosts` with `vi` as yourself and cannot save. How do you keep the buffer and still write the file safely?

Do not look up the answer in this file. Write yours first.

## 22. Interview questions

- **Beginner:** How do you exit vi without saving?
- **Intermediate:** Why visudo not vi /etc/sudoers?
- **Advanced:** How do you edit when the disk is too full to save?

## 23. SRE scenario

sshd config typo, you cannot SSH back. Console + `vi` + the last known good ListenAddress. This is why Week 8 includes lockout recovery.

## 24. Summary

nano if present. vi always: `i`, Esc, `:wq` / `:q!`. Backup first. `visudo` for sudoers.

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

- Here is what you already know from performance testing: You already edit JMeter scripts and CSV configs.
- Here is the SRE equivalent: Same job, hostile environment, no GUI.
- Here is what you need to learn next: sudo and unit files.
