# Linux troubleshooting method

**Week:** W09 · **Visual:** [`../visuals/linux-troubleshooting-method.md`](../visuals/linux-troubleshooting-method.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

A **method**: observe → hypothesize (two of them) → pick the smallest next command that could kill a hypothesis → mitigate → then root-cause. Random commands are not troubleshooting.

## 2. Why does it exist?

Without a method you thrash, change three things, and never know what fixed it. That is how outages recur.

## 3. Why do I need to know this as an SRE?

This is the job. Tools change. The loop does not. Write the hypothesis *before* the third command.

## 4. Real-world analogy

A doctor does not prescribe every medicine at once. They take a history, form a differential, test.

## 5. How does it work internally?

There is no syscall for 'method'. It is discipline. Layers: user symptom → SLI → instance → process → files/sockets/perms → kernel/hardware. Jumping layers without evidence wastes the error budget.

## 6. Syntax / structure

```bash
# write this first:
# Symptom:
# H1:
# H2:
# First command and why:
# What would disprove H1:
```

## 7. Basic example

```bash
# example only after you write your own
uptime; df -h; df -i; free -h; vmstat 1 3
```

## 8. Step-by-step execution

1. What do users feel?
2. What changed? (deploys, time, one AZ)
3. Name two hypotheses at a layer.
4. One command.
5. Update or kill a hypothesis.
6. Mitigate if still burning.
7. Write what you learned.

## 9. Why would I use this?

Every ticket from Week 1 onward. Formalized in incident month.

## 10. When should I NOT use it?

Do not reboot as the first experiment. Do not change config and restart in the same breath if you can separate them.

## 11. Alternative ways

The 9-step failure loop in `system/failure-engineering.md` is this method with postmortem attached.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| method | learning | repeatable | feels slow | always |
| reboot | clear state | sometimes mitigates | destroys evidence | last |
| blame the last deploy | often right | fast | sometimes wrong | a hypothesis, not a fact |

## 13. Common mistakes

- Three changes at once
- No notes
- Tool-first ('I opened top because I always do')
- Calling it 'human error' and stopping

## 14. Troubleshooting

If you are lost: return to the symptom and the four golden host checks (load, disk, mem, iowait). Then pick a layer.

## 15. Production relevance

Incident command exists so someone keeps this method while others execute.

## 16. Security considerations

Do not paste customer data into the notes. Do not run destructive tests on prod to 'see'.

## 17. Performance considerations

A bad method extends MTTR. That *is* a reliability metric.

## 18. Related concepts

```text
every Linux concept → this loop → incidents → postmortems
```

## 19. Visual diagram

```text
Symptom → H1/H2 → one command → evidence → mitigate → postmortem
```

## 20. Hands-on exercise

```bash
Pick a real annoyance on your lab box. Write H1/H2 before any command. Then run at most three commands. Log it.
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

Latency 5s, CPU 30%, disk 100% on /var, DB connections 95%. Write H1 and H2 and the first command. Do not fix yet.

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** What is your first minute on a 503?
- **Intermediate:** Why not reboot first?
- **Advanced:** How do you know a hypothesis is dead?

## 23. SRE scenario

War room with 12 people running random kubectl. You stop them, restate the symptom, assign one check each.

## 24. Summary

Two hypotheses. One command. Notes. Mitigate before archaeology.

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

- Here is what you already know from performance testing: You already form bottleneck hypotheses in tests.
- Here is the SRE equivalent: Same muscle, live system, worse clock.
- Here is what you need to learn next: strace as last mile.
