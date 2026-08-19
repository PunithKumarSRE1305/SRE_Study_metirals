# Visual: processes and signals

![Process tree and signals](images/process-and-signals.png)

```text
pid 1  systemd
  ├─ sshd
  │    └─ bash   pid 2201   cwd=/home/you   uid=you
  │         └─ the command you just typed
  └─ your app
       └─ worker threads  (same pid on Linux unless they are processes)
```

A process card always has:

| Field | Why SRE cares |
| ----- | ------------- |
| pid | What you kill, what you `ls /proc/PID` |
| ppid | Who will reap it |
| uid | Permissions |
| cwd | Relative paths, log locations |
| fds | “Too many open files” |
| state | `R` running, `S` sleep, `D` disk, `Z` zombie |

## Signals

```mermaid
flowchart LR
  you[You or systemd] -->|SIGTERM| app[App can clean up]
  you -->|SIGKILL| kernel[Kernel destroys task]
  disk[Dying disk] -->|state D| app
  kernel -.->|kill -9 does nothing| disk
```

Full week resources: [`../resources.md`](../resources.md)
