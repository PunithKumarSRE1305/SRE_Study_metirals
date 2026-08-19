# Visual: Disk full vs inode full

Full doc: [`../disk/disk-and-inodes.md`](../disk/disk-and-inodes.md)


```text
df -h 100%  → bytes on that mount
df -i 100%  → no inodes left
du << df    → deleted-open or hidden under a mount
```

## Walk it

A filesystem can run out of **bytes** (`df -h`) or **inodes** (`df -i`) independently. Millions of tiny files exhaust inodes while `df -h` looks fine. `du` walks names; `df` asks the filesystem — they disagree when files are deleted but open, or when a mount hides a full directory.

**SRE why:** Always run both `df -h` and `df -i`. Then `du -x` on the guilty mount. Then look for deleted-open files.

## 5-minute lab

```bash
df -h; df -i
du -xh --max-depth=1 "$HOME" 2>/dev/null | sort -h | tail
```

## Check yourself

df -h / 38%, df -h /var 100%, df -i /var 100%. What is full? What do you not delete first?
