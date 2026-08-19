# 12 — Observability

| | |
| --- | --- |
| Phase | 6 Observability |
| Months | 21–23 |
| Status | ⚪ 0% — nothing assessed |
| Start here | `metrics/README.md` — **not this month** |

## Why this module exists

You cannot keep a promise you cannot measure. Pretty dashboards are not a personality.

## Prerequisites

A service you own (portfolio v1+). Linux + networking. Docker/K8s enough to run the app you will watch.

If they are not 🟢, stop.

## Performance-testing bridge

You already generate load (JMeter) and have *seen* two vendor lenses:

| You know | SRE-native cousin | Job |
| -------- | ----------------- | --- |
| JMeter listeners | Synthetic SLI / blackbox | Demand + external truth |
| AppDynamics | RED + traces (OTel) | The journey inside the process |
| Splunk | Structured logs + events | Narrative, forensics |
| (new) Prometheus / Grafana | Metrics + cheap questions | Always-on, alertable |
| (new) OpenTelemetry | Context across hops | Glue |

1. Here is what you already know from performance testing.
2. Here is the SRE equivalent.
3. Here is what you need to learn next — **cardinality, alert fatigue, SLI design, and owning the pipeline**.

## You will be able to

- Instrument golden signals
- Write PromQL that answers one question
- Investigate in Splunk with a time-bounded story
- Follow one request across a trace
- Compare AppD and OTel without religion
- Delete a noisy alert on purpose

## Order inside the module

```text
metrics (ideas) → Prometheus → Grafana
    → logs → Splunk
    → alerting
    → traces → OpenTelemetry → AppDynamics comparison
```

## How completion works

Reading this README does nothing. Labs + **Assessment unlocked** + practical PASS.

## Project

Portfolio v7–v9.

## Mentor note

We will not install every observability vendor. Primary path: Prometheus, Grafana, OTel, Splunk, AppDynamics. Datadog/New Relic are mentioned so you can recognize them.
