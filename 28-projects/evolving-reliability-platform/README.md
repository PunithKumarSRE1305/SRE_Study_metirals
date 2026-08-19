# Evolving reliability platform

One application. Many skins. The point is **the trail of reliability decisions**, not a new demo every month.

Working name: **Relay** — a small HTTP service that accepts a request, does a little work (CPU, I/O, or a dependency), and answers. You will load-test it with JMeter from v1. You will page off it from v7.

## Why this shape

You already know how to punish a system. This project exists so you have a system that is yours to punish, repair, and explain.

```text
v1  Single process, logs, health
      ↓
v2  Docker
      ↓
v3  AWS (VM + LB)
      ↓
v4  Terraform
      ↓
v5  Kubernetes / EKS
      ↓
v6  CI/CD + rollback
      ↓
v7  Metrics (Prom / Grafana)
      ↓
v8  Logs (structured + Splunk-shaped)
      ↓
v9  Traces (OTel; AppD compared)
      ↓
v10 High availability
      ↓
v11 Disaster recovery
      ↓
v12 Chaos
      ↓
v13 Multi-region (design + as much as budget allows)
```

## Unlock table

| Version | Unlocks | Status | Score |
| ------- | ------- | ------ | ----: |
| v1 | Month 6 | ⚪ locked | — |
| v2 | Month 12–13 | ⚪ | — |
| v3 | Month 8 | ⚪ | — |
| v4 | Month 10 | ⚪ | — |
| v5 | Month 18 | ⚪ | — |
| v6 | Month 20 | ⚪ | — |
| v7 | Month 21 | ⚪ | — |
| v8 | Month 22 | ⚪ | — |
| v9 | Month 23 | ⚪ | — |
| v10 | Month 29 | ⚪ | — |
| v11 | Month 29 | ⚪ | — |
| v12 | Month 29 | ⚪ | — |
| v13 | Month 30 | ⚪ | — |

v2 may be built in a branch before v3/v4 land on the main story; merge when both exist. The table is not a git-history religion.

## Standing requirements (every version)

- You can start it from the README in 15 minutes
- You can break it on purpose
- You can show one recovery
- No secrets in git
- A short `DESIGN.md`: what can fail, what you accepted

## Version briefs

Detailed acceptance criteria are written when the version unlocks. Until then, this is the contract:

### v1 — Single application

A process, a health endpoint, structured-enough logs, a JMeter test plan that you run. Observability/security judged lightly.

### v2 — Docker

Pinned base image, non-root user, signals reach PID 1, logs to stdout.

### v3 — AWS

VPC picture, instance or equivalent, load balancer health check that matches reality.

### v4 — Terraform

`plan` reviewed, remote state, destroy/recreate once.

### v5 — Kubernetes

Deployment, Service, probes, resources, a documented rollback.

### v6 — CI/CD

Build once. Deploy. Bad artifact. Rollback under 15 minutes. Evidence recorded.

### v7 — Metrics

Golden signals on Grafana. One alert that is *symptom*-based.

### v8 — Logging

Correlation id. A Splunk (or compatible) investigation you can replay.

### v9 — Tracing

One request visible across hops. Written comparison: AppDynamics vs OTel for *this* app.

### v10 — HA

Two instances / two AZs as the design requires. Kill one. Users survive or you explain the SLO burn.

### v11 — DR

Restore from backup. RPO/RTO written *before* the game day.

### v12 — Chaos

Hypothesis, steady-state SLI, abort condition, postmortem, one prevention item.

### v13 — Multi-region

A design that says what you will **not** replicate. Implementation as far as money and time allow; a paper design can pass if it is honest about what was not built.

## Scoring

[`../../system/project-scoring.md`](../../system/project-scoring.md)

## What this is not

- A rewrite in a new language every quarter
- A microservices fashion show in Month 6
- A Kubernetes cluster on Day 1
