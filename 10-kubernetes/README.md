# 10 — Kubernetes

| | |
| --- | --- |
| Phase | 4 Kubernetes |
| Months | 14–18 |
| Status | ⚪ 0% — nothing assessed |
| Start here | `architecture/README.md` |

## Why this module exists

Not '100 kubectl commands.' What happens when a Pod starts, dies, or a node vanishes.

## Prerequisites

Docker + Linux + networking. AWS before EKS.

If they are not 🟢, stop. See [`../roadmap/prerequisites.md`](../roadmap/prerequisites.md).

## Performance-testing bridge

HPA on CPU is the cousin of a bad load-test hypothesis: you scaled the wrong signal. Probes are health assertions in production.

1. Here is what you already know from performance testing.
2. Here is the SRE equivalent.
3. Here is what you need to learn next.

## You will be able to

- Draw the control plane and a data-path to a Pod
- Roll out and roll back a Deployment
- Debug CrashLoopBackOff, ImagePull, Pending, NotReady
- Explain Service + DNS + Ingress with packets in mind
- Apply least-privilege RBAC and feel a deny
- Run the portfolio on EKS (or equivalent documented lab)

## How completion works

Reading this README does nothing to progress.

1. Study concept docs (25-section template).
2. Do labs. Log evidence.
3. Hear **Assessment unlocked**.
4. Pass theory bars **and** practical/troubleshooting.
5. Then the module may move 🟡 → 🟢.

Rules: [`../system/completion-rules.md`](../system/completion-rules.md)

## Project

Portfolio v5.

Scored with [`../system/project-scoring.md`](../system/project-scoring.md).

## Concept list

See rows for `10-kubernetes` in [`../progress/concept-tracker.md`](../progress/concept-tracker.md).

## Mentor note

Depth over breadth. If you ask for a command cheat-sheet, you will get a failure scenario instead.
