# Add Git Remote with WorkWave SSH Key

Add a remote origin using the `github-workwave` host alias (configured in `~/.ssh/config` to use `~/.ssh/workwave` key).

## Arguments

- `$ARGUMENTS` - Remote URL (e.g., `git@github.com:user/repo.git`)

## Execution Steps

1. **Transform URL to Use Host Alias**
   - Convert `git@github.com:ORG/REPO.git` → `git@github-workwave:ORG/REPO.git`

2. **Add Remote**
   ```bash
   git remote add origin git@github-workwave:ORG/REPO.git
   ```

   If origin already exists, update it:
   ```bash
   git remote set-url origin git@github-workwave:ORG/REPO.git
   ```

3. **Verify**
   ```bash
   git remote -v
   ```

4. **Report Result**
   - Show configured remotes
   - Confirm URL uses `github-workwave` alias
