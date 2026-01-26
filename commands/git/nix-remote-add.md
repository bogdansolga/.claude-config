# Add Git Remote with Nix SSH Key

Add a remote origin and configure the repo to use the nix SSH key (~/.ssh/nix).

## Execution Steps

1. **Add Remote**
   ```bash
   git remote add origin <url>
   ```

2. **Configure SSH Key for Repo**
   ```bash
   git config core.sshCommand "ssh -i ~/.ssh/nix -o IdentitiesOnly=yes"
   ```

3. **Verify**
   ```bash
   git remote -v
   ```

4. **Report Result**
   - Show configured remotes
   - Confirm SSH key is set for this repo
