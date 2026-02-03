# Git Push with Nix SSH Key

Push to remote using the nix SSH key (via `github-nix` host alias in `~/.ssh/config`).

## Prerequisites

Remote URL must use `github-nix` host alias:
```
git@github-nix:ORG/REPO.git
```

If not configured, use `/git:remote-add:nix` first.

## Execution Steps

1. **Run Push**
   ```bash
   git push "$@"
   ```

2. **Report Result**
   - Show success or failure message
   - If upstream not set, suggest: `git push -u origin <branch>`
