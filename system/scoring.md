# Scoring system

## Concept / week theory bars

| Section | Pass bar | Type |
| ------- | -------- | ---- |
| A MCQ | 80% | numeric |
| B Short answer | 70% | rubric 0–2 per question, then % |
| C Long answer | 70% | rubric 0–4 per question, then % |
| D Troubleshooting | PASS | binary, with notes |
| E Practical | PASS | binary, with notes |
| F SRE scenario | PASS | binary, with notes |

A concept cannot go 🟢 if D, E, or F (when present) is FAIL, even if A–C are 100%.

## Short-answer rubric (per question)

| Score | Meaning |
| ----- | ------- |
| 0 | Missing or wrong mechanism |
| 1 | Partially right, missing the SRE "so what" |
| 2 | Correct mechanism + when you would use it |

## Long-answer rubric (per question)

| Score | Meaning |
| ----- | ------- |
| 0 | Recall of names only |
| 1 | Some steps, wrong order or wrong layer |
| 2 | Correct picture, shallow failure story |
| 3 | Correct picture + failure + commands/evidence |
| 4 | The above + trade-off / what you would not do |

## Overall attempt score (informational)

```text
0.25*MCQ + 0.15*Short + 0.20*Long + 0.15*D + 0.15*E + 0.10*F
```

D/E/F contribute 100 if PASS, 0 if FAIL.  
This number is recorded. It does **not** override the binary gates.

## Project score

| Dimension | Weight |
| --------- | -----: |
| Architecture | 15% |
| Implementation | 20% |
| Reliability | 15% |
| Observability | 15% |
| Security | 10% |
| Troubleshooting evidence | 15% |
| Documentation | 10% |

Pass: **80%** and no dimension below 50%.  
A beautiful README with a flaky system fails.

Early project versions (v1–v2) may mark Observability/Security as "scaffolded" and redistribute those weights to Implementation + Troubleshooting. The version README will say so. From v7 onward, all dimensions apply.

## Maturity levels (not a percentage)

| Level | Name | You can... |
| ----- | ---- | ---------- |
| 0 | Beginner | Recognize the name |
| 1 | Learner | Follow a guided lab |
| 2 | Practitioner | Do the task independently |
| 3 | Production engineer | Troubleshoot a real system |
| 4 | SRE | Design and operate for a promise (SLO) |
| 5 | Advanced SRE | Reason about large distributed failure |

The 31-month goal is **Level 4+**.  
Levels are assigned at quarterly reviews from evidence, not from months elapsed.

## Schedule health

Computed at monthly and quarterly reviews from planned vs completed *gated* weeks.

| Badge | Drift |
| ----- | ----- |
| 🟢 Ahead | > 2 weeks ahead |
| 🟢 On track | ± 2 weeks |
| 🟡 Slightly behind | 2–6 weeks |
| 🔴 Significantly behind | > 6 weeks |

Behind is a planning signal. It is not shame. The response is to cut optional scope or extend a month, never to assign 6-hour nights.
