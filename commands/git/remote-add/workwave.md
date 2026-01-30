# Add Git Remote with WorkWave SSH Key

Add a remote origin and configure the repo to use the workwave SSH key (`~/.ssh/workwave`).

## Arguments

- `$ARGUMENTS` - Remote URL (e.g., `git@github.com:user/repo.git`)

## Execution Steps

1. **Add Remote**
   ```bash
   git remote add origin <url>
   ```

2. **Configure SSH Key for Repo**
   ```bash
   git config core.sshCommand "ssh -i ~/.ssh/workwave -o IdentitiesOnly=yes"
   ```

3. **Verify**
   ```bash
   git remote -v
   ```

4. **Report Result**
   - Show configured remotes
   - Confirm SSH key is set for this repo
