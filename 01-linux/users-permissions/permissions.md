# Permission bits, chmod, octal

**Week:** W03 · **Visual:** [`../weeks/week-03/visuals/permissions.md`](../weeks/week-03/visuals/permissions.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

Every inode has a **mode**: type plus three triads of `rwx` for **user** (owner), **group**, and **other**. `chmod` changes those bits. Octal `754` is 7=rwx, 5=r-x, 4=r--.

## 2. Why does it exist?

The kernel must answer 'may this process do this to this inode?' without calling you.

## 3. Why do I need to know this as an SRE?

`chmod 777` is not a fix. It is an incident. You must predict whether *this* uid can write *this* file.

## 4. Real-world analogy

Three locks on a door: owner key, team key, everyone-else key. Each lock can allow read, write, or enter.

## 5. How does it work internally?

On `open`/`unlink`/`chdir`, the kernel compares the process credentials to the inode uid/gid, picks one triad (owner match wins, else group, else other), and checks the needed bit. For directories: `r`=list, `w`=create/delete names, `x`=traverse/cd. `umask` subtracts bits from new files.

## 6. Syntax / structure

```bash
ls -l FILE
chmod 640 FILE
chmod u+x FILE
chmod -R g-w DIR   # dangerous if you do not mean it
umask
```

## 7. Basic example

```bash
umask
touch "$HOME/sre-lab/mode.txt"
ls -l "$HOME/sre-lab/mode.txt"
chmod 640 "$HOME/sre-lab/mode.txt"
ls -l "$HOME/sre-lab/mode.txt"
```

## 8. Step-by-step execution

1. `ls -l` `stat`s the inode and prints the mode.
2. `chmod` issues `chmod(2)` with the new mode.
3. Next `open` uses the new bits.
4. A running process that already has an fd is not retroactively kicked out.

## 9. Why would I use this?

Make a log file `640` owned by the app. Make a script executable for the owner only (`700`).

## 10. When should I NOT use it?

Do not `chmod -R 777`. Do not `chmod` a file to fix a *directory* `x` problem. Do not chmod `/usr` by hand.

## 11. Alternative ways

ACLs (`setfacl`) exist when three triads are not enough. Learn bits first.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| symbolic u+x | human intent | readable | easy to mis-scope | one-off |
| octal 640 | exact bits | unambiguous | you must know the math | runbooks |
| ACL | extra entries | flexible | harder to see | shared dirs later |

## 13. Common mistakes

- 777
- Forgetting directory `x`
- chmod the file when the parent is the problem
- Ignoring umask and wondering why files are 666

## 14. Troubleshooting

**Cannot cd:** missing `x` on a parent. **Cannot ls:** missing `r` on the directory. **Cannot write:** missing `w` on file *or* directory (for create).

## 15. Production relevance

A deploy that `chmod 777` a shared upload dir will pass the functional test and fail the security review — and invite tampering.

## 16. Security considerations

World-writable cron, authorized_keys, or web roots are compromise paths. Least privilege is reliability.

## 17. Performance considerations

Irrelevant except `chmod -R` on huge trees (metadata storm).

## 18. Related concepts

```text
users → mode bits → ownership → umask → sudo
```

## 19. Visual diagram

```text
-rwxr-x---  app deploy  app.sh
 USER rwx=7  GROUP r-x=5  OTHER ---=0   →  750
dir: r=list  w=create/delete  x=enter
```

## 20. Hands-on exercise

```bash
f=$HOME/sre-lab/perm.txt; echo x > "$f"
chmod 600 "$f"; ls -l "$f"
chmod 644 "$f"; ls -l "$f"
mkdir -p "$HOME/sre-lab/locked"; chmod 700 "$HOME/sre-lab/locked"
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

A teammate cannot `cd /opt/app/conf` but can `ls /opt/app`. Which bit is missing, on which inode?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** What is 755 on a directory?
- **Intermediate:** Why can you cd but not ls?
- **Advanced:** Why does chmod not stop a process that already has the file open?

## 23. SRE scenario

On-call `chmod 777` to silence 403s. Next day the box is a drop box. You revert to 750, fix the group, write the postmortem.

## 24. Summary

Three triads. Directory `x` is enter. Octal is 4+2+1. 777 is an incident.

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

- Here is what you already know from performance testing: Assertions that always pass are worse than none.
- Here is the SRE equivalent: A world-writable path will pass a functional test and fail the company.
- Here is what you need to learn next: Ownership, setgid, sudo.
