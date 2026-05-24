# Git Lab 1: git init & git clone

## 1. git init
Initializes a new Git repository in your current directory.

**Step-by-step:**
1. Open your terminal and navigate to your project folder.
2. Run:
   ```bash
   git init
   ```
3. You will see a `.git` folder created. This means your folder is now tracked by Git.

**Explanation:**
- `git init` sets up all the necessary files and folders for Git to start tracking changes in your project.

---

## 2. Creating a New Repository on GitHub.com
Create a new remote repository on GitHub before cloning it to your local machine.

**Step-by-step:**
1. Go to [https://github.com](https://github.com) and log in.
2. Click the **+** icon (top right) and select **New repository**.
3. Enter a repository name (e.g., `my-first-repo`).
4. (Optional) Add a description, choose public/private, and **do NOT** initialize with a README (for this lab).
5. Click **Create repository**.
6. On the next page, copy the repository URL (e.g., `https://github.com/your-username/my-first-repo.git`).

---

## 3. git clone
Copies an existing Git repository (from GitHub or elsewhere) to your computer.

**Step-by-step:**
1. Use the repository URL you copied from GitHub.
2. Run:
   ```bash
   git clone <repository-url>
   ```
   Example:
   ```bash
   git clone https://github.com/your-username/my-first-repo.git
   ```
3. A new folder with the repository’s name will be created, containing all files and history.

**Explanation:**
- `git clone` downloads the entire repository, including all files and commit history, to your local machine.