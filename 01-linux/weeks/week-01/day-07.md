# Week 01, Day 7 — Revision + assessment

- Time box: 90–120 minutes
- Assessment file: [`../../assessments/week-01.md`](../../assessments/week-01.md)

## Unlock rule

Say **`I am ready for assessment`** to the mentor only if:

- Days 1–6 exist in `progress/daily-logs/` (or equivalent notes)
- The Day 6 map exists
- You have not already opened the answer key (there isn't one in-repo)

If those are missing, this is a **revision-only** day. The mentor will not unlock.

When the mentor says **"Assessment unlocked"**, open the assessment and work it in one sitting if possible.

## Revision (30–40 min, before the exam)

From memory, on paper or a blank file:

1. Kernel vs user space vs shell vs terminal
2. Draw `/` with 8 children and one-line purposes
3. Absolute vs relative path — two examples each
4. Why `cd` cannot be a separate binary
5. Why `df -h` and `df -i` can disagree
6. The four-step troubleshooting method
7. PT bridge: a soak test filling `/var`

Then check against the concept docs. Correct in a "revision corrections" heading.

Re-run only if shaky:

```bash
pwd
cd /var/log && pwd && cd - && pwd
ls -ld /var/log
df -h && df -i
```

## Assessment (60–80 min)

Follow [`../../assessments/week-01.md`](../../assessments/week-01.md).

Pass bars: [`../../../system/scoring.md`](../../../system/scoring.md)

- MCQ 80%
- Short 70%
- Long 70%
- Troubleshooting PASS
- Practical PASS
- SRE scenario PASS

## After you submit

Do not mark the week 🟢 yourself.

The mentor grades, then updates:

- `progress/assessments/log.md`
- `progress/concept-tracker.md` (Week 1 rows)
- `progress/weekly-tracker.md` (W01)
- `progress/CURRENT.md`
- `progress/weak-areas.md` if needed
- root `README.md` dashboard

If 🔴: minimum 1 hour revision, then a **new** paper (Attempt 2). Same concepts, different questions, more practical wrapping.

## If you fail

That is data. Week 2 does not start until Week 1 is 🟢 **or** the mentor explicitly parks a sub-concept (rare this early). Usually you revise and retest.

## Log

Revision notes + "assessment submitted" + minutes. Still no self-awarded 🟢.
