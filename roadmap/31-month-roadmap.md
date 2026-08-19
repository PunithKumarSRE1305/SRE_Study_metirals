# 31-month roadmap

Designed for **~2 hours/day**, **~10–14 hours/week**, **~1615 hours** total.  
Not equally sliced. Prerequisites decide the order.

Legend: **PT-bridge** = explicitly connected to performance-testing knowledge.

---

## Phase 1 — Foundation (Months 1–6)

### Month 1 — Linux first contact

**Why first:** every later layer is a process, a file, or a socket.

| Week | Focus |
| ---- | ----- |
| W01 | What Linux is, kernel vs user space, shell, FHS, paths, `pwd` `ls` `cd` |
| W02 | Files, editors, `cat`/`less`/`head`/`tail`, find, users intro |
| W03 | Users, groups, permissions, ownership, `umask`, sudo intro |
| W04 | Processes intro, signals, `ps`/`top`, month review + exam |

Mini-project: map a Linux box (Day 6 each week, plus W04 project).  
PT-bridge: `top` is the cousin of the CPU graph you already stare at during a load test.

### Month 2 — Linux administration

| Week | Focus |
| ---- | ----- |
| W05 | CPU, memory, `/proc`, load average (honest meaning) |
| W06 | Disk, filesystems, inodes, I/O, full-disk failure |
| W07 | systemd, journals, cron, time |
| W08 | SSH, sudoers, users at admin level, Linux mini-project |

Failure drills: kill a process, fill a disk (lab VM).

### Month 3 — Linux troubleshooting + networking start

| Week | Focus |
| ---- | ----- |
| W09 | Troubleshooting method, logs, `strace` intro, resource exhaustion |
| W10 | Bash essentials (not the full scripting course) |
| W11 | Networking first principles, OSI vs TCP/IP, packets, interfaces |
| W12 | IPv4, subnetting, CIDR (slow on purpose) |

### Month 4 — Networking deep + Git

| Week | Focus |
| ---- | ----- |
| W13 | Routing, ARP, NAT, firewalls / `iptables`/`nft` conceptual |
| W14 | TCP vs UDP, handshake, ports, `ss`, `curl` |
| W15 | DNS, HTTP/HTTPS, TLS, load-balancing *ideas* |
| W16 | Git: snapshots, branch, merge, rebase-as-idea, PR hygiene |

Network failure drills: break DNS on a lab VM, refuse "just flush DNS" as the only move.

### Month 5 — Bash scripting + Python start

| Week | Focus |
| ---- | ----- |
| W17 | Bash: scripts, `set -euo pipefail`, exit codes, quoting |
| W18 | Bash: text (`grep`/`awk`/`sed`), cron jobs you would trust |
| W19 | Python: runtime, venv, types you actually need, files, HTTP client |
| W20 | Python: parsing logs, small CLIs, talking to APIs |

PT-bridge: a JMeter listener is a script. Now you write the operator's version.

### Month 6 — Software engineering + portfolio v1 + Phase 1 gate

| Week | Focus |
| ---- | ----- |
| W21 | What an HTTP service is; 12-factor; config vs code |
| W22 | Build a small app (the portfolio seed) with health and logs |
| W23 | Drive it with JMeter; read its logs; kill it; restart it |
| W24 | Foundation revision |
| W25–W26 | Phase 1 assessment + **portfolio v1** scoring + buffer |

**Phase 1 gate:** Linux + networking + git + scripting exam, v1 project ≥ 80%.

---

## Phase 2 — Infrastructure (Months 7–11)

### Month 7 — AWS foundations

IAM *ideas*, regions/AZs, VPC intro, EC2, SG vs NACL, SSH to a box you created.

### Month 8 — AWS core services

ALB, S3, RDS *as a consumer*, CloudWatch intro, costing alarm, **portfolio v3** (app on AWS).  
PT-bridge: an ALB 5xx during a test is a *layer*, not "the app is slow."

### Month 9 — Terraform foundations

State, plan/apply, resources, variables, outputs, the blast radius of `apply`.

### Month 10 — Terraform + AWS together

Modules, remote state, environments, **portfolio v4**. Never apply what you cannot destroy.

### Month 11 — Security fundamentals + hardening

Secrets, IAM least privilege, SSH hardening, SG review, TLS certs, vulnerability *hygiene*.  
Linux admin revisit: patching, users, sudo.

