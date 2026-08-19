# Failure catalog

Earliest **honest** month is a prerequisite, not a suggestion.

| ID | Failure | Earliest month | Status | Last run |
| -- | ------- | -------------: | ------ | -------- |
| F01 | Kill a process | 1 | ⚪ after W04 | — |
| F02 | Fill a disk (lab VM) | 1–2 | ⚪ | — |
| F03 | Exhaust memory | 2 | ⚪ | — |
| F04 | Exhaust CPU | 2 | ⚪ | — |
| F05 | Break SSH / lockout with recovery | 2 | ⚪ | — |
| F06 | Break DNS | 4 | ⚪ | — |
| F07 | Break a network path | 4 | ⚪ | — |
| F08 | Expire a certificate | 4 / 11 | ⚪ | — |
| F09 | Deploy bad code | 6 / 20 | ⚪ | — |
| F10 | Cause HTTP 500s | 6 | ⚪ | — |
| F11 | Cause HTTP 503s | 6 | ⚪ | — |
| F12 | Kill a container | 12 | ⚪ | — |
| F13 | Kill a pod / CrashLoop | 14 | ⚪ | — |
| F14 | Node disappears | 16 | ⚪ | — |
| F15 | Break DB connectivity | 17 | ⚪ | — |
| F16 | Increase DB latency | 17 / 20 | ⚪ | — |
| F17 | Connection pool exhaustion | 17 / 20 | ⚪ | — |
| F18 | Memory leak (soak) | 20 / 28 | ⚪ | — |
| F19 | Dependency failure | 19+ | ⚪ | — |
| F20 | Simulate AZ failure | 25 / 29 | ⚪ | — |
| F21 | Formal chaos experiment | 29 | ⚪ | — |

## Loop (every row)

1. Detect  
2. Investigate  
3. Hypothesis  
4. Evidence  
5. Mitigate  
6. Recover  
7. Contributing cause  
8. Postmortem  
9. Prevent  

If you only do step 6, the row stays ⚪.

## Safety

Lab VMs. Not work laptops. Not shared accounts. Not production. Disk-fill and fork bombs have a written abort.
