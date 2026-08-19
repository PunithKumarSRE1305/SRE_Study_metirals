# Week 01, Day 3 — Paths and navigation (`pwd`, `ls`, `cd`)

- Time box: 120 minutes
- This is a **hands-on** day. Theory is short because the docs are deep.

## Objective

Move around a Linux tree on purpose. Explain absolute vs relative paths, what `cd` actually changes, and why the next command cares.

## Time plan

```text
Theory                    15 min
Concept docs              25 min   (cd.md is the gold standard)
Hands-on                  50 min
Challenge                 20 min
Revision                  10 min
```

## Theory (short)

The kernel tracks, per process, a **current working directory** (cwd).

```text
Process: bash  pid 1234
  cwd = /home/you
  you type: ls logs
  kernel looks up: /home/you/logs
```

`cd` is unusual: it is a **shell builtin**. It must change *this* shell's cwd. A separate program could not do that for you (processes cannot change their parent's memory).

```text
cd /var/log     absolute — same from anywhere
cd ../log       relative — depends on cwd
cd              no argument — usually $HOME
cd -            previous directory
```

If you only remember one danger: **scripts that assume cwd will betray you.** Always prefer absolute paths in cron and systemd.

## Visual first

[`visuals/05-paths.md`](visuals/05-paths.md) then [`visuals/06-pwd-ls-cd.md`](visuals/06-pwd-ls-cd.md)

## Docs (read `cd` fully)

1. [`../../commands/pwd.md`](../../commands/pwd.md)
2. [`../../commands/ls.md`](../../commands/ls.md)
3. [`../../commands/cd.md`](../../commands/cd.md) ← all 25 sections
4. finish [`../../filesystem/paths.md`](../../filesystem/paths.md)

## Hands-on

Do these in order. After each `cd`, run `pwd` and `ls`.

```bash
pwd
cd /
pwd
ls
cd /var/log
pwd
ls
cd ..
pwd
cd
pwd
cd -
pwd
```

Now the trap:

```bash
cd /var/log
ls
# open a *new* terminal / SSH session
pwd
```

The new session did **not** inherit the first session's `cd`. cwd is per process.

Create a playground (only in your home):

```bash
mkdir -p "$HOME/sre-lab/week01/a/b/c"
cd "$HOME/sre-lab/week01/a/b/c"
pwd
cd ../..
pwd
ls
cd ./a
pwd
```

Try a failure:

```bash
cd /var/log/this-is-not-here
echo $?
pwd
```

Did cwd change? Write the answer down *before* you theorize.

`ls` flags to actually use this week:

```bash
ls -l /var/log
ls -la "$HOME"
ls -ld /var/log
ls -lh /var/log
```

Know what `-l`, `-a`, `-d`, `-h` *change about the question you asked*.

## Challenge (no answer)

You are in `/var/log/nginx`. You run `cat error.log` and it works. You write a cron job:

```cron
*/5 * * * * cat error.log
```

It fails. Why, in terms of cwd? How would you write the cron line instead?  
What is the difference if the cron user is `root` vs `www-data`? (Permissions sneak in — that is allowed.)

## Revision

Draw, from memory:

```text
cd /var/log
```

from keystroke → shell builtin → kernel → new cwd. Compare to `cd.md` section 8.

## Log

Commands + `pwd` after the failure case. No 🟢.
