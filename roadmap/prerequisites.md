# Prerequisites — the stop signs

If you ask to skip, the mentor should show you the incident you will be unable to handle.

## Hard gates

| You want | You must have 🟢 |
| -------- | ---------------- |
| Linux permissions deep-dive | filesystem, users, processes |
| systemd | processes, logs, filesystem |
| Linux networking tools | filesystem, processes, permissions |
| Subnetting / routing | OSI/TCP-IP mental model |
| DNS troubleshooting | UDP/TCP, what a "resolver" is |
| TLS | HTTP, DNS, basic crypto vocabulary |
| Git branching workflows | Git snapshot model |
| Python automation | Linux paths, files, exit codes |
| AWS VPC | IPv4, routing, security groups *idea* from firewalls |
| IAM deep | Linux users/permissions analogy + least privilege |
| Terraform | AWS console/CLI for the same resources once |
| Docker | Linux processes, filesystems, networking, namespaces *intro* |
| Docker networking | Linux net + Docker engine |
| Kubernetes | Docker + Linux + networking |
| K8s Services / Ingress | TCP, DNS, HTTP |
| K8s storage | Linux mounts + Docker volumes |
| EKS | K8s + AWS VPC + IAM |
| GitHub Actions deploy to AWS/K8s | Git + the target platform |
| Prometheus | Linux + a running app + HTTP |
| SLI/SLO | a service you can measure |
| Incident command | observability + Linux debug |
| Chaos | incident process + a system with SLOs |
| Multi-region | single-region HA + DNS + data replication ideas |

## The incident behind each common skip request

### "Can I start Kubernetes this month?"

Node goes NotReady. Pods are Pending. You do not know whether it is disk, kubelet, CNI, or IAM. You reboot the node. The page stays red. That is the cost.

### "I know networking, I used URLs in JMeter."

DNS returns the wrong record in one AZ. Your load test would have said "high error rate." An SRE has to know *which layer* died.

### "Skip Linux, I'll live in the cloud console."

The instance is reachable on 22 from the bastion but `disk 100%`, journald is silent, and the user data script failed. The console cannot `lsof` for you.

### "SLOs first, tools later."

You write "99.9% availability" with no SLI, no event, no burn-rate alert. It is a slogan. SRE without measurement is branding.

## Soft gates (mentor may teach a preview)

- A 15-minute "what is a container" analogy during Linux namespaces week is allowed.
- Error-budget *language* can appear in Month 1 scenarios.
- You may *watch* a deploy, you may not *own* EKS early.

Previews do not create 🟢.
