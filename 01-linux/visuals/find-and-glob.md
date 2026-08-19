# Visual: find, globs, and locating files

Full doc: [`../commands/find-and-glob.md`](../commands/find-and-glob.md)


```text
*.log     →  shell, this directory only
find /var -name '*.log'
          →  walk /var, test each name, print matches
```

## Walk it

A **glob** (`*.log`) is expanded by the **shell** into a list of names **in the current directory** (unless you write `**` with `globstar`). **`find`** walks a tree and asks the kernel about each name. They are not the same tool.

'Where is the 40 GB file?' `find /var -xdev -type f -size +1G` is a first move. A glob `*` in a directory with 2 million names can explode your argv and fail with 'argument list too long'.

## Lab (5 min)

```bash
mkdir -p "$HOME/sre-lab/find/nested"
touch "$HOME/sre-lab/find/a.log" "$HOME/sre-lab/find/nested/b.log"
printf '%s\n' *.log   # from $HOME/sre-lab/find — see glob vs find
cd "$HOME/sre-lab/find" && printf 'glob: '; printf '%s ' *.log; echo
find "$HOME/sre-lab/find" -name '*.log'
```

## Check yourself

Write a `find` that lists files over 100 MB under `/var` without descending into other mounts. Do not delete anything.
