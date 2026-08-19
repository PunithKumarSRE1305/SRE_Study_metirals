# From performance testing to SRE

This is your leverage file. When a new concept appears, come back here and find the row that matches.

## The one-sentence translation

Performance testing asks: **"What happens if we push it?"**  
SRE asks: **"What have we promised, are we keeping it, and what do we do when we are not?"**

Same physics. Different ownership.

## Concept bridge

| You already know (PT / JMeter) | SRE name | What you must still learn |
| ----------------------------- | -------- | ------------------------- |
| Response time | Latency (often an SLI) | Percentiles (p50/p95/p99), not only average; user-visible latency vs backend time |
| Error % in a test | Availability / error SLI | Error budget math, burn rate, "is this a release blocker?" |
| Throughput (req/s) | Demand + capacity | Whether the *system* can take that rate at 02:00 next Black Friday |
| Concurrent users / threads | Concurrency, saturation | Thread pools, connection pools, queue depth |
| Resource utilization | Saturation (USE method) | Utilization without saturation is a lie; queueing theory intuition |
| Bottleneck | Constraint | Which layer, which dependency, which blast radius |
| Baseline | SLI history / "normal" | Alerting on deviation, not on pretty graphs |
| Load test | Reliability / capacity experiment | Testing in prod-like env, plus production guardrails |
| Stress test | Finding the breaking point | Failure modes, graceful degradation, load shedding |
| Soak test | Endurance / leak detection | SLOs over weeks, not a 2-hour script |
| Capacity report | Capacity plan | Leading indicators, headroom, cost |
| Listener / backend listener | Telemetry pipeline | Metrics vs logs vs traces |
| Assertion | SLI measurement + alert | Pages a human, not a red cell in a report |
| Ramp-up | Traffic shape | User journeys, retries, thundering herds |
| Think time | Realism of load | Why synthetic load lies |
| Distributed JMeter | Generating load | That is not the same as running a distributed *system* |
| AppDynamics transaction | RED method (Rate, Errors, Duration) | How to build the same view in Prometheus + traces |
| Splunk search after a test | Incident investigation | Structured logging, correlation IDs, time-bounded queries |

## Three sentences the mentor will keep using

1. **Here is what you already know from performance testing.**
2. **Here is the SRE equivalent.**
3. **Here is what you need to learn next.**

If a lesson does not do this when it reasonably can, the lesson is incomplete.

## A picture you already have

```text
JMeter
  │  generate load
  v
Service under test  ──► response time, errors, throughput
  │
  ├── CPU / mem / disk / GC     (you already glance at these)
  ├── AppDynamics business txn  (you have seen this)
  └── Splunk / logs             (you have searched this)

SRE adds the missing box:

  SLO: 99.9% of checkout requests < 300ms
           │
           v
  Error budget: 43 minutes of burn / month
           │
           ├── budget healthy  → ship features
           └── budget burning  → freeze, fix, page, postmortem
```

## What PT will *not* automatically give you

- Linux internals when the box is sick
- Packet-level networking
- IAM and blast radius in AWS
- What Kubernetes does when a node vanishes
- How to write a blameless postmortem
- How to design a retry so it does not DDoS yourself
- How to say "this release is not allowed" with an error budget

Those are why the other 30 months exist.

## How we will use JMeter, Splunk, AppDynamics on purpose

| When | Use |
| ---- | --- |
| After Linux + a simple app (Month 6) | JMeter against *your* app, not a vendor demo |
| Observability phase | Splunk as the log backend you already recognize |
| Observability phase | AppDynamics next to Prometheus, so you see overlap and gaps |
| Performance engineering phase (Month 28) | You design the test *and* the production defense |

You are not abandoning your craft. You are promoting it from "report the limit" to "own the limit."
