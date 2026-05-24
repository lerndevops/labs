# Git Lab 7: Understanding Git Workflows

Git workflows define how teams use Git to collaborate and manage code changes. Here are some common workflows with simple explanations:

## 1. Centralized Workflow
- Everyone works on a single branch (usually `main` or `master`).
- Simple, but not ideal for larger teams.

**Steps:**
1. Clone the central repository.
2. Make changes and commit locally.
3. Push changes to the central branch.

---

## 2. Feature Branch Workflow
- Each new feature or bugfix is developed in its own branch.
- Keeps the main branch stable.

**Steps:**
1. Create a new branch for your feature:
   ```bash
   git checkout -b feature/my-feature
   ```
2. Work on your changes and commit them.
3. Push your branch to the remote:
   ```bash
   git push origin feature/my-feature
   ```
4. Open a pull request (PR) to merge your branch into `main`.

---

## 3. Fork & Pull Request Workflow (Open Source)
- Common for open source projects.
- Contributors fork the main repository, make changes, and submit pull requests.

**Steps:**
1. Fork the repository on GitHub.
2. Clone your fork locally.
3. Create a branch, make changes, and push to your fork.
4. Open a pull request to the original repository.

---

## 4. Gitflow Workflow
- Uses specific branch types: `main`, `develop`, `feature/*`, `release/*`, `hotfix/*`.
- Good for projects with scheduled releases.

**Basic Steps:**
1. New features go into `feature/*` branches off `develop`.
2. Releases are prepared in `release/*` branches.
3. Hotfixes are made in `hotfix/*` branches off `main`.
4. Merges happen between these branches as needed.

---

## Summary Table
| Workflow                | Best For                |
|-------------------------|-------------------------|
| Centralized             | Small teams, simple use |
| Feature Branch          | Most teams, stability   |
| Fork & Pull Request     | Open source projects    |
| Gitflow                 | Large projects, releases|

---

Choose the workflow that best fits your team's size and project needs!