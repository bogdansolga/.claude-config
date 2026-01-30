# Git Push with WorkWave SSH Key

Push to remote using the workwave SSH key (`~/.ssh/workwave`).

## Execution Steps

1. **Run Push**
   ```bash
   GIT_SSH_COMMAND="ssh -i ~/.ssh/workwave -o IdentitiesOnly=yes" git push "$@"
   ```

2. **Report Result**
   - Show success or failure message
   - If upstream not set, suggest: `git push -u origin <branch>`
