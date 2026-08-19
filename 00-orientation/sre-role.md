# What an SRE actually is

## 1. What is it?

A Site Reliability Engineer makes a service **keep its promises** to users.

Not "the server is up."  
The promise is usually: *fast enough, available enough, correct enough, for enough of the users, at a cost the business can bear.*

SRE is software engineering applied to operations. You write code, design systems, and run them — with reliability as the product.

## 2. Why does the role exist?

Classic operations does not scale when:

- releases happen many times a day
- the system is distributed
- failure is normal, not exceptional
- humans cannot click through runbooks fast enough

SRE exists so reliability is **engineered**, not heroically firefought.

## 3. Why you need this picture now

If you study tools without this picture, you become a person who can recite `kubectl` flags and still freeze at 02:00. Tools are how SREs work. The job is deciding **what to do** when the tools disagree.

## 4. Real-world analogy

A performance tester is the crash-test team.  
An SRE is the team that designs the car so it survives the crash, detects the failure, keeps the passengers alive, and changes the factory so that crash does not happen the same way again.

You already know how to crash the car on purpose.  
You will learn how to keep it on the road.

## 5. What the work looks like

```text
                    ┌──────────────────────────┐
                    │   User-facing promise    │
                    │  (SLO: 99.9% < 300ms)    │
                    └────────────┬─────────────┘
                                 │
          ┌──────────────────────┼──────────────────────┐
          v                      v                      v
   Measure (SLI)          Decide (error budget)    Change the system
   metrics/logs/traces    release / freeze         code, config, capacity
          │                      │                      │
          └──────────► Incident? ──► mitigate ──► postmortem ──► prevent
```

Day-to-day, that becomes:

- watching SLIs, not just CPU graphs
- writing automation that deletes toil
- being on-call with a clear severity model
- capacity planning before the soak test would have failed in production
- saying "no" to a release when the error budget is burned

## 6. What SRE is not

| Not this | Because |
| -------- | ------- |
| "The Linux guy" | Linux is a foundation, not the job |
| "The Kubernetes guy" | K8s is a platform, not reliability |
| "The person who restarts things" | Restarting without understanding is toil and risk |
| "QA in production" | You own the live system, not only its test report |
| "A 24/7 hero" | Heroics are a reliability failure |

## 7. The loop you will live in

```text
1. Define what "good" means          SLO
2. Measure it                        SLI
3. Decide how much failure is OK     error budget
4. Build so the budget is not spent  design + automation
5. Detect when it is being spent     alerting
6. Make it stop spending             incident response
7. Learn so it spends less next time postmortem
8. Repeat
```

You already do a cousin of steps 2 and 4 in performance testing (measure, find the limit). SRE adds ownership of the live promise.

## 8. How this journey trains the role

| Phase | Role muscle |
| ----- | ----------- |
| Foundation | You can see and control a machine |
| Infrastructure | You can build the machine with code |
| Containers / K8s | You can run many machines as one platform |
| Observability | You can see the truth under load |
| SRE / incidents | You can keep a promise during failure |
| Distributed / advanced | You can design for failure on purpose |
| Career | You can explain all of the above in an interview and a war room |

## 9. Knowledge checklist

- [ ] I can explain SRE without naming a tool
- [ ] I can tell SRE apart from "ops who learned Kubernetes"
- [ ] I know why SLOs exist
- [ ] I accept that this journey is 31 months, not a weekend certification
