# My background — the honest starting point

This file is the baseline. The mentor must not "round up" these skills.

## Professional

| Item | Reality |
| ---- | ------- |
| Experience | ~4 years |
| Current role | Performance Tester |
| Workday | ~10 hours |
| Study budget | ~2 hours/day, 10–14 hours/week |
| Target | Production-capable SRE in 2.6 years (31 months) |

## What is actually strong

- Performance testing thinking: load, stress, soak, capacity, baselines
- JMeter: requests, response time, throughput, concurrent users
- The instinct to ask "where is the bottleneck?"
- Familiarity with resource utilization as a *symptom*

## What has been touched, but is not operational

| Tool | Honest level | What that means |
| ---- | ------------ | --------------- |
| AWS | Some exposure, limited practical | You have seen the console. You cannot yet design, secure, or debug an account. |
| Splunk | Some exposure, limited practical | You have searched logs. You cannot yet design indexes, detections, or incident workflows. |
| AppDynamics | Some exposure, limited practical | You have seen APM graphs. You cannot yet reason about agents, business transactions, and SRE SLIs. |

## What is limited

- Linux
- Networking
- Docker / Kubernetes
- Terraform
- SRE practice (SLI/SLO, error budgets, on-call, postmortems)

Limited does **not** mean incapable. It means we start from first principles and do not skip the unglamorous parts.

## What we will never do with this background

- Pretend 4 years of performance testing equals 4 years of SRE
- Skip Linux because "I can use a terminal a bit"
- Jump to Kubernetes in month 2
- Treat JMeter as a substitute for production observability
- Build an 8-hour-a-day curriculum for a 10-hour workday

## What we will do with this background

Use performance testing as a **bridge**, not a bypass.

```text
You already measure                     SRE needs you to also own
-------------------------               -------------------------------
Response time                           Latency SLI + SLO + error budget
Throughput                              Capacity + saturation
Concurrent users                        Load-bearing architecture
Bottleneck                              Incident hypothesis
Baseline                                Normal vs abnormal
Soak test                               Memory leak / degradation over time
Stress test                             Failure point / blast radius
A report for stakeholders               A mitigation at 02:00
```

## Starting maturity

| Dimension | Level now | Evidence |
| --------- | --------- | -------- |
| Linux | 0 — Beginner | Limited knowledge, not assessed |
| Networking | 0 — Beginner | Limited knowledge, not assessed |
| Cloud | 0–1 | Exposure only |
| Containers | 0 — Beginner | Limited knowledge, not assessed |
| Observability | 1 on APM/logs tools, 0 on SRE use | Tool exposure, not production ownership |
| SRE | 0 — Beginner | No formal SRE practice |
| Performance engineering | 2 — Practitioner (testing) | Strong PT; production perf engineering not yet |

Overall SRE maturity: **Level 0, entering Level 1**.

Target after 31 months: **Level 4**, stretching into Level 5 on reliability reasoning.
