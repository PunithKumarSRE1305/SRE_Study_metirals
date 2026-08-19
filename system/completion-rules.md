# Completion rules

These rules are not motivational posters. They decide what the dashboard is allowed to say.

## A concept is complete only when all of these are true

1. The concept document has been studied (logged).
2. The hands-on exercise has been performed (evidence in a daily log or lab notes).
3. The mini-challenge has an answer written by you.
4. The assessment is **unlocked** and **attempted**.
5. Theory scores meet the bars in [`scoring.md`](scoring.md).
6. Troubleshooting is **PASS**.
7. Practical is **PASS**.
8. SRE scenario is **PASS** (or N/A for tiny command-level concepts that roll into a weekly exam).

Then and only then: status → 🟢 and the concept may contribute to module %.

## What never completes a concept

- I read it
- I watched a video
- I completed a tutorial
- I ran a few commands
- I copied a lab from memory of a blog
- The mentor explained it well
- I have used the tool at work once

## Module completion

A module (e.g. `01-linux`) is 🟢 only when:

- every **required** concept in its tracker is 🟢
- the module project (if any) scores ≥ 80%
- the module assessment is passed
- no required concept is 🔴

Optional / stretch concepts do not block the module, but they stay visible.

## Week completion

A week is 🟢 when:

- planned study hours are logged (or an adapted plan is logged)
- Day 7 assessment passed **or** the week was a pure project week whose deliverable passed

Hours alone do not complete a week.

## Project completion

See [`project-scoring.md`](project-scoring.md). Files existing in git ≠ project complete.

## Phase completion

A phase completes when its required modules complete. Partial credit is allowed on the overall bar (weighted by planned months), but the phase badge stays 🟡 until the gate assessment for that phase is passed.

## Progress math (no fiction)

```text
concept %     = scored assessments only
module %      = completed_required_concepts / required_concepts
                (0 if none assessed)
overall %     = completed_month_weight / 31
                using months whose gate is passed
```

Until the first assessment is passed, **every bar is 0%**.

## Status icons

| Icon | When to use |
| ---- | ----------- |
| ⚪ | No serious work logged |
| 🟡 | Work logged, assessment not passed |
| 🟢 | Assessment passed under these rules |
| 🔴 | Assessment failed, or mentor flagged a dangerous gap |

Reading 10 pages does not move ⚪ → 🟡. A logged lab does.

## Mentor enforcement

If the student says "mark Linux done, I used it at work":

> No. Work exposure is evidence of 🟡 at most. Take the assessment.
