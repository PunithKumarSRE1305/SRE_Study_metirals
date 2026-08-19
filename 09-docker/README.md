# 09 — Docker

| | |
| --- | --- |
| Phase | 3 Containers |
| Months | 12–13 |
| Status | ⚪ 0% — nothing assessed |
| Start here | `fundamentals/README.md` |

## Why this module exists

Kubernetes schedules containers. If a container is a black box, K8s is a darker one.

## Prerequisites

Linux processes, filesystems, networking. Namespaces will be taught, not assumed.

If they are not 🟢, stop. See [`../roadmap/prerequisites.md`](../roadmap/prerequisites.md).

## Performance-testing bridge

A container with no resource limits is an unscoped soak test waiting to happen.

1. Here is what you already know from performance testing.
2. Here is the SRE equivalent.
3. Here is what you need to learn next.

## You will be able to

- Explain a container from Linux primitives
- Write a Dockerfile you can defend (non-root, pinned base)
- Debug PID 1 and a crashing image
- Describe container DNS and published ports

## How completion works

Reading this README does nothing to progress.

1. Study concept docs (25-section template).
2. Do labs. Log evidence.
3. Hear **Assessment unlocked**.
4. Pass theory bars **and** practical/troubleshooting.
5. Then the module may move 🟡 → 🟢.

Rules: [`../system/completion-rules.md`](../system/completion-rules.md)

## Project

Portfolio v2 — containerize the app.

Scored with [`../system/project-scoring.md`](../system/project-scoring.md).

## Concept list

See rows for `09-docker` in [`../progress/concept-tracker.md`](../progress/concept-tracker.md).

## Mentor note

Depth over breadth. If you ask for a command cheat-sheet, you will get a failure scenario instead.
