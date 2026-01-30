# Git Pull with WorkWave SSH Key

Pull from remote using the workwave SSH key (`~/.ssh/workwave`).

## Execution Steps

1. **Run Pull**
   ```bash
   GIT_SSH_COMMAND="ssh -i ~/.ssh/workwave -o IdentitiesOnly=yes" git pull "$@"
   ```

2. **Report Result**
   - Show updated files or "Already up to date"
   - Handle merge conflicts if any
