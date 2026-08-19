# Week 01, Day 4 — Troubleshooting: "I am lost in the tree"

- Time box: 120 minutes
- Mode: troubleshooting

## Objective

Practice a method, not a bag of commands.

```text
1. What do I see?
2. What do I believe is true?
3. How would I falsify that?
4. What is the smallest next command?
```

Randomly typing `ls` in more directories is not troubleshooting.

## Time plan

```text
Method                    15 min
Guided failures           55 min
Unguided tickets          35 min
Revision                  15 min
```

## Method

Every ticket today, write this block in your log **before** the commands:

```text
Symptom:
Hypothesis 1:
Hypothesis 2:
First command and why:
What would disprove H1:
```

Then run at most three commands. Update the hypothesis.

## Guided failures

Work on your own box. Do not need root for most of these.

### Ticket A — "cd does nothing"

A teammate ran `cd /var/log` in a script:

```bash
#!/bin/bash
cd /var/log
```

They execute `./myscript.sh` and their prompt is still in `$HOME`.

**Your job:** explain *before* you Google. Hint from Day 1–3: processes.

### Ticket B — "ls shows nothing but the app writes logs"

An app is configured to write `/opt/myapp/logs/app.log`.  
`ls /opt/myapp/logs` is empty (or the directory is missing).  
`df -h` is fine.

Give three causes that are *not* "disk full." You may not have `/opt/myapp` — invent the investigation order anyway, then create a fake tree in `$HOME/sre-lab` and simulate one cause.

### Ticket C — "Permission denied on cd"

```bash
mkdir -p "$HOME/sre-lab/locked/secret"
chmod 000 "$HOME/sre-lab/locked"
cd "$HOME/sre-lab/locked"
echo $?
ls "$HOME/sre-lab/locked"
echo $?
chmod u+rx "$HOME/sre-lab/locked"
cd "$HOME/sre-lab/locked"
pwd
chmod u+rwx "$HOME/sre-lab/locked"
```

Write: which permission bit is needed to `cd` into a directory, and which to `ls` it?  
If you are not sure, that is fine — record what you observed. Week 3 will name the bits formally.

### Ticket D — "I deleted myself"

```bash
cd "$HOME/sre-lab/week01/a/b/c"
# in another terminal, if the path exists:
rm -rf "$HOME/sre-lab/week01"
pwd
ls
cd .
echo $?
cd /
pwd
```

A process can sit in a directory that has been deleted. `pwd` may still print the old path. This shows up with containers and deleted-but-open log files (disk not freeing). You will meet that again in Month 2.

## Unguided tickets (pick two, 35 min)

1. `ls` output is so long you cannot read it. What now? (You may discover `less`, `| head`, or `ls | wc -l`. Note *why* you chose it.)
2. You do not know whether `/usr/bin/python3` exists. How do you ask without `cd`?
3. `cd ~/Sre-Lab` fails. `ls ~` shows `sre-lab`. What property of Linux paths did you forget?

## Challenge

Write a 10-line runbook titled **"I don't know where I am"** that a future you could follow at 02:00. No more than 6 commands in it.

## Revision

Recite the four-step method from memory. If you skipped writing hypotheses before commands on any ticket, redo that ticket properly. That is the whole point of Day 4.

## Log

Hypothesis blocks + commands. No 🟢.
