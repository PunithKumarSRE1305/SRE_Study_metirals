# 02 — Networking

| | |
| --- | --- |
| Phase | 1 Foundation |
| Months | 3–4 |
| Status | ⚪ 0% — nothing assessed |
| Start here | `fundamentals/README.md` |

## Why this module exists

JMeter 'connection refused' and K8s 'no endpoints' are the same class of problem at different altitudes. You need the packet-shaped middle.

## Prerequisites

Linux processes, files, permissions. You must have used `ss`/`ip` at least as a reader.

If they are not 🟢, stop. See [`../roadmap/prerequisites.md`](../roadmap/prerequisites.md).

## Performance-testing bridge

A 1% error rate in JMeter is a *symptom*. Networking tells you whether it is DNS, handshake, TLS, reset, or the app. Averages of response time hide retransmits.

1. Here is what you already know from performance testing.
2. Here is the SRE equivalent.
3. Here is what you need to learn next.

## You will be able to

- Draw encapsulation (HTTP → TCP → IP → Ethernet) from memory
- Subnet a /24 and explain a route table entry
- Diagnose DNS vs TCP vs TLS vs HTTP with evidence
- Read `ss -lptn` and say who is listening
- Explain L4 vs L7 load balancing and health checks

## How completion works

Reading this README does nothing to progress.

1. Study concept docs (25-section template).
2. Do labs. Log evidence.
3. Hear **Assessment unlocked**.
4. Pass theory bars **and** practical/troubleshooting.
5. Then the module may move 🟡 → 🟢.

Rules: [`../system/completion-rules.md`](../system/completion-rules.md)

## Project

Trace a request from `curl` to a packet story; break DNS in a lab and write the timeline.

Scored with [`../system/project-scoring.md`](../system/project-scoring.md).

## Concept list

See rows for `02-networking` in [`../progress/concept-tracker.md`](../progress/concept-tracker.md).

## Mentor note

Depth over breadth. If you ask for a command cheat-sheet, you will get a failure scenario instead.
