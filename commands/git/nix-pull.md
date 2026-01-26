# Git Pull with Nix SSH Key

Pull from remote using the nix SSH key (~/.ssh/nix).

## Execution Steps

1. **Run Pull**
   ```bash
   GIT_SSH_COMMAND="ssh -i ~/.ssh/nix -o IdentitiesOnly=yes" git pull "$@"
   ```

2. **Report Result**
   - Show updated files or "Already up to date"
   - Handle merge conflicts if any
