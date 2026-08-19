# Week 10 — visual explainers

**Theme:** Bash essentials for SRE

Diagram-first. Full 25-section docs are written when the week opens.

## Concept 1: Quoting

Word splitting is how people `rm` the wrong thing.

## Concept 2: Exit codes

`set -euo pipefail` is adult bash.

## Concept 3: Pipes

stdout of one is stdin of the next. stderr is a different river.

## Concept 4: PATH

The shell’s search list. Cron’s PATH is not yours.

## Concept 5: One-liners you would trust

Readable beats clever.


## Concept: a pipeline

```text
ps aux | grep nginx | awk '{print $2}'
  │         │              │
  stdout    stdout         stdout
  stderr───────── usually still your screen
```

Unquoted `$FILE` with a space becomes two arguments. That is how incidents start.


## Performance-testing bridge

Whatever this week names (files, perms, CPU, disk, packets) is something you already *saw from the outside* in a load test. The picture here is how that number is born.

## Check yourself

Close the page. Redraw one diagram from memory. If you cannot, you watched, you did not learn.
