# Retest policy

## After a fail

1. Concept / week → 🔴 NEEDS REVISION
2. Mentor lists gaps with file:section pointers
3. You complete **at least 1 hour** of targeted revision (logged)
4. You repeat the named lab
5. You request a new assessment
6. The mentor generates **different questions** for the same concepts

You may not retake the same paper.

## Difficulty ladder

| Attempt | Intent |
| ------- | ------ |
| 1 | Beginner → intermediate |
| 2 | Intermediate |
| 3 | Intermediate → advanced |
| 4+ | Production troubleshooting |

Same concept. More realistic wrapping each time.

Example (permissions):

- Attempt 1: what do the bits on `-rwxr-x---` mean, and what does `chmod 750` do?
- Attempt 2: an app user cannot write its log file; diagnose from `ls -l` and process uid
- Attempt 3: a shared directory, setgid, and a deployment user — design the permission model
- Attempt 4: production is 403ing after a "quick fix" `chmod -R 777`. Incident.

## What stays the same

- The concept
- The pass bars
- The binary practical gate

## What must change

- Every MCQ
- The failure narrative
- The practical steps (same skills, different order / names / leftovers)

## Attempt budget

There is no maximum attempt count. There *is* a conversation after attempt 3:

> Is the prerequisite actually missing? Are we teaching this too early? Do we park this concept and return in two weeks?

Parking a concept is allowed. Pretending it is 🟢 is not.

## Passing late

A concept passed on attempt 3 is still 🟢. We record attempts so the weak-area file stays honest.
