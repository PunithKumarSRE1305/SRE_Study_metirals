# Week 03 — visual explainers

Dedicated page + image: [permissions.md](permissions.md)

**Theme:** Users, groups, permissions

Diagram-first. Full 25-section docs are written when the week opens.

## Concept 1: Users and groups

`uid`/`gid` are numbers. Names are a convenience in `/etc/passwd`.

## Concept 2: Permission triads `rwx`

Three classes: user, group, other.

## Concept 3: Octal `chmod`

4+2+1. `750` is a decision, not a spell.

## Concept 4: Directory `x` vs `r`

`cd` needs `x`. `ls` needs `r`. They are different.

## Concept 5: `sudo` vs logging in as root

Least privilege. Root login is a last resort.


## Concept: how the kernel picks a triad

```text
process uid=1001  groups=1001,27
file: owner 1001  group 27  mode rw-r-----   (640)

uid matches owner? YES → use USER triad (rw-)
(if not, gid in file group? → GROUP triad)
(else OTHER)
```

Image: [permission-bits.png](images/permission-bits.png)

**Never do this:** `chmod -R 777 /var/log` to “make the app work.” That is an incident you caused.


## Performance-testing bridge

Whatever this week names (files, perms, CPU, disk, packets) is something you already *saw from the outside* in a load test. The picture here is how that number is born.

## Check yourself

Close the page. Redraw one diagram from memory. If you cannot, you watched, you did not learn.
