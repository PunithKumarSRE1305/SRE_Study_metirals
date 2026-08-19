# find, globs, and locating files

**Week:** W02 · **Visual:** [`../visuals/find-and-glob.md`](../visuals/find-and-glob.md) · **Resources:** [`../resources/ALL-CONCEPTS.md`](../resources/ALL-CONCEPTS.md)

## 1. What is it?

A **glob** (`*.log`) is expanded by the **shell** into a list of names **in the current directory** (unless you write `**` with `globstar`). **`find`** walks a tree and asks the kernel about each name. They are not the same tool.

## 2. Why does it exist?

You often do not know the exact path. You know a pattern, a name, a size, or an age. The shell cannot recurse unless you tell it to. `find` can.

## 3. Why do I need to know this as an SRE?

'Where is the 40 GB file?' `find /var -xdev -type f -size +1G` is a first move. A glob `*` in a directory with 2 million names can explode your argv and fail with 'argument list too long'.

## 4. Real-world analogy

A glob is shouting a nickname in one room. `find` is walking the building with a clipboard.

## 5. How does it work internally?

Unquoted `*.log` is expanded **before** `ls`/`rm` runs. If nothing matches, bash (by default) passes the literal `*.log`. `find PATH EXPR` does `open`/`getdents`/`stat` recursively. `-xdev` refuses to cross mounts — critical on a full-disk ticket so you do not scan NFS.

## 6. Syntax / structure

```bash
ls *.log                 # shell glob, this directory
find /var/log -name '*.log' -mtime -1
find /var -xdev -type f -size +500M
```

## 7. Basic example

```bash
mkdir -p "$HOME/sre-lab/find/a"
touch "$HOME/sre-lab/find/a/one.log" "$HOME/sre-lab/find/skip.txt"
find "$HOME/sre-lab/find" -name '*.log'
```

## 8. Step-by-step execution

1. For a glob: shell reads the directory, builds argv, then starts the command.
2. For `find`: `find` itself walks, applying tests (`-name`, `-type`, `-size`, `-mtime`).
3. Actions (`-print`, `-delete`, `-exec`) run per match.
4. `-delete` is implied-depth; know what you match before you delete.

## 9. Why would I use this?

Hunt large files. Find configs named `*.yml`. Find files older than N days for cleanup **in a lab first**.

## 10. When should I NOT use it?

Do not `find / -name` on a production host as your first command (it will hammer every mount). Do not `-delete` without a dry-run print.

## 11. Alternative ways

`locate`/`plocate` use a database (fast, stale). `grep -R` searches *contents*. `ls` is not a search tool.

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| glob `*.log` | names in one dir | fast | no recurse, argv limits | interactive |
| `find` | walk + predicates | precise | can be heavy | unknown path |
| `plocate` | indexed | instant | not live | dev boxes |
| `du -ah | sort -h` | size ranking | simple | slow on big trees | first look at a mount |

## 13. Common mistakes

- Unquoted `*` passed to `find -name` (shell expands first)
- `find /` without `-xdev` during an incident
- `-delete` on a wrong predicate
- Parsing `ls` instead of `find`

## 14. Troubleshooting

**Argument list too long:** the glob exploded. Use `find … -exec` or `find … -print0 | xargs -0`. **Permission denied** noise: `2>/dev/null` only after you understand you are skipping dirs.

## 15. Production relevance

A host with a million files in `/var/spool` will make naive `find /var` look like a hang. Scope the path. Nice the process (`nice -n 19`).

## 16. Security considerations

`find /home -name '*.pem'` is a secrets hunt. Do not run it casually on shared boxes. `-exec rm` is code execution on every match.

## 17. Performance considerations

Each `stat` is a syscall. On network filesystems this is an outage-shaped load test. Limit depth and stay on one mount.

## 18. Related concepts

```text
shell expansion → paths → inodes → df → permissions
```

## 19. Visual diagram

```text
*.log     →  shell, this directory only
find /var -name '*.log'
          →  walk /var, test each name, print matches
```

## 20. Hands-on exercise

```bash
mkdir -p "$HOME/sre-lab/find/nested"
touch "$HOME/sre-lab/find/a.log" "$HOME/sre-lab/find/nested/b.log"
printf '%s\n' *.log   # from $HOME/sre-lab/find — see glob vs find
cd "$HOME/sre-lab/find" && printf 'glob: '; printf '%s ' *.log; echo
find "$HOME/sre-lab/find" -name '*.log'
```

Log the output (redacted) in `progress/daily-logs/`.

## 21. Mini challenge

Write a `find` that lists files over 100 MB under `/var` without descending into other mounts. Do not delete anything.

Do not look up the answer in this file. Write yours first.

## 22. Interview questions

- **Beginner:** Who expands `*.txt`?
- **Intermediate:** Why quote `'*.txt'` for find -name?
- **Advanced:** How do you find large files without melting NFS?

## 23. SRE scenario

`/` is filling. You `find / -size +1G` and accidentally crawl a dead NFS mount. `ls` hangs. Next time you start with `df -h` and `find /var -xdev`.

## 24. Summary

Globs are shell, one directory. `find` walks. Quote patterns. Scope the tree. Print before delete.

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

- Here is what you already know from performance testing: You already filter result files by name after a test run.
- Here is the SRE equivalent: `find` is that filter against a live filesystem.
- Here is what you need to learn next: `grep` contents; later log pipelines.
