# 25 — Multi-region

| | |
| --- | --- |
| Phase | 10 Advanced |
| Months | 30 |
| Status | ⚪ 0% — nothing assessed |
| Start here | `fundamentals/README.md` |

## Why this module exists

Multi-region is a data problem wearing a DNS costume.

## Prerequisites

Single-region HA + DNS + data replication ideas.

If they are not 🟢, stop. See [`../roadmap/prerequisites.md`](../roadmap/prerequisites.md).

## Performance-testing bridge

Active-active doubles more than capacity — it doubles failure modes. Your soak must include *both* sides.

1. Here is what you already know from performance testing.
2. Here is the SRE equivalent.
3. Here is what you need to learn next.

## You will be able to

- Draw failure domains
- Say what you refuse to replicate
- Explain DNS failover lies (TTL, client cache)

## How completion works

Reading this README does nothing to progress.

1. Study concept docs (25-section template).
2. Do labs. Log evidence.
3. Hear **Assessment unlocked**.
4. Pass theory bars **and** practical/troubleshooting.
5. Then the module may move 🟡 → 🟢.

Rules: [`../system/completion-rules.md`](../system/completion-rules.md)

## Project

Portfolio v13 design (implement as far as budget allows).

Scored with [`../system/project-scoring.md`](../system/project-scoring.md).

## Concept list

See rows for `25-multi-region` in [`../progress/concept-tracker.md`](../progress/concept-tracker.md).

## Mentor note

Depth over breadth. If you ask for a command cheat-sheet, you will get a failure scenario instead.
