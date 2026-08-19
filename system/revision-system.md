# Revision system

Forgetting is the default. The system is built for it.

## Layers of revision

| Layer | When | What |
| ----- | ---- | ---- |
| Daily | Last 10 minutes | Write 5 facts / 1 diagram from memory |
| Weekly | Day 7 | Re-solve one old trouble ticket + assessment |
| Monthly | Last 3–4 days of the month | Weak-area drills + month exam |
| After failure | ≥ 1 hour before retest | Only the failed mechanisms |
| Spaced | Months 3, 6, 12, 18, 24 | Re-lab a random incident from earlier phases |

## Weak-area file

[`../progress/weak-areas.md`](../progress/weak-areas.md) is append-only until an item is **re-assessed** and passed.

A weak area is created when:

- a section score is below bar
- the mentor sees memorization
- you say "I still don't get X" (this counts; honesty is data)

A weak area is closed only by a later assessment that targets it.

## What revision is not

- Re-reading the same document highlighting nothing
- Watching a 3-hour YouTube "Linux in one video"
- Redoing a lab with the answer sheet open

Revision is: retrieve from memory, then check, then do a *slightly different* lab.

## Spaced revisit menu (mentor picks 2–3)

At the months listed above, pick from:

- a Linux boot/service failure
- a permission outage
- a DNS failure
- an IAM "access denied"
- a full disk
- a crashlooping container
- a bad deploy rollback
- an SLO burn-rate page

If you cannot do the old lab without notes, it returns to 🔴 even if it was 🟢. This is the only way a 🟢 can be revoked.
