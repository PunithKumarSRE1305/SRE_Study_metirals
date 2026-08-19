# Project scoring

## When a project is eligible

- Version README's acceptance checks are attempted
- You can demo start / fail / recover
- You wrote a short design note (architecture + risks)
- You recorded one troubleshooting session

`git add .` is not a demo.

## Rubric

| Dimension | Weight | Looks like |
| --------- | -----: | ---------- |
| Architecture | 15 | Clear components, trust boundaries, failure domains |
| Implementation | 20 | It runs; config is not tribal knowledge |
| Reliability | 15 | Restart, health, retry, or graceful fail — appropriate to the version |
| Observability | 15 | You can *see* a failure you cause (from v7 this is mandatory) |
| Security | 10 | No 777, no secrets in git, least privilege appropriate to the version |
| Troubleshooting | 15 | You broke it, found it, wrote what you saw |
| Documentation | 10 | Another engineer can run it in 15 minutes |

Pass: **≥ 80%** and no dimension **< 50%**.

## Versioned expectations

The long project ([`../28-projects/evolving-reliability-platform/`](../28-projects/evolving-reliability-platform/)) gets stricter each version. v1 is allowed to be a single process with a README. v13 is not.

| Version | Softened dimensions |
| ------- | ------------------- |
| v1 single app | Observability, Security judged lightly (secrets + basic logs only) |
| v2 Docker | Security: non-root user expected |
| v3–v4 AWS/TF | Security: IAM least privilege starts to matter for real |
| v5+ K8s | Reliability: probes, resources, rollouts required |
| v7+ | Full rubric, no training wheels |

## Module mini-projects

Scored with the same rubric, often with Observability/Security marked N/A (weight rolled into Implementation + Troubleshooting). The project README will say.

## Portfolio rule

Only **passed** projects appear in [`../28-projects/portfolio/README.md`](../28-projects/portfolio/README.md). You may not list a project on a résumé from this journey until it is 🟢.
