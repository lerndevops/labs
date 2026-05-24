# Git Lab 3: git add, git commit, git status, git log, git show

## 1. git add
Stages changes (new or modified files) for the next commit.

**Step-by-step:**
1. Make changes to your files.
2. Run:
   ```bash
   git add <filename>
   ```
   Or to add all changes:
   ```bash
   git add .
   ```

**Explanation:**
- `git add` tells Git which changes you want to include in your next commit.

---

## 2. git commit
Saves your staged changes to the repository history.

**Step-by-step:**
1. After adding files, run:
   ```bash
   git commit -m "Your commit message"
   ```

**Explanation:**
- `git commit` creates a snapshot of your staged changes.

---

## 3. git status
Shows the current state of your working directory and staging area.

**Step-by-step:**
1. Run:
   ```bash
   git status
   ```

**Explanation:**
- `git status` helps you see which files are staged, unstaged, or untracked.

---

## 4. git log
Shows the commit history.

**Step-by-step:**
1. Run:
   ```bash
   git log
   ```

**Explanation:**
- `git log` lists all previous commits with details.

---

## 5. git show
Displays detailed information about a specific commit.

**Step-by-step:**
1. Find a commit hash (from `git log`).
2. Run:
   ```bash
   git show <commit-hash>
   ```

**Explanation:**
- `git show` displays the changes and details for a specific commit.