# Assessment system

## When an assessment unlocks

The mentor says **"Assessment unlocked"** only after:

- required lessons for that unit are logged
- required labs have evidence
- prerequisite concepts are not 🔴

You then open the assessment file and work it in one sitting if possible (still budgeted; long module exams are split).

## Anatomy of an assessment

Every meaningful concept or week uses this skeleton.

### Section A — MCQ (10–20)

Test reasoning, not trivia.

Bad: "What flag to `ls` shows hidden files?"  
Good: "A service writes logs to `.hidden/app.log`. `ls /var/log/app` shows nothing. Disk is filling. What is going on, and what do you run first?"

### Section B — Short answer (~5)

A paragraph. If a command is needed, say *why*.

### Section C — Long answer (2–5)

Explain a mechanism or a decision. Diagrams welcome.

### Section D — Troubleshooting

A broken system. You list:

- what you investigate
- commands / signals
- why that order

Example shape:

```text
A Linux server reports disk 100%.
The application returns HTTP 503.

What do you investigate?
What commands do you run?
Why that order?
What would make you reject "just delete everything in /tmp"?
```

### Section E — Practical

You must do the thing. Paste evidence (commands + outputs, redacted).

### Section F — SRE scenario

A production narrative. Often 02:00. Often lying metrics.

```text
02:00. Latency 200ms → 5s.
CPU 30%.
Database connections 95%.

Hypothesis?
Evidence?
Immediate mitigation?
What you will not do yet?
```

Tiny command docs (e.g. `pwd`) do not each get a 6-section exam. They roll into the **weekly** exam. Deep concepts (permissions, TCP, IAM, Deployments) get their own.

## Pass bars

See [`scoring.md`](scoring.md). Practical and troubleshooting are binary PASS/FAIL and **block** completion.

## After grading

**Pass:** status 🟢, attempts += 1, notes of any weak subtopics (even on a pass).

**Fail:** status 🔴, attempts += 1, mentor writes:

1. What was wrong
2. Why it was wrong
3. Which concepts are weak
4. Which document sections to reread
5. Which lab to repeat
6. A revision block of **at least 1 hour**
7. "Request a retest after revision. The next paper is different."

Log the attempt in [`../progress/assessments/log.md`](../progress/assessments/log.md).

## Integrity

- Timed honor system. You work 10 hours a day; we will not proctor you.
- Do not paste the answer key into the daily log before you attempt.
- The mentor must not reveal Section D–F answers before your attempt.
- Using production customer data as "evidence" is an automatic fail and a security incident.

## "Assessment unlocked" phrase

The mentor should use those exact words so you know the gate is open. Until you hear them, keep studying.
