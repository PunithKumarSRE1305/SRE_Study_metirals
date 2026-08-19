# Visual: Linux troubleshooting method

Full doc: [`../troubleshooting/linux-troubleshooting-method.md`](../troubleshooting/linux-troubleshooting-method.md)


```text
Symptom → H1/H2 → one command → evidence → mitigate → postmortem
```

## Walk it

A **method**: observe → hypothesize (two of them) → pick the smallest next command that could kill a hypothesis → mitigate → then root-cause. Random commands are not troubleshooting.

**SRE why:** This is the job. Tools change. The loop does not. Write the hypothesis *before* the third command.

## 5-minute lab

```bash
Pick a real annoyance on your lab box. Write H1/H2 before any command. Then run at most three commands. Log it.
```

## Check yourself

Latency 5s, CPU 30%, disk 100% on /var, DB connections 95%. Write H1 and H2 and the first command. Do not fix yet.
