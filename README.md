# claude-config

Central repository for Claude Code configuration - commands, scripts, guardrails, and settings.

## Install

```bash
git clone git@github.com:bogdan/claude-config.git ~/.claude-config
~/.claude-config/install.sh
```

## Commands

**Git**
- `/git:catchup` - what was I working on?
- `/git:commit` - commit with [dev]/[fix]/[clean]/[doc]/[improve] prefix
- `/git:sync` - rebase on main
- `/git:cleanup` - delete merged branches
- `/git:pull:workwave` / `/git:pull:nix` - pull with specific SSH key
- `/git:push:workwave` / `/git:push:nix` - push with specific SSH key
- `/git:remote-add:workwave` / `/git:remote-add:nix` - add remote with specific SSH key

**PR**
- `/pr:checks` - lint, types, tests before PR
- `/pr:create` - push + create PR
- `/pr:review:local:review` - self-review diff
- `/pr:review:ci:review` - trigger Claude GitHub Action review
- `/pr:code-rabbit` - handle CodeRabbit comments
- `/pr:merge` - squash merge with structured message

**Quality**
- `/quality:quick-fix` - small fix, no heavy workflow
- `/quality:find-large-files` - find + split recommendations
- `/quality:simplify` - review for unnecessary complexity

**Workflow**
- `/workflow:task-declarative` - define success criteria and let agent loop

## Guardrails

### Biome Linter Rules (biome.jsonc)

| Rule | Level | Description |
|------|-------|-------------|
| `noConsole` | error | No console.log in production (except logger.ts) |
| `noExplicitAny` | error | No `any` type usage |
| `noImplicitAnyLet` | error | No implicit any in let declarations |
| `noEvolvingTypes` | error | No evolving types |
| `useAwait` | error | Async functions must use await |
| `noUselessConstructor` | error | No empty constructors |

### Git Pre-commit Hook (6 checks)

1. **Architecture hierarchy** - Pages → API Routes → Services → Repositories
2. **Schema locations** - Zod schemas in centralized location
3. **Deep architecture** - Repository purity, HOF patterns, auth
4. **TypeScript** - Type checking, unused code detection
5. **Biome linting** - Auto-fix + verify
6. **Code quality** - Secrets, HTTP_STATUS, file size, imports, TODOs

### Code Quality Script (scripts/check-code-quality.sh)

| Check | Type | Description |
|-------|------|-------------|
| Hardcoded secrets | BLOCKS | API keys, tokens, connection strings |
| HTTP_STATUS constants | BLOCKS | Use constants instead of magic numbers |
| File size (500 lines) | BLOCKS | Files must be under 500 lines |
| Import aliases | WARNS | Prefer `@/` over deep relative imports |
| TODO/FIXME comments | WARNS | Resolve before committing |

### Claude Code PreToolUse Hooks (claude-home/settings.json)

| Hook | Description |
|------|-------------|
| npm/npx/pnpm blocked | Must use bun/bunx instead |
| --no-verify blocked | Git hooks must run |
| Secrets in Write/Edit | Blocks hardcoded API keys, tokens |

## Skills

- `finances-manager.md` - Domain knowledge for finances-manager project
- `senior-typescript-developer.md` - TypeScript best practices

## Agents

- `typescript-reviewer.md` - Code review agent for TypeScript

## Plugins

Expects these installed via `/plugins`:
- `superpowers@superpowers-marketplace`
- `frontend-design@claude-plugins-official`
- `ralph-loop@claude-plugins-official`

## Structure

```
claude-config/
├── README.md
├── install.sh                  # First-time installation
├── sync-to-home.sh             # Sync changes to ~/.claude
├── biome.jsonc                 # Project linter config
│
├── claude-home/                # ~/.claude contents
│   ├── settings.json           # PreToolUse hooks, plugins, status line
│   ├── settings.local.json     # Local overrides
│   ├── config.json             # Model, theme, editor
│   ├── hooks.json              # Additional hooks
│   ├── agents/                 # Custom agents
│   │   └── typescript-reviewer.md
│   ├── commands/               # Symlinks to ../commands/
│   ├── output-styles/          # Custom output styles
│   │   └── direct-objective.md
│   ├── plugins/                # Plugin cache and config
│   └── scripts/                # Custom scripts
│       └── status-line.sh
│
├── commands/                   # Slash commands
│   ├── git/                    # catchup, commit, sync, cleanup, pull, push
│   ├── pr/                     # checks, create, review, code-rabbit, merge
│   ├── quality/                # quick-fix, find-large-files, simplify
│   └── workflow/               # task-declarative
│
├── config/                     # Base configs (templates)
│   ├── config.json
│   └── settings.json
│
├── docs/                       # Documentation
│
├── git-hooks/                  # Git hooks for projects
│   └── pre-commit              # 6-check pre-commit hook
│
├── scripts/                    # Standalone scripts
│   └── check-code-quality.sh   # Code quality guardrails
│
└── skills/                     # Custom skills
    ├── finances-manager.md
    └── senior-typescript-developer.md
```

## Usage in Projects

Copy guardrails to a project:

```bash
# Copy biome config
cp ~/.claude-config/biome.jsonc /path/to/project/

# Copy git hooks
cp ~/.claude-config/git-hooks/pre-commit /path/to/project/.git/hooks/
cp ~/.claude-config/git-hooks/pre-commit /path/to/project/scripts/git-hooks/

# Copy check scripts
cp ~/.claude-config/scripts/check-code-quality.sh /path/to/project/scripts/
```

## Sync to Home

After making changes in this repo, sync to home folders:

```bash
# Preview changes
./sync-to-home.sh --dry-run

# Apply changes
./sync-to-home.sh
```

This syncs:
- `claude-home/*` → `~/.claude/` (settings, agents, scripts)
- `commands/` → `~/.claude/commands/` (as symlinks)
- `skills/` → `~/.claude/skills` (as symlink)
- Everything → `~/.claude-config/` (for backwards compatibility)

## Update

```bash
cd ~/.claude-config && git pull
```

Commands auto-update (symlinked). Configs don't (your customizations preserved).

## Uninstall

```bash
rm ~/.claude/commands/{git,pr,quality,workflow}
rm ~/.claude/scripts/status-line.sh
rm ~/.claude/skills
# Restore backup if needed: mv ~/.claude/commands.bak.* ~/.claude/commands
```
