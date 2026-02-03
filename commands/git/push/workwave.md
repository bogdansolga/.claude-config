# Git Push with WorkWave SSH Key

Push to remote using the workwave SSH key (via `github-workwave` host alias in `~/.ssh/config`).

## Prerequisites

Remote URL must use `github-workwave` host alias:
```
git@github-workwave:ORG/REPO.git
```

If not configured, use `/git:remote-add:workwave` first.

## Execution Steps

1. **Run Push**
   ```bash
   git push "$@"
   ```

2. **Report Result**
   - Show success or failure message
   - If upstream not set, suggest: `git push -u origin <branch>`
