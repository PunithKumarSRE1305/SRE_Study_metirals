# Visual: Files and directories — create, copy, move, remove

Full doc: [`../filesystem/files-and-directories.md`](../filesystem/files-and-directories.md)


```text
cp   name1 → inode A     plus new name2 → inode B (new bytes)
mv   name1 → inode A     becomes name2 → inode A
rm   name1 gone          inode A lives if any fd is open
```

## Walk it

A **file** is bytes plus an inode. A **directory** is a list of names → inode numbers. `touch`/`mkdir` create names. `cp` copies bytes into a new inode. `mv` usually only changes a name. `rm` removes a name (unlink). It does not securely erase, and it does not always free disk.

The classic 02:00 ticket: 'I deleted the 40 GB log and `df` is still 100%.' If you think `rm` always frees space, you will reboot instead of finding the open file descriptor.

## Lab (5 min)

```bash
LAB=$HOME/sre-lab/files
mkdir -p "$LAB"
echo data > "$LAB/keep.txt"
cp -a "$LAB/keep.txt" "$LAB/copy.txt"
ls -li "$LAB"
# open-but-deleted demo
exec 3> "$LAB/open.log"
echo hello >&3
rm "$LAB/open.log"
ls "$LAB"
ls -l /proc/$$/fd/3
echo still >&3
exec 3>&-
```

## Check yourself

You `rm` a 20 GB `app.log`. `du` dropped. `df` did not. What is still holding the inode, and what is the *smallest* safe action?
