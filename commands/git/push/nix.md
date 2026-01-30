# Git Push with Nix SSH Key

Push to remote using the nix SSH key (`~/.ssh/nix`).

## Execution Steps

1. **Run Push**
   ```bash
   GIT_SSH_COMMAND="ssh -i ~/.ssh/nix -o IdentitiesOnly=yes" git push "$@"
   ```

2. **Report Result**
   - Show success or failure message
   - If upstream not set, suggest: `git push -u origin <branch>`
