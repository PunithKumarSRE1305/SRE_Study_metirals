# Shell vs terminal vs console

## 1. What is it?

Three different things people call "the command line":

| Word | What it actually is |
| ---- | ------------------- |
| **Terminal** (tty / pty) | A device that moves characters. The window, the SSH session, the serial console. |
| **Shell** | A program that reads those characters, interprets a language, and starts other programs. `bash`, `zsh`, `sh`. |
| **Console** | Historically the physical keyboard+screen. Still used for "the cloud serial console" when SSH is dead. |

## 2. Why does it exist?

Humans type text. Programs want arguments, environment, and a cwd. The terminal handles the first. The shell handles the rest.

## 3. Why do I need to know this as an SRE?

You will SSH into a box (terminal + login shell) and write scripts (non-interactive shell) and debug "it works in my SSH session but not in cron" (different shell, different environment, different cwd, no TTY).

That last sentence is a career's worth of bugs.

## 4. Real-world analogy

The terminal is the telephone line. The shell is the person on the other end who understands English and can send interns (`ls`, `cat`) to do work.

If the line is dead, shouting English does nothing. If the person is gone, the line can still be up (you have a TTY and no useful shell).

## 5. How does it work internally?

```text
Your laptop keyboard
    → SSH client
      → network
        → sshd (on the server)
          → allocates a pty
            → login shell (bash)
              → you type: ls -l
                → bash fork/exec /usr/bin/ls
                  → ls writes bytes to stdout
                    → pty → sshd → your screen
```

Interactive bash reads `~/.bashrc`.  
A non-interactive script usually does **not**.  
A login shell may read `~/.profile` / `~/.bash_profile`.

This is why `$PATH` differs between "I typed it" and "cron ran it."

## 6. Syntax / structure

```bash
echo "$SHELL"     # your login shell, from passwd
echo "$0"         # how *this* shell was invoked
ps -p $$          # $$ is this shell's pid
tty               # which terminal device, or "not a tty"
```

## 7. Basic example

```bash
tty
echo "$SHELL"
ps -p $$ -o pid,comm,args
```

## 8. Step-by-step execution

When you press Enter after `ls`:

1. Terminal sends the line to the shell, including newline.
2. Shell tokenizes: command `ls`, no args.
3. Shell walks `$PATH` looking for an executable named `ls`.
4. Shell `fork`s. Child `execve("/usr/bin/ls", ["ls"], envp)`.
5. Parent shell `wait`s.
6. `ls` writes to file descriptor 1 (the pty).
7. Child exits. Shell prints the next prompt.

If step 3 fails: `command not found`.  
If stdout is redirected (`ls > out`), fd 1 is a file, not the pty.

## 9. Why would I use this?

- Interactive incident work (SSH + bash)
- Scripts (non-interactive bash with a shebang)
- Serial console when the network stack is the incident

## 10. When should I NOT use it?

Do not debug production by pasting 80-line history from an interactive shell with aliases. Aliases are for humans. Scripts should be explicit and boring.

## 11. Alternative ways

| Approach | When |
| -------- | ---- |
| bash | Default on many servers |
| sh / dash | POSIX scripts, faster, fewer features |
| zsh | Nice interactively; do not assume it on servers |
| Python | When the script outgrows bash |
| Cloud serial console | SSH is dead |
| SSM Session Manager | SSH port is closed on purpose |

## 12. Comparison

| Approach | Purpose | Advantages | Disadvantages | When to use |
| -------- | ------- | ---------- | ------------- | ----------- |
| Interactive bash | Humans | History, completion | Hidden env, aliases | Incidents |
| `bash script.sh` | Automation | Repeatable | You must set `-euo pipefail` | Cron, CI |
| Serial console | Break-glass | Independent of sshd | Painful, often one-user | Network/sshd down |

## 13. Common mistakes

- Writing scripts that need a TTY (`read -p`, sudo password prompts) and then running them in CI
- Assuming `~/.bashrc` ran in cron
- Using `csh`/`zsh` features on `/bin/sh`
- Confusing "I have an SSH window" with "I am root"

## 14. Troubleshooting

**Works in SSH, fails in cron:** print `pwd`, `id`, `echo $PATH`, `tty` from both. Diff them. That *is* the ticket.

## 15. Production relevance

A systemd unit with `Type=simple` and a script that calls `cd` and relies on an alias from `.bashrc` will fail after the first reboot. The interactive session hid the bug for months.

## 16. Security considerations

Interactive shells load files from the home directory. A writable `~/.bashrc` is persistence for an attacker. Never put secrets in prompt hooks. `script` / terminal loggers capture passwords if you type them — do not type them.

## 17. Performance considerations

The shell is rarely the bottleneck. `bash` in a tight loop is. For hot loops, use the right tool. For one-off incident for-loops over 50 hosts, bash is fine.

## 18. Related concepts

```text
terminal → shell → cwd → environment variables → PATH → process
                 ↓
               scripts → exit codes → cron / systemd
```

## 19. Visual diagram

```text
[ Terminal / pty ]  ← characters →  [ bash ]
                                       |
                                       | fork/exec
                                       v
                                    [ ls ]
                                       |
                                       +--> stdout --> pty --> your eyes
```

## 20. Hands-on exercise

```bash
tty
echo "$SHELL"
echo "$0"
ps -p $$
bash -c 'echo inner=$0; tty'
```

## 21. Mini challenge

Why is `cd` a shell builtin and `ls` usually an external program? What would break if `cd` were `/usr/bin/cd`?

## 22. Interview questions

- **Beginner:** Shell vs terminal?
- **Intermediate:** Login vs interactive vs script — which files are read?
- **Advanced:** How does SSH forwarding a PTY change program behavior (`ls` colors, progress bars, `systemctl` pagers)?

## 23. SRE scenario

"The deploy script works on my laptop SSH but fails in GitHub Actions." There is no TTY, `set -e` is off on your laptop because you forgot, and `docker` asked for a pager. The pipeline is telling the truth.

## 24. Summary

The terminal moves characters. The shell understands a language and starts processes. Cron has neither your cwd nor your aliases. Write accordingly.

## 25. Knowledge checklist

- [ ] I understand what this is
- [ ] I understand why it exists
- [ ] I can explain it
- [ ] I can use it
- [ ] I can troubleshoot it
- [ ] I can explain its alternatives
- [ ] I can apply it in production
- [ ] I can answer interview questions
