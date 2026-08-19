# Filesystem Hierarchy Standard (FHS)

## 1. What is it?

A convention for **what the top of a Linux tree means**.

`/` is the root. Under it, names are not random. `/etc` is configuration. `/var` is variable data. `/proc` is the kernel pretending to be files.

It is a standard (FHS) plus distro habits. Not every embedded box obeys it. Servers mostly do.

## 2. Why does it exist?

Without a shared map, every vendor dumps files in `/opt/company/foo/misc`. You cannot find logs at 02:00. Package managers cannot upgrade safely. Backups cannot tell "intent" from "life."

## 3. Why do I need to know this as an SRE?

Because someone will say "check the logs" and mean one of five places. Because "disk full" is almost always *one mount under this tree*. Because config you edit in the wrong tree is config the process will never read.

## 4. Real-world analogy

A city zoning law. You can still build a factory in a residential zone, but everyone after you will suffer.

## 5. How does it work internally?

Nothing magical enforces FHS. It is:

- directories created by the distro installer
- package manager file lists
- the kernel's special mounts (`proc`, `sysfs`, `devtmpfs`)
- applications that *choose* to follow it (good) or not (your future incident)

```text
/                     root of this mount (often the OS disk)
├── bin → usr/bin     essential user commands (often a symlink now)
├── sbin              essential admin commands (often merged)
├── etc               configuration (static-ish intent)
├── home              human homes
├── root              root's home (not /)
├── var               variable data (logs, spool, cache)
├── tmp               scratch (sticky bit, may be tmpfs)
├── usr               userland programs and share
├── opt               optional third-party add-ons
├── boot              kernels, initramfs, bootloader
├── dev               device nodes
├── proc              process + kernel API
├── sys               devices / kernel objects API
└── run               runtime state since boot (tmpfs)
```

Modern Debian/Ubuntu **merge** `/bin` into `/usr/bin`. `ls -l /bin` shows a symlink. That is not a virus.

## 6. Syntax / structure

```bash
ls -l /
readlink -f /bin
```

## 7. Basic example

```bash
ls /etc | head
ls /var/log | head
ls /proc | head
```

Same command. Three different kinds of "file."

## 8. Step-by-step execution

When you `ls /var/log`:

1. Shell asks the kernel to open the inode for `/var/log`.
2. Kernel walks `/` → `var` → `log`, checking execute (search) permission on each directory.
3. Kernel lists directory entries (names + inode numbers).
4. `ls` may `stat` each name for the long listing.

If `/var` is a **separate mount**, step 2 crosses a mount point. The bytes live on another device. `df /var/log` and `df /` can disagree.

## 9. Why would I use this?

- Predict paths (`nginx` access log is probably `/var/log/nginx/`)
- Know what is safe to truncate vs what is a config
- Know that `/proc` will not free disk if you "clean" it

## 10. When should I NOT use it?

Do not memorize every FHS paragraph. Do not delete `/usr` to "free space." Do not assume Windows-like "Program Files" thinking (`C:` vs `D:` is a mount conversation — use `df`/`findmnt`).

## 11. Alternative ways

Some apps live entirely in `/opt/app` or `/srv`. Containers may have a *tiny* FHS. systemd also uses `/run`. Know the local map (Week 1 Day 6 project) rather than a textbook.

## 12. Comparison

| Path | Purpose | Grows? | Edit by hand? |
| ---- | ------- | ------ | ------------- |
| `/etc` | Config | no | yes, carefully |
| `/var` | Life of the machine | **yes** | rarely |
| `/usr` | Programs | via packages | no |
| `/home` | People | yes | yes |
| `/proc` | Kernel API | no (virtual) | knobs only |
| `/tmp` | Scratch | yes, wiped | yes |
| `/opt` | Third-party | maybe | app-specific |

## 13. Common mistakes

- Editing files under `/usr` that a package will overwrite
- Assuming `/tmp` survives reboot
- Assuming `/root` is the filesystem root
- Cleaning `/var/log` with `rm -rf` and deleting the directory the app still has open (space not freed)
- Ignoring that `/var` is its own full disk

## 14. Troubleshooting

Disk 100% but `du -sh /*` does not add up: deleted-but-open files, or a mount hiding a directory that filled *underneath* it. (`du` vs `df` — Month 2.)

## 15. Production relevance

Log volume from a debug flag fills `/var`. The OS disk (`/`) is fine. SSH still works. The app 500s because it cannot write. Health checks fail. The load balancer removes the instance. From the outside: "flaky hosts." From FHS: `/var` needed rotation.

## 16. Security considerations

`/etc/shadow` is mode 640 for a reason. `/tmp` is world-writable with a sticky bit — classic attack surface. `/proc` leaks information; hidepid exists for a reason. Do not `chmod -R 777 /var` to "make the app work."

## 17. Performance considerations

Logs on the same disk as the database = your soak test is also a storage test of `journald`. Separate mounts exist so I/O and capacity can be planned independently.

## 18. Related concepts

```text
FHS → paths → mounts → permissions → logs → systemd
```

## 19. Visual diagram

```text
                 /
                 |
     +-----+-----+------+------+------+
     |     |     |      |      |      |
    etc   var   usr    home   proc   tmp
     |     |                    |
   nginx  log                 1 2 3 ...
           |
         nginx/access.log
```

## 20. Hands-on exercise

Build the table from Day 2 for *your* box. Add `findmnt` output.

## 21. Mini challenge

An image has no `/var/log/nginx` directory. The container starts, nginx errors, dies. Which FHS assumption did the Dockerfile violate, and what are two correct fixes?

## 22. Interview questions

- **Beginner:** What belongs in `/etc` vs `/var`?
- **Intermediate:** Why might `/bin` be a symlink to `usr/bin`?
- **Advanced:** How can `df /` be 10% while an app cannot write logs?

## 23. SRE scenario

02:00. 503s. CPU 20%. `/` is 35%. Junior engineer: "disk is fine." You `df -h /var`. 100%. You rotate or truncate the *right* file, not "the disk."

## 24. Summary

The tree is zoned. `/etc` is intent. `/var` is life. `/proc` is the kernel. Mounts slice the tree onto devices. "The disk" is not a place.

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

- Your test's log volume is a capacity plan for `/var` (or the container writable layer).
- Next: how names become lookups — paths.
