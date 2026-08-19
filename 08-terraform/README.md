# 08 — Terraform

| | |
| --- | --- |
| Phase | 2 Infrastructure |
| Months | 9–10 |
| Status | ⚪ 0% — nothing assessed |
| Start here | `fundamentals/README.md` |

## Why this module exists

Clickops does not survive a second environment or a 03:00 recreate.

## Prerequisites

You have built the same AWS resources at least once without Terraform.

If they are not 🟢, stop. See [`../roadmap/prerequisites.md`](../roadmap/prerequisites.md).

## Performance-testing bridge

Treat `plan` like a test report: a prediction of change. `apply` is the deploy. State is the baseline.

1. Here is what you already know from performance testing.
2. Here is the SRE equivalent.
3. Here is what you need to learn next.

## You will be able to

- Explain state and why it is secret
- Read a plan and refuse a surprise destroy
- Module an environment
- Destroy and recreate the lab from code

## How completion works

Reading this README does nothing to progress.

1. Study concept docs (25-section template).
2. Do labs. Log evidence.
3. Hear **Assessment unlocked**.
4. Pass theory bars **and** practical/troubleshooting.
5. Then the module may move 🟡 → 🟢.

Rules: [`../system/completion-rules.md`](../system/completion-rules.md)

## Project

Portfolio v4.

Scored with [`../system/project-scoring.md`](../system/project-scoring.md).

## Concept list

See rows for `08-terraform` in [`../progress/concept-tracker.md`](../progress/concept-tracker.md).

## Mentor note

Depth over breadth. If you ask for a command cheat-sheet, you will get a failure scenario instead.
