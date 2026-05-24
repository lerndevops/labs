# Git Lab 8: Configuring Git Username and Email

Before making commits, it’s important to set your name and email in Git. This information is recorded in every commit you make.

## Why Set Username and Email?
- Identifies who made each commit.
- Required for pushing to remote repositories.

## Step-by-step: Set Username and Email

1. **Open your terminal or command prompt.**

2. **Set your username:**
   ```bash
   git config --global user.name "Your Name"
   ```
   Example:
   ```bash
   git config --global user.name "Alice Smith"
   ```

3. **Set your email:**
   ```bash
   git config --global user.email "your.email@example.com"
   ```
   Example:
   ```bash
   git config --global user.email "alice@example.com"
   ```

4. **Verify your settings:**
   ```bash
   git config --global --list
   ```
   You should see your name and email listed.

## Tips
- Use the `--global` flag to set these for all repositories on your computer.
- You can set different values per repository by omitting `--global` and running the commands inside a specific project folder.
- Make sure to use the same email as your GitHub account for proper attribution.

---

Now your commits will be properly identified with your name and email!