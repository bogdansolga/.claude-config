---
command: pr:review-local
description: Perform succinct, actionable code review on committed and staged changes from current branch
---

## Description

Reviews all changes in the current branch (both committed and staged) against the base branch, providing succinct and actionable feedback focused on code quality, potential issues, and adherence to project standards.

## Execution Steps

1. **Gather Branch Context**
   - Run `git rev-parse --abbrev-ref HEAD` to get current branch
   - Run `git log master..HEAD --oneline` to see commits (use main if master doesn't exist)
   - Run `git diff master...HEAD --stat` to see changed files summary
   - Run `git diff --staged --stat` to see staged changes

2. **Review Committed Changes**
   - Run `git diff master...HEAD` to get full diff of committed changes
   - Analyze changes focusing on:
     - Code quality and readability
     - Potential bugs or logic errors
     - TypeScript type safety
     - Security concerns (SQL injection, XSS, authentication issues)
     - Performance implications
     - Test coverage gaps
     - Adherence to project conventions (check CLAUDE.md if exists)

3. **Review Staged Changes**
   - Run `git diff --staged` to get staged changes
   - Apply same review criteria as committed changes

4. **Check Project Standards**
   - Verify alignment with:
     - Project conventions (CLAUDE.md if exists)
     - Security requirements (no credentials in code)
   - Check if pre-commit hooks would pass (lint, types)

5. **Generate Succinct Review**
   - Group findings by severity: 🔴 Critical, 🟡 Important, 🟢 Minor
   - Focus on actionable items only
   - Skip trivial style issues already caught by linters
   - Limit to top 5-7 most important findings
   - For each finding provide:
     - File and line reference
     - Specific issue
     - Concrete fix recommendation

## Output Format

```markdown
## Code Review: {branch-name}

### Summary
{1-2 sentence overview of changes and general assessment}

### Findings

#### 🔴 Critical Issues
- **{file}:{line}** - {issue}: {actionable fix}

#### 🟡 Important Issues
- **{file}:{line}** - {issue}: {actionable fix}

#### 🟢 Minor Suggestions
- **{file}:{line}** - {issue}: {actionable fix}

### Pre-Commit Checks
- [ ] Type check: {status}
- [ ] Linting: {status}

### Recommendation
{APPROVE | REQUEST CHANGES | COMMENT} - {brief rationale}
```

## Review Criteria Priority

1. **Security vulnerabilities** (SQL injection, XSS, auth bypass, credential exposure)
2. **Logic errors and bugs** (null handling, error cases, edge cases)
3. **Type safety** (any usage, unsafe type assertions, missing validations)
4. **API contract violations** (if API specs exist)
5. **Performance concerns** (N+1 queries, inefficient algorithms, memory leaks)
6. **Missing tests** (new features without coverage, changed behavior without tests)
7. **Code clarity** (confusing logic, missing documentation for complex code)

## Anti-Patterns to Flag

- Credentials or secrets in code
- Disabled security features or validation
- Silent error swallowing (empty catch blocks)
- Commented-out code without explanation
- TODOs without tickets or context
- Copy-pasted code suggesting need for abstraction
- Overly complex functions (>50 lines, high cyclomatic complexity)

## Examples

**Finding:**
- **src/api/users/route.ts:45** - SQL injection vulnerability: User input directly interpolated into query. Use parameterized queries.

**Finding:**
- **src/lib/api-client.ts:23** - Missing error handling: API call has no try-catch. Wrap in try-catch and return appropriate error response.
