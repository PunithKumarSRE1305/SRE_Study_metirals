# Why an SRE needs Linux

## 1. What is it?

A stance: Linux is not a module you finish. It is the room the job happens in.

## 2. Why does it exist? (this document)

Because people try to skip to Kubernetes and then cannot answer "why is this pod `OOMKilled`?" without folklore.

## 3. Why do I need to know this as an SRE?

Your pages will look like:

- 5xx at the load balancer
- latency burn on the SLO
- CrashLoopBackOff
- disk pressure
- "the node is flaky"

Every one of those bottoms out as: a process, a file, a socket, a permission, a cgroup limit, or a kernel refusal.

## 4. Real-world analogy

You can drive without knowing how brakes work. You cannot be the mechanic on the night shift.

## 5. How does it work internally?

Not applicable as a mechanism. The *career* mechanism is:

```text
Symptom (user)
  → SLI (metric)
    → which instance / pod / node
      → process + files + sockets on Linux
        → fix, restart, rollback, or capacity
```

Skip the fourth line and you only ever restart.

## 6. Syntax / structure

None. This is a reason, not a command.

## 7. Basic example

A JMeter test shows p95 = 4s. AppDynamics says the business transaction is slow in "wait." Linux `iostat` shows the log disk at 100% utilization because `debug` logging was left on. The SRE who can only open AppDynamics files a ticket named "app slow." The SRE who knows Linux turns the logging down and the SLO recovers in four minutes.

## 8. Step-by-step execution

When you get a page, the Linux-shaped questions are:

1. Which machine (or which node under the pod)?
2. Is it still reachable (ssh/ssm)?
3. Is the process alive? Restarting? Zombied?
4. Is the disk full (bytes or inodes)?
5. Is the process allowed to write what it writes?
6. Is it listening on the port we think?
7. What did it log *itself*?

You will grow tools around these questions. The questions do not change.

## 9. Why would I use this?

Every day of the 31 months. Even "platform engineering" is Linux with better packaging.

## 10. When should I NOT use it?

Do not SSH into twelve production nodes as your first move when a load balancer health check is failing because of a bad deploy. Linux is the ground truth, not the first button. Mitigate (rollback) then confirm on one box.

## 11. Alternative ways

Windows servers exist. Managed services hide Linux. You still need the model, because the managed service is someone else's Linux plus an API.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| Stay in the cloud console | Fast inventory | Pretty | No `strace`, no real fds | First minute |
| APM only | User journey | Maps dependencies | Blind to node death | With Linux |
| Linux first principles | Ground truth | Always there | Easy to rabbit-hole | To confirm |

## 13. Common mistakes

- Collecting certifications instead of hours in a shell
- Only ever using `kubectl exec` and never understanding the namespace
- Treating the cloud as non-Linux

## 14. Troubleshooting

If you cannot explain a failure without naming a vendor product, you do not understand it yet. Add the Linux sentence.

## 15. Production relevance

This entire repository exists so that in Month 18, "CrashLoopBackOff" means something in your bones: the process started, the kernel delivered a signal or an OOM, or the process exited 1 because a file was missing.

## 16. Security considerations

Shell access is power. Least privilege applies to *you* too. Break-glass SSH should be logged.

## 17. Performance considerations

Knowing Linux means you stop load-testing "the app" as a blob and start testing the constraint: CPU, lock, disk, pool, chatty logs.

## 18. Related concepts

```text
this stance → every later module
```

## 19. Visual diagram

```text
JMeter / users
      │
      v
   SLI / APM / Splunk          ← you already have pieces
      │
      v
   process on Linux            ← this journey's foundation
      │
      ├─ files / disks
      ├─ memory / cgroup
      ├─ sockets / DNS
      └─ permissions / identity
```

## 20. Hands-on exercise

Write 8 lines in your daily log: a performance issue you have already seen at work, rewritten as a Linux-shaped hypothesis. You do not need to be right. You need to name a resource.

## 21. Mini challenge

Name a production incident that *cannot* be improved by Linux knowledge. If you cannot, good. If you can (e.g. a bad SQL query in a fully managed DB), name what Linux still tells you (connection waits, client timeouts).

## 22. Interview questions

- **Beginner:** Why should an SRE know Linux if they use Kubernetes?
- **Intermediate:** Walk a 503 from the user to a file descriptor.
- **Advanced:** When is SSHing to production the wrong first move?

## 23. SRE scenario

New hire wants to start at EKS week. You (future you) show them this file and Month 1 Day 1. That is mentorship.

## 24. Summary

Linux is the ground. Cloud and Kubernetes are maps. Learn the ground first.

## 25. Knowledge checklist

- [ ] I understand what this is
- [ ] I understand why it exists
- [ ] I can explain it
- [ ] I can use it
- [ ] I can troubleshoot it
- [ ] I can explain its alternatives
- [ ] I can apply it in production
- [ ] I can answer interview questions
