# Git Lab 6: Remotes, Push, Fetch, Pull

## 1. git remote
Manages connections to remote repositories (like GitHub).

**Step-by-step:**
1. List remotes:
   ```bash
   git remote -v
   ```
2. Add a remote:
   ```bash
   git remote add origin <url>
   ```

---

## 2. git push
Uploads your commits to a remote repository.

**Step-by-step:**
1. Run:
   ```bash
   git push origin <branch-name>
   ```

---

## 3. git fetch
Downloads new data from a remote repository (does not change your working files).

**Step-by-step:**
1. Run:
   ```bash
   git fetch
   ```

---

## 4. git pull
Downloads and merges changes from a remote repository into your current branch.

**Step-by-step:**
1. Run:
   ```bash
   git pull
   ```

**Explanation:**
- These commands help you work with remote repositories and keep your local copy up to date.