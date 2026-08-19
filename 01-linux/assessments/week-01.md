# Assessment: Week 01 — Linux first contact

- Module: 01-linux
- Week: 01
- Attempt: 1 (beginner → intermediate)
- Time box: 70 minutes
- Unlocked?: **No** — mentor must say "Assessment unlocked"

## Rules

- Work from memory plus your lab box. Concept docs may be used as you would man pages — not as a paste source for essays.
- Practical and troubleshooting are PASS/FAIL gates.
- Paste evidence under Section E (redact usernames if you wish; keep structure).
- Stop at the time box. Unfinished practical = not passed.

Pass bars: MCQ 80% · Short 70% · Long 70% · D/E/F PASS.  
See [`../../system/scoring.md`](../../system/scoring.md).

---

## Section A — MCQ (12)

Choose one answer each.

**A1.** Ubuntu is best described as:

- a) The Linux kernel
- b) A distribution: kernel + userland + defaults
- c) A shell
- d) A filesystem type

**A2.** A process in user space wants to read a file. It must:

- a) Access the disk controller directly
- b) Issue a system call and accept a yes or no
- c) Ask systemd for permission only
- d) Reboot into kernel mode

**A3.** You run `cd /var/log` in `./myscript.sh` and then look at your interactive prompt. It is still `$HOME` because:

- a) `cd` is broken on modern Linux
- b) The script's process `chdir`'d and then exited
- c) `/var/log` is not a real directory
- d) You needed `sudo`

**A4.** After `cd /no/such/dir` fails, cwd is:

- a) `/`
- b) `/no/such/dir` anyway
- c) Unchanged
- d) `$HOME`

**A5.** Which path is absolute?

- a) `var/log`
- b) `./nginx`
- c) `/var/log`
- d) `~/sre-lab`

**A6.** `~` is expanded by:

- a) The kernel, always
- b) The firmware
- c) The shell, before the command runs
- d) `ls` itself

**A7.** `ls -ld /var/log` is the right tool when you want:

- a) Every log file's contents
- b) Metadata of the directory itself
- c) A recursive tree of `/var`
- d) Disk free space

**A8.** `/proc` files are primarily:

- a) Logs that persist on disk
- b) Package manager caches
- c) Kernel state presented as files
- d) User home directories

**A9.** `df -h /` is 40% used. An app cannot write `/var/log/app/app.log`. Which statement is true?

- a) Disk cannot be the problem
- b) `/var` may be a different, full mount
- c) You should immediately `rm -rf /`
- d) Inodes are never relevant

**A10.** `ls` does not show `.env`. The kernel:

- a) Hides all security-sensitive files
- b) Treats dot-prefix names as a *convention* that `ls` follows unless `-a`
- c) Deleted the file
- d) Moved it to `/etc`

**A11.** You need to enter a directory. The permission that matters most on that directory is:

- a) Read (`r`) only
- b) Write (`w`) only
- c) Execute / search (`x`)
- d) The sticky bit

**A12.** A soak test writes 2 GB of debug logs per hour. The first Linux question is:

- a) Which mount will those bytes land on?
- b) Which Kubernetes operator to install?
- c) Whether TCP exists
- d) Whether the kernel version is even

---

## Section B — Short answer (5)

Answer in 3–6 sentences each.

**B1.** Kernel vs user space: who decides `Permission denied`?

**B2.** Terminal vs shell: why does a program behave differently in GitHub Actions than in your SSH window?

**B3.** Why is `cd` a builtin? What would happen if it were `/usr/bin/cd`?

**B4.** Give one reason `/etc` and `/var` are different zones.

**B5.** Performance-testing bridge: translate "the response time graph went vertical and then the app started 500ing" into a Linux-shaped hypothesis involving files.

---

## Section C — Long answer (3)

**C1.** Narrate `cd /var/log` from keystroke to kernel to the next `ls`. Include the failure path if `/var/log` is missing.

**C2.** Draw (ASCII is fine) `/` with at least eight children and one-line purposes. Mark which ones typically grow and which are virtual.

**C3.** A teammate says "the server is Linux so the application cannot be the problem." Write the correction you would send in Slack. Be kind and precise.

---

## Section D — Troubleshooting (PASS/FAIL)

```text
Symptom:
  Application HTTP 503
  df -h /   →  38% used
  top       →  CPU 15%
  The last thing anyone changed was "turn on debug logging"

What do you investigate?
What commands, in what order?
Why that order?
What would you not do first?
How does this connect to a soak test you already understand?
```

A passing answer names **the log mount / inode / permissions / cwd** as possible, not only "restart the app."

---

## Section E — Practical (PASS/FAIL)

On your lab box:

1. Show `uname -a` and `/etc/os-release`.
2. Create `$HOME/sre-lab/week01-exam/{a,b}`.
3. `cd` into `b` via a relative path from `a`. Show `pwd` at each step.
4. Demonstrate a **failed** `cd` and prove cwd did not change (`pwd` before and after, plus `$?`).
5. Show `ls -ld` of `$HOME/sre-lab` and `df -h`.

Paste the commands and outputs.

Fail if: you only describe the steps, or cwd clearly changed after the failed `cd` (that means you `cd`'d somewhere else by accident — say so).

---

## Section F — SRE scenario (PASS/FAIL)

```text
02:00.
Latency 200ms → 5 seconds.
CPU 30%.
Database connections 95%.
You SSH to one app host.
cd /var/log/myapp  →  Permission denied
ls /var/log/myapp  →  Permission denied

What is your hypothesis set?
What do you do in the next five minutes that is mitigation, not archaeology?
What Linux facts do you still need?
What performance-testing instinct applies (pools, waits)?
What will you not do (chmod 777, reboot the database first)?
```

---

## Scoring (mentor)

| Section | Score | Bar | Pass? |
| ------- | ----: | --: | ----- |
| A |  /12 | 80% (10/12) |  |
| B |  | 70% |  |
| C |  | 70% |  |
| D |  | PASS |  |
| E |  | PASS |  |
| F |  | PASS |  |

Final: ⚪ / 🟢 / 🔴  
Attempts: 1  
Weak areas to add:

## Answer key

Not stored in this file. The mentor grades. A retest will not reuse these questions.
