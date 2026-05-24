# Git Lab 06 - Git Merge Conflict Scenario

## Objective

Learn:
- How merge conflicts happen
- How to identify conflicts
- How to resolve conflicts manually
- How to complete merge successfully

---

# What is a Merge Conflict?

A merge conflict happens when:
- two branches modify the same line
- Git cannot decide which change to keep

Git will ask the developer to manually resolve the conflict.

---

# Lab Scenario

We will:
1. Create a repository
2. Create two branches
3. Modify same file differently
4. Merge branches
5. Resolve conflict

---

# Step 1 - Create Repository

```bash
mkdir git-merge-conflict-lab
cd git-merge-conflict-lab
git init
```

---

# Step 2 - Create Initial File

```bash
echo "Application Version 1" > app.txt
```

---

# Step 3 - Add and Commit

```bash
git add .
git commit -m "Initial commit"
```

---

# Step 4 - Create Feature Branch

```bash
git branch feature-login
```

---

# Step 5 - Switch to Feature Branch

```bash
git switch feature-login
```

---

# Step 6 - Modify File in Feature Branch

Replace file content with:

```text
Login Feature Added
```

### Linux / Mac

```bash
echo "Login Feature Added" > app.txt
```

### Windows

```bash
echo Login Feature Added > app.txt
```

---

# Step 7 - Commit Changes in Feature Branch

```bash
git add .
git commit -m "Updated app.txt in feature branch"
```

---

# Step 8 - Switch Back to Main Branch

```bash
git switch master
```

---

# Step 9 - Modify Same File in Main Branch

Replace content with:

```text
Payment Feature Added
```

### Linux / Mac

```bash
echo "Payment Feature Added" > app.txt
```

### Windows

```bash
echo Payment Feature Added > app.txt
```

---

# Step 10 - Commit Changes in Main Branch

```bash
git add .
git commit -m "Updated app.txt in main branch"
```

---

# Step 11 - Merge Feature Branch

```bash
git merge feature-login
```

---

# Expected Output

```bash
CONFLICT (content): Merge conflict in app.txt
Automatic merge failed
```

---

# Step 12 - Check Status

```bash
git status
```

### Expected Output

Git will show:

```bash
both modified: app.txt
```

---

# Step 13 - Open Conflicted File

Open `app.txt`.

You will see:

```text
<<<<<<< HEAD
Payment Feature Added
=======
Login Feature Added
>>>>>>> feature-login
```

---

# Understanding Conflict Markers

| Marker | Meaning |
|---|---|
| <<<<<<< HEAD | Current branch changes |
| ======= | Separator |
| >>>>>>> feature-login | Incoming branch changes |

---

# Step 14 - Resolve Conflict

Edit file manually.

Example final content:

```text
Payment Feature Added
Login Feature Added
```

Remove all conflict markers.

---

# Step 15 - Add Resolved File

```bash
git add app.txt
```

---

# Step 16 - Complete Merge

```bash
git commit -m "Resolved merge conflict"
```

---

# Step 17 - Verify History

```bash
git log --oneline --graph
```

---

# Important Notes

## Avoid Merge Conflicts By:
- pulling latest changes frequently
- communicating with team
- keeping branches short-lived

---

# Quick Summary

| Command | Purpose |
|---|---|
| git merge | Merge branches |
| git status | View conflict status |
| git add | Mark conflict resolved |
| git commit | Complete merge |