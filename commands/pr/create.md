---
command: pr:create
description: Generate succinct PR summary and create pull request
---

## Description

Analyzes changes between the current branch and master, generates a succinct PR summary, and creates a pull request with that summary.

## Execution Steps

1. **Analyze Branch Changes**
   - Run `git status` to verify current branch
   - Run `git log master..HEAD --oneline` to see commits
   - Run `git diff master...HEAD --stat` to see changed files
   - Run `git diff master...HEAD` to analyze actual changes

2. **Generate PR Summary**
   - Identify the main theme/purpose of changes
   - Group related changes together
   - Highlight security improvements, bug fixes, new features, or enhancements
   - List files changed with brief descriptions
   - Keep summary concise (3-5 bullet points for main changes)

3. **Verify Branch Status**
   - Check if current branch tracks a remote
   - Verify if branch is up to date with remote
   - Push to remote with `-u` flag if needed

4. **Create Pull Request**
   - Use `gh pr create` with generated summary
   - Format body with:
     - Brief overview paragraph
     - **Key Changes:** bullet points
     - **Files Changed:** list
     - **Testing:** if applicable
   - Set base branch to `master`
   - Use HEREDOC for proper formatting

5. **Output PR URL**
   - Display the created PR URL
   - Show PR number and title

## PR Body Format

```markdown
{Brief overview of what this PR does and why}

**Key Changes:**
- {Change 1}
- {Change 2}
- {Change 3}

**Files Changed:**
- `file1` - {description}
- `file2` - {description}

**Testing:**
- {How to test, if applicable}
```

## Example Output

```markdown
Branch: docker-build-improvements
Base: master
Commits: 6
Files changed: 2

✅ PR created: https://github.com/user/repo/pull/123

PR #123: Docker Build Security & Workflow Improvements
```

## Notes

- The command will fail if not in a git repository
- Requires `gh` CLI to be installed and authenticated
- Will prompt for manual input if PR title is ambiguous
- Always includes Claude Code footer in PR description
