# Visual: Editors enough to survive — nano and vi

Full doc: [`../commands/editors.md`](../commands/editors.md)


```text
disk file ──open──► editor buffer ──save──► disk file
                     │
                     └── abandon (:q!) ──► disk unchanged
```

## Walk it

An **editor** changes a file in place on the box. `nano` is guided. `vi`/`vim` is everywhere — including rescue environments. You need enough `vi` to change one line and exit without panic.

You will edit a unit, a sudoers snippet (via `visudo`), a nginx config, a crontab. Doing it wrong without a backup is a second incident.

## Lab (5 min)

```bash
# Survive vi in 5 minutes
printf 'old\n' > "$HOME/sre-lab/vi-practice.txt"
# Open with vi, press i, change to new, Esc, :wq
vi "$HOME/sre-lab/vi-practice.txt"
cat "$HOME/sre-lab/vi-practice.txt"
```

## Check yourself

You opened `/etc/hosts` with `vi` as yourself and cannot save. How do you keep the buffer and still write the file safely?
