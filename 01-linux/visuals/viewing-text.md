# Visual: Viewing text — cat, less, head, tail

Full doc: [`../commands/viewing-text.md`](../commands/viewing-text.md)


```text
app ──write──► app.log inode
                 ▲
                 │ tail -f   (this inode)
rotation ──► new inode, same name
tail -F ──► reopen the name
```

## Walk it

Tools to **read** bytes as text. `cat` dumps everything. `less` pages. `head`/`tail` take a window. `tail -f` follows a growing file — the incident tool.

`tail -f /var/log/myapp/error.log` while you reproduce is the cheapest tracer. `less +G` jumps to the end. `head` confirms format before you `grep` a monster.

## Lab (5 min)

```bash
printf 'line %s\n' $(seq 1 200) > "$HOME/sre-lab/lines.txt"
head -n 5 "$HOME/sre-lab/lines.txt"
tail -n 5 "$HOME/sre-lab/lines.txt"
# less: press q to quit
# less "$HOME/sre-lab/lines.txt"
```

## Check yourself

An app rotated logs at 02:00. Your `tail -f` is silent but the new `app.log` is growing. What flag did you want, and why?
