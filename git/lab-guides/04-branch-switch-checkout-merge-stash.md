# Git Lab 4: Branching, Switching, Merging, Stashing

## 1. git branch
Lists, creates, or deletes branches.

**Step-by-step:**
1. List branches:
   ```bash
   git branch
   ```
2. Create a new branch:
   ```bash
   git branch <branch-name>
   ```

---

## 2. git switch
Switches to another branch (recommended over `checkout` for switching).

**Step-by-step:**
1. Run:
   ```bash
   git switch <branch-name>
   ```

---

## 3. git checkout
Switches branches or restores files.

**Step-by-step:**
1. Switch branches:
   ```bash
   git checkout <branch-name>
   ```
2. Restore a file:
   ```bash
   git checkout -- <filename>
   ```

---

## 4. git merge
Combines changes from one branch into another.

**Step-by-step:**
1. Switch to the branch you want to merge into:
   ```bash
   git switch main
   ```
2. Run:
   ```bash
   git merge <branch-name>
   ```

---

## 5. git stash
Temporarily saves changes that are not ready to commit.

**Step-by-step:**
1. Run:
   ```bash
   git stash
   ```
2. To reapply stashed changes:
   ```bash
   git stash pop
   ```

**Explanation:**
- These commands help you manage and combine work across different branches and save unfinished work.