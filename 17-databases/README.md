# 17 — Databases (SRE view)

| | |
| --- | --- |
| Phase | 9 Distributed |
| Months | 27 |
| Status | ⚪ 0% — nothing assessed |
| Start here | `fundamentals/README.md` |

## Why this module exists

You will page on connections, disks, failovers, and migrations — not on writing a query planner.

## Prerequisites

Linux I/O, networking, the portfolio talking to a datastore (even SQLite then Postgres).

If they are not 🟢, stop. See [`../roadmap/prerequisites.md`](../roadmap/prerequisites.md).

## Performance-testing bridge

Connection pool at 95% + latency 5s + CPU 30% is a scenario you will meet in Month 1 *stories* and Month 27 *labs*. You already suspect the pool.

1. Here is what you already know from performance testing.
2. Here is the SRE equivalent.
3. Here is what you need to learn next.

## You will be able to

- Diagnose pool exhaustion
- Explain backup vs restore evidence
- Tell slow query from retry amplification

## How completion works

Reading this README does nothing to progress.

1. Study concept docs (25-section template).
2. Do labs. Log evidence.
3. Hear **Assessment unlocked**.
4. Pass theory bars **and** practical/troubleshooting.
5. Then the module may move 🟡 → 🟢.

Rules: [`../system/completion-rules.md`](../system/completion-rules.md)

## Project

Break the pool on purpose; write the postmortem.

Scored with [`../system/project-scoring.md`](../system/project-scoring.md).

## Concept list

See rows for `17-databases` in [`../progress/concept-tracker.md`](../progress/concept-tracker.md).

## Mentor note

Depth over breadth. If you ask for a command cheat-sheet, you will get a failure scenario instead.
