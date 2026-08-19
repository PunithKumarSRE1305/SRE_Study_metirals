# Visual: a request is layers

```text
You / JMeter
    │  HTTP GET /checkout
    v
┌──────────── Application ────────────┐
│  HTTP method, path, status          │
└────────────────┬────────────────────┘
                 │ inside
┌──────────── Transport ──────────────┐
│  TCP ports, handshake, resets       │
└────────────────┬────────────────────┘
                 │ inside
┌──────────── Internet ───────────────┐
│  IP addresses, routing              │
└────────────────┬────────────────────┘
                 │ inside
┌──────────── Link ───────────────────┐
│  MAC, Ethernet, local segment       │
└─────────────────────────────────────┘
```

```mermaid
flowchart TB
  subgraph errors [What JMeter already told you]
    dns[UnknownHost]
    ref[Connection refused]
    to[Timeout]
    tls[Handshake fail]
    http[HTTP 5xx]
  end
  dns --> DNS[DNS]
  ref --> TCP[Nothing listening]
  to --> PATH[Drop / filter / stuck]
  tls --> CERT[Cert / SNI / clock]
  http --> APP[App or upstream]
```

**Do not say “the site is down.” Say which layer died.**

Resources (including free Cisco badge): [`../resources.md`](../resources.md)
