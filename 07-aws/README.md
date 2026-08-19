# 07 — AWS

| | |
| --- | --- |
| Phase | 2 Infrastructure |
| Months | 7–8 (security revisit in 11) |
| Status | ⚪ 0% — nothing assessed |
| Start here | `fundamentals/README.md` |

## Why this module exists

This is the primary cloud. Depth beats a multi-cloud tour.

## Prerequisites

Linux, IPv4/routing/DNS, SSH. Terraform comes *after* you can click/CLI the same resources once.

If they are not 🟢, stop. See [`../roadmap/prerequisites.md`](../roadmap/prerequisites.md).

## Performance-testing bridge

An ALB 5xx during a test is a *layer*. CloudWatch is not AppDynamics. We will map what each can and cannot see.

1. Here is what you already know from performance testing.
2. Here is the SRE equivalent.
3. Here is what you need to learn next.

## You will be able to

- Draw a VPC with public/private subnets and say why
- Launch EC2 you can lock down and reach via bastion/SSM idea
- Read an IAM deny and fix the *smallest* statement
- Put the app behind an ALB with a real health check
- Set one alarm that would page a human for a user symptom

## How completion works

Reading this README does nothing to progress.

1. Study concept docs (25-section template).
2. Do labs. Log evidence.
3. Hear **Assessment unlocked**.
4. Pass theory bars **and** practical/troubleshooting.
5. Then the module may move 🟡 → 🟢.

Rules: [`../system/completion-rules.md`](../system/completion-rules.md)

## Project

Portfolio v3 — the app on AWS.

Scored with [`../system/project-scoring.md`](../system/project-scoring.md).

## Concept list

See rows for `07-aws` in [`../progress/concept-tracker.md`](../progress/concept-tracker.md).

## Mentor note

Depth over breadth. If you ask for a command cheat-sheet, you will get a failure scenario instead.
