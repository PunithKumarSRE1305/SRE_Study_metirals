# Bash essentials — quoting, pipes, exit codes

**Week:** W10 · **Visual:** [`../visuals/bash-essentials.md`](../visuals/bash-essentials.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

**Bash** is the language of the incident. **Quoting** stops word-splitting. **Pipes** connect stdout to stdin. **Exit codes** are how you know it failed. `set -euo pipefail` is the minimum adult script header.

## 2. Why does it exist?

Unquoted variables and silent failures are how people `rm` production and cron-fail for a month.

## 3. Why do I need to know this as an SRE?

You will write one-liners under pressure. They must be boring, quoted, and logged. Cron PATH is not your PATH.

## 4. Real-world analogy

A sentence without quotation marks — you cannot tell where the name ends.

## 5. How does it work internally?

The shell tokenizes, expands (`$`, `*`, `~`), then `exec`s. Unquoted `$FILE` with a space becomes two words. A pipeline's default `$?` is the last command unless `pipefail`. `set -e` exits on a failing command; know its exceptions.

## 6. Syntax / structure

```bash
set -euo pipefail
FILE='/tmp/My Logs'
ls -ld -- "$FILE"
ps aux | grep '[n]ginx'
echo "${PIPESTATUS[@]}"
```

## 7. Basic example

```bash
set -euo pipefail
name='a b'
mkdir -p /tmp/sre-q
touch "/tmp/sre-q/$name"
ls -l "/tmp/sre-q/$name"
```

## 8. Step-by-step execution

1. Write the header.
2. Quote every expansion.
3. Use `--` before paths.
4. Check `$?` / `pipefail`.
5. Use absolute paths in anything scheduled.

## 9. Why would I use this?

Safe one-liners. Tiny operator scripts. Wrappers around kubectl/aws later.

## 10. When should I NOT use it?

Do not write a 500-line framework in bash. Do not parse `ls`. Do not use eval.

## 11. Alternative ways

Python is the next language when the script grows feelings.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| quoted bash | glue | everywhere | easy to get subtle-wrong | small jobs |
| python | clearer logic | tests, HTTP | heavier | growing tools |
| Makefile | dev tasks | familiar | not for prod cron | dev |

## 13. Common mistakes

- unquoted $VAR
- grep self-match in pipes
- ignoring pipefail
- relative paths in cron

## 14. Troubleshooting

**command not found in cron:** PATH. **rm: too many arguments:** unquoted glob. **script stopped early:** set -e hit a grep that found nothing (exit 1).

## 15. Production relevance

A deploy hook without `set -e` 'succeeds' after a failed migration. You ship a lie.

## 16. Security considerations

Unquoted filenames starting with `-` become flags. `--` saves you. Never echo secrets.

## 17. Performance considerations

bash in a tight loop is slow. Fine for ops glue.

## 18. Related concepts

```text
shell vs terminal → quoting → PATH → cron → python later
```

## 19. Visual diagram

```text
$FILE=/tmp/My Logs
unquoted  →  /tmp/My    Logs     (two words)
quoted    →  /tmp/My Logs        (one word)
cmd1 | cmd2   stdout→stdin;  stderr still your screen
```

## 20. Hands-on exercise

```bash
set -euo pipefail
mkdir -p "$HOME/sre-lab/q"
fn='file with spaces'
touch "$HOME/sre-lab/q/$fn"
ls -l "$HOME/sre-lab/q/$fn"
# compare: ls $HOME/sre-lab/q/$fn   # may break — see it, then stop
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

Write a one-liner that deletes logs only in /var/log/myapp and fails closed if the directory is missing.

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** Why quote?
- **Intermediate:** What does pipefail do?
- **Advanced:** Why did cron not find the command?

## 23. SRE scenario

Cleanup script `rm -rf $DIR/*` with DIR empty expanded to `rm -rf /*`. You restore, rewrite with quotes and a prefix check.

## 24. Summary

Quote. set -euo pipefail. Absolute paths. Bash is glue, not a career.

## 25. Knowledge checklist

- [ ] I understand what this is
- [ ] I understand why it exists
- [ ] I can explain it
- [ ] I can use it
- [ ] I can troubleshoot it
- [ ] I can explain its alternatives
- [ ] I can apply it in production
- [ ] I can answer interview questions

### Performance-testing bridge

- Here is what you already know from performance testing: You already wrap test runs in scripts.
- Here is the SRE equivalent: Make those wrappers safe enough for 03:00.
- Here is what you need to learn next: ip, ss, curl on this host.
