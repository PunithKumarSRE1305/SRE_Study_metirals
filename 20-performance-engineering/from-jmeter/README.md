# From JMeter to production performance engineering

This folder is your home-turf upgrade. It opens for real in **Month 28**, and is *referenced* from Month 6 (first time you JMeter *your* app) and Month 21 (SLIs).

## The promotion

| Performance tester | Performance engineer / SRE |
| ------------------ | -------------------------- |
| Report the limit | Own the limit |
| A 2-hour script | A week-long soak + a production defense |
| Average response time | Histograms, p95/p99, SLO |
| "Add more threads" | Timeouts, retries with jitter, shedding, capacity |
| A PDF | A change to code, config, or quota |

## What you already know (do not relearn from zero)

- Thread groups, ramp-up, assertions
- Load vs stress vs soak
- Throughput vs response time curves
- Bottleneck hunting as a habit

## What you must still learn

- Gating a suite on the **SLO**, not on "looks okay"
- Coordinating with production telemetry (Prom / traces / Splunk)
- Retry storms you *cause*
- Testing load-shedding on purpose
- Saying "we will not ship" with an error budget

## Status

⚪ No document in this folder is complete coursework yet. Month 6 will add a "first honest JMeter against v1" lab. Month 28 writes the deep docs.
