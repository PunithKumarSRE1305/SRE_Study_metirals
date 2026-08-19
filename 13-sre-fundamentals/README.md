# 13 — SRE fundamentals

| | |
| --- | --- |
| Phase | 7 SRE |
| Months | 22–24 (language seeded from Month 1) |
| Status | ⚪ 0% — nothing assessed |
| Start here | `sli-slo-sla/README.md` when Phase 6 is far enough |

## Why this module exists

This is the job. Tools were the substrate.

SRE is software engineering applied to operations, with a **user promise** (SLO) and a **budget for failure**.

## Prerequisites

Observability on *your* service. You cannot SLO a hypothetical.

## Performance-testing bridge

| PT | SRE |
| -- | --- |
| Pass/fail vs a threshold | SLO |
| Error % in a test | Availability / error SLI |
| "Stop the release, the soak failed" | Error-budget freeze |
| Baseline | SLI history |
| Report for stakeholders | Policy for product + eng |

1. You already know pass/fail against a number.
2. The SRE equivalent is a promise that *continues* in production, with a budget.
3. Next: pick SLIs that are user-shaped, not CPU-shaped, and defend a freeze.

## You will be able to

- Write SLIs that are user-shaped
- Set an SLO and compute a budget
- Use burn rate to decide freeze vs ship
- Name toil and automate one piece
- Describe service ownership without theatre

## How completion works

Phase 7 gate: SLOs + error-budget policy for the portfolio, assessed.

## Mentor note

We will not begin this module in Week 1. We *will* use the words in scenarios so they are not foreign in Month 24.
