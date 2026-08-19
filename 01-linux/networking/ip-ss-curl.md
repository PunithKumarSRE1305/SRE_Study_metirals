# This host's network — ip, ss, curl

**Week:** W07-W11 · **Visual:** [`../visuals/ip-ss-curl.md`](../visuals/ip-ss-curl.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

**`ip`** shows addresses and routes. **`ss`** shows sockets (who listens, who is connected). **`curl`** speaks HTTP(S) and shows the handshake. Together they are the Linux-side of 'is it DNS, TCP, TLS, or HTTP?'

## 2. Why does it exist?

JMeter 'connection refused' is a layer. These commands name it on the box.

## 3. Why do I need to know this as an SRE?

Before you blame the app: `ss -lptn` (is it listening?), `ip route` (is there a path?), `curl -v` (where does it die?).

## 4. Real-world analogy

Address book (`ip`), who is on the phone (`ss`), and placing a test call (`curl`).

## 5. How does it work internally?

The kernel net stack owns interfaces and the routing table. Listening sockets are bound tuples. `ss` reads them via netlink. `curl` is a user-space HTTP client: DNS → TCP → TLS → HTTP.

## 6. Syntax / structure

```bash
ip addr; ip route
ss -lptn
ss -tpn | head
curl -sv --max-time 5 http://127.0.0.1:8080/health
```

## 7. Basic example

```bash
ip -br addr
ss -lptn | head
curl -sI --max-time 5 https://example.com | head
```

## 8. Step-by-step execution

1. Addresses and default route.
2. Listening ports vs the port you think.
3. curl -v and stop at the first failing layer.
4. Only then tcpdump (later).

## 9. Why would I use this?

Local repro of connection refused, timeout, TLS errors, 5xx.

## 10. When should I NOT use it?

Do not curl production in a tight loop as a load test. Do not ss -a on a host with a million conns without a filter.

## 11. Alternative ways

`netstat` is the old name. Prefer `ss`. `dig`/`getent hosts` for DNS (Month 4).

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| ip | addr/route | modern | verbose | first |
| ss | sockets | fast | busy output | first |
| curl -v | application probe | sees TLS/HTTP | not a load test | first |
| JMeter | load | your strength | too heavy for 'is it up' | after curl works |

## 13. Common mistakes

- ping succeeds so 'network is fine' (ICMP ≠ TCP 443)
- curling the wrong interface
- ignoring HTTPS intercept/MITM middleboxes

## 14. Troubleshooting

**refused:** nothing listening or a RST. **timeout:** drop/filter/blackhole/stuck. **Could not resolve:** DNS. **TLS:** cert, SNI, clock.

## 15. Production relevance

ALB 5xx + instance listening on 8080 but health check on 80 is this page.

## 16. Security considerations

curl to internal metadata IPs can leak cloud credentials. ss shows process names — useful and sensitive.

## 17. Performance considerations

curl is a probe. JMeter is a test. Do not confuse them.

## 18. Related concepts

```text
layers → DNS → TCP → TLS → HTTP → later VPC
```

## 19. Visual diagram

```text
curl -v URL
  DNS  →  TCP connect  →  TLS  →  HTTP
           ▲
           ss -lptn  (is anything bound?)
```

## 20. Hands-on exercise

```bash
ip -br addr
ip route | head
ss -lptn | head
curl -sv --max-time 5 https://example.com -o /dev/null
```

Log evidence in `progress/daily-logs/`.

## 21. Mini challenge

ss shows nginx on 127.0.0.1:80 only. The ALB health check fails from the subnet. What is wrong?

Write your answer before you look anything up.

## 22. Interview questions

- **Beginner:** ip vs ss vs curl?
- **Intermediate:** Connection refused vs timeout?
- **Advanced:** Why ping is not enough?

## 23. SRE scenario

Health checks fail. ss: app on 127.0.0.1:8080. You bind 0.0.0.0, restart, checks green. Then you put it in the unit file.

## 24. Summary

ip = identity and path. ss = sockets. curl = the conversation. Name the layer.

## 25. Knowledge checklist

- [ ] I understand what this is
- [ ] I understand why it exists
- [ ] I can explain it
- [ ] I can use it
- [ ] I can troubleshoot it
- [ ] I can explain its alternatives
- [ ] I can apply it in production
- [ ] I can answer interview questions

### Performance-testing bridge

- Here is what you already know from performance testing: JMeter errors you already sort by type.
- Here is the SRE equivalent: These three commands map each type onto the host.
- Here is what you need to learn next: Full networking module (Month 3–4).
