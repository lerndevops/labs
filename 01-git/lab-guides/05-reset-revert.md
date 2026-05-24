# Git Lab 5: git reset & git revert

## 1. git reset
Moves the current branch to a different commit. Can change your working directory and staging area.

### --soft
- Keeps your changes staged.
- Use when you want to undo commits but keep changes ready to recommit.

**Step-by-step:**
1. Run:
   ```bash
   git reset --soft <commit-hash>
   ```

### --hard
- Discards all changes after the specified commit.
- Use with caution! This will erase uncommitted work.

**Step-by-step:**
1. Run:
   ```bash
   git reset --hard <commit-hash>
   ```

**Explanation:**
- `git reset` is powerful for undoing commits. `--soft` keeps changes, `--hard` erases them.

---

## 2. git revert
Creates a new commit that undoes the changes from a previous commit (safe for shared branches).

**Step-by-step:**
1. Run:
   ```bash
   git revert <commit-hash>
   ```
2. Follow the instructions to complete the commit message.

**Explanation:**
- `git revert` is safer for undoing changes because it doesn’t rewrite history.