# Git Lab 00: Installing Git on Windows and Mac

Before you can use Git commands, you need to have Git installed on your computer.

## How to Install Git

### Windows
1. Go to [https://git-scm.com/](https://git-scm.com/)
2. Click **Download for Windows**.
3. Run the downloaded installer.
4. Follow the setup instructions (default options are fine for most users).
5. After installation, open **Command Prompt** or **PowerShell** and type:
   ```bash
   git --version
   ```
   You should see the installed Git version.

### Mac
1. Open **Terminal** (find it in Applications > Utilities).
2. Type:
   ```bash
   git --version
   ```
   - If Git is already installed, you will see the version number.
   - If not, you will be prompted to install the **Xcode Command Line Tools**. Click **Install** and follow the instructions.
3. Alternatively, you can install Git using [Homebrew](https://brew.sh/):
   ```bash
   brew install git
   ```

## Tips
- After installing, you can use Git from the terminal or command prompt.
- You only need to install Git once per computer.

---

Now you are ready to start using Git commands!