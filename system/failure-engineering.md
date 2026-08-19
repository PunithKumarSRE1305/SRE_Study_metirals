# Failure engineering

SRE is learned by breaking systems **on purpose**, in a box you can afford to break.

## The mandatory loop

For every planned failure:

```text
1. Detect          How would I know without being told?
2. Investigate     What do I look at first, second, third?
3. Hypothesis      One sentence, falsifiable
4. Evidence        Metric, log line, trace, or command output
5. Mitigate        Stop the bleeding (not "root cause")
6. Recover         Return to a known good
7. Contributing cause   Not "human error"
8. Postmortem      Blameless, using the template
9. Prevent         A concrete change: test, alert, quota, code, doc
```

If you only do step 6 ("restart it"), the exercise failed.

## Catalog (used across the 31 months)

| Failure | Earliest honest month | Why that late |
| ------- | --------------------: | ------------- |
| Kill a process | 1 | Linux processes |
| Fill disk | 1–2 | Filesystem + logs |
| Exhaust memory / CPU | 2 | You need to *see* it |
| Break SSH / lock yourself out (lab VM) | 2 | With a recovery path |
| Break DNS | 4 | After DNS week |
| Break network path | 4 | After routing/TCP |
| Expire a certificate | 4 / 11 | After TLS, again after security |
| Deploy bad code | 6 / 20 | After you have a deploy |
| HTTP 500 / 503 generation | 6 | After you own an app |
| Kill a container | 12 | Docker |
| Kill a pod / crashloop | 14 | Kubernetes |
| Node disappear | 16 | K8s scheduling |
| Break DB connectivity | 17 | Databases module |
| Increase DB latency | 17 / 20 | Perf + DB |
| Connection pool exhaustion | 17 / 20 | You already know this from PT |
| Memory leak (soak) | 20 / 28 | Your home turf |
| Dependency failure | 19+ | After you have dependencies |
| AZ failure (simulated) | 25 / 29 | After AWS + HA |
| Chaos experiment formal | 29 | After incident process exists |

The living catalog is [`../29-incident-simulations/catalog/README.md`](../29-incident-simulations/catalog/README.md).

## Safety

- Never run failure drills against shared work environments
- Never attack a system you do not own
- Disk-fill and fork-bombs only inside a disposable VM
- Network breaks only on lab networks
- Production-like accounts get a written rollback *before* the experiment

## Postmortem required

Template: [`templates/postmortem.md`](templates/postmortem.md)

A simulation without a postmortem is just vandalism with extra steps.
