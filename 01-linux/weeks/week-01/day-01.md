# Week 01, Day 1 — What is Linux, and why are you here?

- Phase: 1 Foundation
- Module: 01-linux
- Time box: **120 minutes**
- Status source: `progress/CURRENT.md`

## Objective

Leave tonight able to explain, in your own words:

1. What an operating system is for
2. What "Linux" refers to (kernel vs distro vs GNU userland)
3. The difference between kernel, user space, terminal, and shell
4. Why an SRE who skips this will fail later in a way JMeter cannot save

## Prerequisites

- Orientation skimmed (`00-orientation/`)
- A Linux shell you can type into for 40 minutes

## Time plan

```text
Orientation leftover     10 min
Theory                   30 min
Concept docs             20 min
Hands-on                 40 min
Challenge                10 min
Revision                 10 min
──────────────────────────────
Total                   120 min
```

If orientation already happened, give those 10 minutes to the lab.

---

## Theory (30 min)

Read this slowly. Do not skim to the commands.

### The problem a computer has

Hardware is dumb and parallel and rude:

```text
CPU  —  can execute instructions, does not know your app
RAM  —  forgets when power dies
Disk —  remembers, but slowly and in blocks
NIC  —  shouts packets at the world
```

Many programs want these at once. They will collide. The **operating system** is the adult in the room: it multiplexes hardware, isolates programs, and offers a usable interface.

### What people mean by "Linux"

People mix three things:

```text
┌─────────────────────────────────────────────┐
│  Ubuntu / Amazon Linux / RHEL  (a distro)   │
│  ┌───────────────────────────────────────┐  │
│  │  GNU userland: bash, ls, coreutils    │  │
│  │  systemd, apt/yum, default configs    │  │
│  │  ┌─────────────────────────────────┐  │  │
│  │  │  Linux kernel                   │  │  │
│  │  │  talks to hardware,             │  │  │
│  │  │  schedules processes,           │  │  │
│  │  │  enforces permissions           │  │  │
│  │  └─────────────────────────────────┘  │  │
│  └───────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
```

- **Kernel** — the program that always runs, in privileged mode.
- **Userland** — everything else (`ls`, nginx, your JMeter engine if you installed it here).
- **Distribution** — kernel + userland + opinions (Ubuntu vs Amazon Linux).

Saying "I know Linux" because you used Ubuntu's desktop is like saying "I know engines" because you drove a car. We are going under the bonnet.

### Kernel vs user space (the SRE version)

```text
   your command:  ls /var/log
           │
           v
   bash (user space)  — parses text, decides to execute /usr/bin/ls
           │
           │  system call: openat("/var/log"), getdents()
           v
   Linux kernel       — checks permissions, reads filesystem, returns data
           │
           v
   hardware / disk
```

You cannot `ls` the disk yourself. You *ask* the kernel. The kernel may say no. That "no" is a permission, a missing file, or a dying disk. SRE work is often **reading the no**.

### Terminal vs shell

- **Terminal** — the window / SSH session / tty. A device that takes keystrokes and shows characters.
- **Shell** — the program (`bash`, `zsh`) that interprets what you typed.

You can change shells. You cannot skip the kernel.

### Performance-testing bridge

1. **What you already know.** During a test you watch CPU, memory, disk, network on a graph. You already believe resources are finite and contention is real.
2. **SRE equivalent.** Those graphs are *aggregates of kernel counters*. Load average, iowait, page faults — they come from the same machine you will now log into.
3. **What to learn next.** How a process is born, how a file is found, how "permission denied" is decided. Without that, a red CPU graph is a mood, not a diagnosis.

---

## Visual first (optional 10 min, taken from theory if needed)

Open [`visuals/02-kernel-vs-user-space.md`](visuals/02-kernel-vs-user-space.md) and narrate the picture out loud. Then [`visuals/01-what-is-linux.md`](visuals/01-what-is-linux.md).

Free video cap today: 20 minutes from [`resources.md`](resources.md). Terminal open. Pause often.

## Concept docs (20 min)

Read for understanding, not highlighting:

1. [`../../fundamentals/what-is-linux.md`](../../fundamentals/what-is-linux.md)
2. [`../../fundamentals/kernel-vs-user-space.md`](../../fundamentals/kernel-vs-user-space.md)
3. [`../../fundamentals/why-sre-needs-linux.md`](../../fundamentals/why-sre-needs-linux.md)

If time remains, start [`../../fundamentals/shell-vs-terminal.md`](../../fundamentals/shell-vs-terminal.md). Finish it tomorrow if needed.

---

## Hands-on (40 min)

Open a Linux shell. Type these yourself. After each, write one line: *what I think just happened*.

```bash
whoami
id
hostname
uname -a
cat /etc/os-release
pwd
echo "$SHELL"
ps -p $$
ls /
ls /var
```

Then:

```bash
ls /this/does/not/exist
echo $?
```

`$?` is the exit code of the last command. Non-zero means failure. You will live in exit codes.

**Evidence to paste** into `progress/daily-logs/YYYY-MM-DD.md`:

- output of `uname -a` and `cat /etc/os-release`
- output of `ls /`
- the error from the missing path and the `$?` value

Do not screenshot your entire desktop. Text is enough.

---

## Challenge (10 min) — no answer here

A teammate says:

> "The server is Linux, so the application cannot be the problem. Linux is stable."

Write 5–8 sentences. Use kernel vs user space. Name one thing that can be broken while the kernel is fine.

Put the answer in today's daily log. Do not look for an official answer until Day 7.

---

## Revision (10 min, from memory)

Close the docs. Write:

1. Kernel vs user space in two sentences
2. Distro vs kernel in one sentence
3. Terminal vs shell in one sentence
4. Why `ls` must ask the kernel
5. One reason an SRE lives in a shell during an incident

Then reopen the docs and correct yourself in a different color / a "corrections" heading.

---

## Log

- Minutes actually spent
- Distro you used
- What you still cannot explain
- Challenge answer

**Do not mark any concept 🟢.**