**Phase 2 gate:** build, change, and tear down the lab stack with Terraform. Explain one IAM deny.

---

## Phase 3 — Containers (Months 12–13)

### Month 12 — Docker

Images, layers, Dockerfile, processes in a container, volumes, logs.

### Month 13 — Container networking, security, troubleshooting

Bridge vs host, ports, non-root, scanning, **portfolio v2** merged into the AWS app.  
Failure: kill the container, fill its writable layer, break DNS inside it.

**Phase 3 gate:** you can explain PID 1 in a container and debug a crashing image without Docker Desktop magic.

---

## Phase 4 — Kubernetes (Months 14–18)

### Month 14 — Architecture, Pods, Deployments, Services

Control plane, kubelet, what a Pod *is*, why a Deployment exists.

### Month 15 — Config, Secrets, volumes, probes, resources

The difference between "the YAML applied" and "the process is healthy."

### Month 16 — Networking, Ingress, DNS, NetworkPolicies intro, scheduling

PT-bridge: Service latency ≠ Pod CPU. You already know layers hide in averages.

### Month 17 — StatefulSets, DaemonSets, Jobs, HPA, RBAC, Helm

### Month 18 — Troubleshooting + EKS

Node NotReady, CrashLoopBackOff, image pull, RBAC deny, **portfolio v5**.

**Phase 4 gate:** debug a broken deploy on EKS (or a local cluster + a documented EKS lab) live.

---

## Phase 5 — CI/CD (Months 19–20)

### Month 19 — GitHub Actions

Build, test, artifact, deploy to the portfolio. Jenkins/GitLab as *concepts only*.

### Month 20 — Deployment strategies + GitOps ideas

Rolling, rollback, blue/green, canary. **Portfolio v6.**  
Failure: ship a bad image, roll back under time pressure.

**Phase 5 gate:** one-button bad deploy + proven rollback + written decision tree.

---

## Phase 6 — Observability (Months 21–23)

### Month 21 — Metrics

Four golden signals, USE, RED. Prometheus + Grafana. Cardinality. **Portfolio v7.**

### Month 22 — Logs + alerting

Structured logs, Splunk as the log brain you already touched, alert fatigue, on-call pages that mean something. **Portfolio v8.**

### Month 23 — Traces + APM + OTel

OpenTelemetry, AppDynamics *next to* traces (overlap and gaps). **Portfolio v9.**

PT-bridge: AppDynamics business transaction ≈ RED for a journey. Prometheus is the SRE-native cousin.

---

## Phase 7 — SRE fundamentals (Months 22–24, overlaps obs)

SLI, SLO, SLA, error budgets, burn rates, toil, service ownership, reliability vs feature velocity.  
You write SLOs for the portfolio. You decide a release freeze with fake budget data.

---

## Phase 8 — Incident management (Months 24–25)

Detection, severity, IC, comms, escalation, on-call hygiene, mitigation vs root cause, blameless postmortems.  
**Live simulation** from `29-incident-simulations/`.

---

## Phase 9 — Distributed systems + data (Months 26–27)

### Month 26

Processes, concurrency, time, consistency, availability, CAP *without the poster*, replication, partitioning.

### Month 27

Databases (as an SRE: connections, failover, backups), caching, messaging / queues, backpressure.  
PT-bridge: connection-pool exhaustion is a load-test classic. Now you own the pool.

---

## Phase 10 — Advanced reliability + career (Months 28–31)

### Month 28 — Performance engineering + capacity

Your home turf, upgraded: production perf, load shedding, capacity models, cost.  
JMeter against the *portfolio*, SLOs as the pass/fail, not a PDF report.

### Month 29 — HA, DR, chaos, security revisit

**Portfolio v10–v12.** Formal chaos. DR game day.

### Month 30 — Multi-region + platform engineering + advanced SRE

**Portfolio v13.** Golden paths, paved roads, reliability reviews.

### Month 31 — Career readiness

Interview loops (Linux, net, AWS, K8s, SRE scenarios, behavioral), résumé from 🟢 projects only, offer-eval, slack.

---

## What we deliberately do *not* do

- Equal 3-week slices for every buzzword
- Parallel Azure + GCP curricula
- Interview memorization in Month 2
- Kubernetes in the first quarter
- Marking months complete because the calendar moved
