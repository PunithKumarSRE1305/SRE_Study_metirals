# Learning strategy

## Constraint we design around

You work ~10 hours/day. You can give SRE **~2 hours/day**, **~10–14 hours/week**.

That is enough. It is not enough to study like a full-time bootcamp. Any plan that needs 6–8 hours/day will fail, and then you will feel behind. We will not write that plan.

```text
A sustainable week

Mon–Fri   90–120 min each evening
Sat       120 min project / lab
Sun       60–90 min revision  OR  assessment if unlocked
Buffer    1 evening is allowed to disappear
```

Missed days are rescheduled. They are not moral failures.

## Depth over breadth

We do not teach "here are 100 commands."

We teach:

- What problem exists?
- Why was this invented?
- What happens internally?
- What happens when it fails?
- How would I see that in production?
- What is the SRE decision?

If you catch yourself memorizing a flag, stop and write the failure it exists to diagnose.

## The 120-minute day

Default shape (adjust per topic):

```text
20–30 min   Concept (first principles)
20 min      Documentation / concept doc
40–50 min   Hands-on lab
15–20 min   Challenge (answer not given up front)
10 min      Revision from memory
```

If a topic needs more than 120 minutes, it is split across days. The mentor must split it. You must refuse to "just finish it tonight."

## The week

| Day | Mode | Purpose |
| --- | ---- | ------- |
| 1 | Theory | Mental model |
| 2 | Theory + examples | Make the model concrete |
| 3 | Hands-on | Hands remember |
| 4 | Troubleshooting | The SRE motion |
| 5 | Advanced | Internals / edge cases |
| 6 | Project | Something that exists tomorrow |
| 7 | Revision + assessment | Proof, or 🔴 revision |

This is a default, not a religion. Night shifts and releases win. Adapt, then continue.

## The month

Every month has:

- learning goals
- concept list
- labs
- one mini-project
- an assessment gate
- revision
- a few interview *seeds* (not memorization)
- one production scenario
- a written monthly review

Template: [`../system/templates/monthly-review.md`](../system/templates/monthly-review.md)

## The quarter

Every 3 months: skills, practicals, career skills, and a schedule verdict:

| Verdict | Meaning |
| ------- | ------- |
| 🟢 Ahead | More than 2 weeks ahead of the roadmap |
| 🟢 On track | Within 2 weeks |
| 🟡 Slightly behind | 2–6 weeks |
| 🔴 Significantly behind | > 6 weeks — we cut scope, not sleep |

Verdicts come from `progress/`, not vibes.

## How memory is protected

You will forget. The system expects it.

- Week 7 of every month includes revision
- Weak areas go in [`../progress/weak-areas.md`](../progress/weak-areas.md)
- Failed assessments require **≥ 1 hour** of targeted revision before retest
- Retests use **new questions**
- Spaced revisits are scheduled after Months 3, 6, 12, 18, 24

## Prerequisites are a stop sign

```text
Want Kubernetes networking?
    Have you passed Linux networking + TCP/IP + DNS + Docker networking?
        No  → go back
        Yes → proceed
```

If you ask to skip, the mentor explains the incident you will be unable to debug, then sends you back.

## Primary stack (do not fork it)

Linux · Bash · Python · Git · AWS · Terraform · Docker · Kubernetes · GitHub Actions · Prometheus · Grafana · OpenTelemetry · Splunk · AppDynamics

Alternatives (Azure, Ansible, Jenkins, Datadog, …) are mentioned so you can recognize them. They are not parallel curricula.

## How difficulty increases

| Evidence | Mentor response |
| -------- | ---------------- |
| You memorize | Change the question to a failure |
| You skip fundamentals | Stop. Prerequisite lab. |
| You rush | Explain the 02:00 cost. Slow down. |
| You understand deeply | Raise the incident complexity |
| You fail an assessment | 🔴 + specific reread + new exam |

## What "I finished today's lesson" means

You:

1. Did the lab, not only read it
2. Wrote the challenge answer in your daily log
3. Logged time in [`../progress/time-log.md`](../progress/time-log.md)
4. Did **not** tick the concept complete

Only an assessment can turn 🟡 into 🟢.
