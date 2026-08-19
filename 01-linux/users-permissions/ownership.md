# Ownership, chown, sticky bit, setgid

**Week:** W03 · **Visual:** [`../visuals/ownership.md`](../visuals/ownership.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

**Ownership** is the uid/gid stored on the inode. `chown`/`chgrp` change it. The **sticky bit** on a directory (like `/tmp`) means only the file's owner (or root) can delete the name. **setgid** on a directory makes new files inherit the directory's group — the shared-team-dir pattern.

## 2. Why does it exist?

Bits without owners are meaningless. Shared directories need extra rules so people cannot delete each other's files.

## 3. Why do I need to know this as an SRE?

A deploy user writes logs as `deploy`. The app runs as `app`. Without the right group + setgid, you get 403/500 after every release.

## 4. Real-world analogy

A locker room: lockers have owners. Sticky bit = you can only open *your* locker. setgid = new lockers are painted with the team color.

## 5. How does it work internally?

`chown` is `chown(2)` and usually requires privilege. Sticky = mode bit `01000` (`t` in `ls`). setgid on dir = `02000` (`s` on the group-x slot). New files get the directory gid when setgid is set (and typically the creating process's umask still applies).

## 6. Syntax / structure

```bash
ls -ld DIR
sudo chown app:app FILE
chmod 1777 /tmp     # sticky, already the case
chmod 2775 /var/app/shared   # setgid + rwxrwsr-x
```

## 7. Basic example

```bash
ls -ld /tmp   # look for the t
stat -c '%A %U %G' "$HOME"
```

## 8. Step-by-step execution

1. `ls -l` shows owner and group names (or numbers).
2. `chown user:group` changes both.
3. New files get creator uid and (usually) creator gid unless setgid.
4. Deletes in a sticky directory check the *file* owner.

## 9. Why would I use this?

Align file owner with the systemd `User=`. Build a shared lab dir with setgid.

## 10. When should I NOT use it?

Do not `chown -R root:root /` 'to fix permissions'. Do not setuid (`chmod u+s`) unless you can explain the attack.

## 11. Alternative ways

ACLs can express 'this extra user also has write'. Prefer a group if you can.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| chown app:app | align identity | clear | needs privilege | after deploys |
| setgid dir | shared team files | new files join the group | easy to forget umask | shared queues |
| sticky /tmp | stop delete wars | classic | not a security boundary alone | world-writable dirs |

## 13. Common mistakes

- chown -R on /
- Forgetting setgid so new files are the deployer's group
- Treating sticky as 'secure tmp'

## 14. Troubleshooting

**Cannot delete my file in /tmp:** you are not the owner and sticky is set. **New files not group-writable:** umask 022 + missing setgid.

## 15. Production relevance

CI writes artifacts as `runner`, app reads as `app`. The shared volume needs a common group, not 777.

## 16. Security considerations

setuid binaries are a privilege boundary. Unexpected `s` bits are a finding. Sticky tmp is still a symlink-attack surface.

## 17. Performance considerations

`chown -R` on millions of files is an I/O event.

## 18. Related concepts

```text
users → permissions → chown → systemd User= → umask
```

## 19. Visual diagram

```text
shared/   drwxrwsr-x  app  deploy   (setgid)
   new.log  -rw-rw-r--  app  deploy  ← group inherited
/tmp      drwxrwxrwt                 (sticky t)
```

## 20. Hands-on exercise

```bash
ls -ld /tmp
stat -c '%a %A %U %G' /tmp
mkdir -p "$HOME/sre-lab/shared"
chmod 2775 "$HOME/sre-lab/shared"
ls -ld "$HOME/sre-lab/shared"
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

Design mode+owner+group for `/var/log/myapp` so the app can write, a `support` group can read, and others cannot.

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** What does the t on /tmp mean?
- **Intermediate:** What does setgid on a directory do?
- **Advanced:** When is chown -R the wrong fix?

## 23. SRE scenario

After a pipeline change, new logs are `runner:runner` 644. App cannot append. You chown, add setgid, fix the pipeline user.

## 24. Summary

Owner+group are identity. Sticky stops deletes. setgid keeps a team group. Never chown the world.

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

- Here is what you already know from performance testing: The user that generates load is not the user that writes logs.
- Here is the SRE equivalent: Ownership mismatch shows up as errors only on the write path — often under load.
- Here is what you need to learn next: sudo.
