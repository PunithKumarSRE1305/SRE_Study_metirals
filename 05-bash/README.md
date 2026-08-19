# 05 — Bash

| | |
| --- | --- |
| Phase | 1 Foundation |
| Months | 3 (essentials) and 5 (scripting) |
| Status | ⚪ 0% — nothing assessed |
| Start here | `fundamentals/README.md` |

## Why this module exists

The first thing you type in an incident is a shell. Unsafe scripts are how people `rm` production.

## Prerequisites

Linux navigation, permissions, processes.

If they are not 🟢, stop. See [`../roadmap/prerequisites.md`](../roadmap/prerequisites.md).

## Performance-testing bridge

A 'wrapper script' around a test run is already SRE-adjacent. We make it safe: `set -euo pipefail`, quoting, logs.

1. Here is what you already know from performance testing.
2. Here is the SRE equivalent.
3. Here is what you need to learn next.

## You will be able to

- Quote correctly; explain word splitting
- Write a script with safe defaults
- Use grep/awk/sed for *one* job each, not as a personality
- Schedule a job you would trust

## How completion works

Reading this README does nothing to progress.

1. Study concept docs (25-section template).
2. Do labs. Log evidence.
3. Hear **Assessment unlocked**.
4. Pass theory bars **and** practical/troubleshooting.
5. Then the module may move 🟡 → 🟢.

Rules: [`../system/completion-rules.md`](../system/completion-rules.md)

## Project

A disk-watch or log-rotate helper with tests you can run.

Scored with [`../system/project-scoring.md`](../system/project-scoring.md).

## Concept list

See rows for `05-bash` in [`../progress/concept-tracker.md`](../progress/concept-tracker.md).

## Mentor note

Depth over breadth. If you ask for a command cheat-sheet, you will get a failure scenario instead.
