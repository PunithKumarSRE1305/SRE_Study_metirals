# How to use this repository

## The daily loop (10 seconds of decision, 120 minutes of work)

```text
1. Open README.md
2. Confirm progress/CURRENT.md matches reality
3. Open today's lesson file
4. Work the 120-minute plan
5. Log time + notes in progress/daily-logs/
6. Stop
```

Do not browse other months "just to see." Curiosity is fine on Sunday. It is not today's lesson.

## Where truth lives

| Kind of truth | File |
| ------------- | ---- |
| Where I am | [`../progress/CURRENT.md`](../progress/CURRENT.md) |
| Percents | [`../progress/overall-progress.md`](../progress/overall-progress.md) |
| Weeks | [`../progress/weekly-tracker.md`](../progress/weekly-tracker.md) |
| Concepts | [`../progress/concept-tracker.md`](../progress/concept-tracker.md) |
| Weak spots | [`../progress/weak-areas.md`](../progress/weak-areas.md) |
| Hours | [`../progress/time-log.md`](../progress/time-log.md) |
| Rules | [`../system/completion-rules.md`](../system/completion-rules.md) |

The root README is a *dashboard*. If it disagrees with `progress/`, `progress/` wins and the README must be updated.

## Folder contract

Every concept document should follow [`../system/templates/concept-document.md`](../system/templates/concept-document.md) — the 25-section structure.

Every module `README.md` tells you:

- prerequisites
- what "done" means
- concept list
- labs / projects / assessments
- which months it occupies

Week folders (starting with Linux) contain the only files you need that week.

## What you write vs what the mentor writes

| You write | Mentor writes |
| --------- | ------------- |
| Daily logs | New concept docs when you reach them |
| Lab notes / commands / outputs (redact secrets) | Assessments and retests |
| Challenge answers | Grades and weak-area updates |
| Postmortems for simulations | Monthly / quarterly reviews |
| Project code in `28-projects/` | Progress % updates from evidence |

## Lab hygiene

- Prefer a throwaway VM or WSL2 / cloud sandbox, not your work laptop's soul
- Never commit keys, `.env`, or customer data
- Screenshot or paste command output into the daily log
- If a command can destroy something, the lesson will say so. Read that line.

## Assessment unlock

You may request an assessment when:

1. The week's Days 1–6 (or the module's required labs) are logged
2. No prerequisite concept is 🔴
3. You say `I am ready for assessment`

The mentor then points at the assessment file.  
Passing moves 🟡 → 🟢.  
Failing moves it to 🔴 and assigns revision. Minimum revision time: **1 hour**. Next exam is a **new** paper.

## If you miss a week of work

Do not "catch up" by doubling hours. Do this:

1. Mark the week 🟡 with hours = actual
2. Slide the calendar, do not compress two weeks into one
3. Mention it at the next monthly review

The 31-month plan has slack inside months (revision days). Use that slack.

## If you want to skip to Kubernetes

No. Read the incident in [`../roadmap/prerequisites.md`](../roadmap/prerequisites.md) that you would be unable to debug. Then go back.

## First action after reading this file

Set `start_date` in [`../progress/CURRENT.md`](../progress/CURRENT.md) to today's date. Then open Day 1.
