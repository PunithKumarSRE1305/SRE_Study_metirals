# Monthly milestones

A month is 🟢 only after its **gate** passes. "I attended all weeks" is not the gate.

| Month | You can do this without notes | Gate |
| ----: | ----------------------------- | ---- |
| 1 | Navigate a Linux system, explain FHS, read a permission string, list processes | Week 4 exam |
| 2 | Explain load average honestly; find what filled the disk; read a journal; SSH with keys | Linux admin mini-project |
| 3 | Debug a sick box with a method; write a small bash one-liner you trust; subnet a /24 | Month 3 exam |
| 4 | Trace a request from DNS to TLS; use `ss`/`curl`; make a clean git commit | Networking + git exam |
| 5 | Write a bash script with safe defaults; parse a log in Python | Scripting practical |
| 6 | Run your own HTTP app; load it with JMeter; restart it; read its logs | **Phase 1** + portfolio v1 |
| 7 | Launch a locked-down EC2 in a VPC you can draw | AWS foundations practical |
| 8 | Put the app behind an ALB; turn on a CloudWatch alarm that is not noise | AWS core practical |
| 9 | `terraform plan` and explain every destroy | Terraform exam |
| 10 | Two environments from modules + remote state | **Portfolio v4** |
| 11 | Find an over-broad IAM policy and fix it; rotate a key | Security practical |
| 12 | Write a Docker image that is not implicit `latest` + root | Docker exam |
| 13 | Debug container DNS and a crashing PID 1 | **Phase 3** + v2 merged |
| 14 | Draw the control plane; roll a Deployment; hit a Service | K8s core exam |
| 15 | Probes and resources that match reality | Workloads practical |
| 16 | Explain ClusterIP vs Ingress; debug Service endpoints | K8s net exam |
| 17 | Helm chart you can upgrade; RBAC that denies you (on purpose) | Mid-K8s exam |
| 18 | EKS: node group, IRSA *idea*, live CrashLoop debug | **Phase 4** + v5 |
| 19 | GH Actions pipeline to artifact | CI practical |
| 20 | Bad deploy + rollback in < 15 min | **Phase 5** + v6 |
| 21 | PromQL for the four golden signals; a Grafana board that answers 1 question | Metrics exam |
| 22 | A Splunk (or equivalent) investigation you can replay; an alert with a runbook link | Logs / alert exam |
| 23 | A trace that shows the slow hop; AppD vs OTel comparison write-up | **Phase 6** + v7–v9 |
| 24 | SLI/SLO/error budget for the portfolio; freeze/go decision | **Phase 7** |
| 25 | Incident simulation + published postmortem | **Phase 8** |
| 26 | Explain your system's consistency choice | Dist-sys design review |
| 27 | Diagnose pool exhaustion and a cache stampede on a lab | Data-plane practical |
| 28 | Capacity plan + JMeter suite gated by the SLO | Perf / capacity exam |
| 29 | Game day: AZ loss or chaos experiment with a report | **v10–v12** |
| 30 | Multi-region design + what you refuse to replicate | **v13** + design review |
| 31 | Mock interview loop passed at "hire" bar for junior/mid SRE | **Career checklist** |

## Monthly review ritual (last days of each month)

Use [`../system/templates/monthly-review.md`](../system/templates/monthly-review.md).  
If the gate fails, the month stays 🟡 or 🔴. The calendar may move. The badge does not.
