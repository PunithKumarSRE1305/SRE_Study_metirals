# Week 04 — Processes + Month 1 gate

**Status:** ⚪ outline only. Opens after Week 03 🟢.

## Objective

Explain what a process is. Read `ps` and `top` columns. Send SIGTERM before SIGKILL. Pass the Month 1 assessment.

## Planned days

| Day | Mode | Topics |
| --- | ---- | ------ |
| 1 | Theory | Process, pid, ppid, pid 1, fork/exec |
| 2 | Examples | `ps aux`, `top`, what each column actually is |
| 3 | Hands-on | Start a long `sleep`, find it, `kill` it politely |
| 4 | Troubleshooting | "CPU is 100%" — which pid, which syscall/state |
| 5 | Advanced | Signals: TERM vs KILL vs HUP; why `D` state ignores `-9` |
| 6 | Project | One-page "how I inspect a sick box after 4 weeks" |
| 7 | Month 1 assessment | Covers W01–W04 |

## PT bridge

The pid eating CPU during your stress test is the first process you will learn to love. `top` is the un-pretty cousin of the APM CPU graph.
