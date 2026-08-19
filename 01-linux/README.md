# 01 — Linux

| | |
| --- | --- |
| Phase | 1 Foundation |
| Months | 1–3 (then revisited forever) |
| Status | ⚪ 0% — nothing assessed |
| Start here | `weeks/week-01/day-01.md` |

## Why this module exists

Every production mystery eventually becomes a process, a file, a socket, or a permission. If you cannot see those, Kubernetes will look like magic and then like a wall.

## Prerequisites

Orientation. A Linux environment (VM, WSL2, or cloud instance). Not a week of YouTube.

If they are not 🟢, stop. See [`../roadmap/prerequisites.md`](../roadmap/prerequisites.md).

## Performance-testing bridge

You already watch CPU, memory, and disk *from the outside* during a test. Linux is how those graphs are born. `iowait` during a soak is not 'the server is tired' — it is a queue you can name.

1. Here is what you already know from performance testing.
2. Here is the SRE equivalent.
3. Here is what you need to learn next.

## You will be able to

- Explain kernel vs user space vs shell without slogans
- Navigate the FHS and predict where logs, configs, and sockets live
- Read a permission string and predict whether a process can write a file
- Identify a runaway process and choose SIGTERM vs SIGKILL
- Tell disk-full from inode-full from permission-denied
- Read systemd/journal output and restart a unit safely
- SSH with keys and not lock yourself out of a lab
- Apply a troubleshooting method instead of random commands

## How completion works

Reading this README does nothing to progress.

1. Study concept docs (25-section template).
2. Do labs. Log evidence.
3. Hear **Assessment unlocked**.
4. Pass theory bars **and** practical/troubleshooting.
5. Then the module may move 🟡 → 🟢.

Rules: [`../system/completion-rules.md`](../system/completion-rules.md)

## Project

Map a real Linux system; later, a small service unit + log rotation.

Scored with [`../system/project-scoring.md`](../system/project-scoring.md).

## Concept list

See rows for `01-linux` in [`../progress/concept-tracker.md`](../progress/concept-tracker.md).

## Mentor note

Depth over breadth. If you ask for a command cheat-sheet, you will get a failure scenario instead.
