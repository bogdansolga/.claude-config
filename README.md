# claude-config

Shareable Claude Code setup - commands, scripts, and config.

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

**PR**
- `/pr:checks` - lint, types, tests before PR
- `/pr:create` - push + create PR
- `/pr:review-local` - self-review diff
- `/pr:review` - trigger Claude GitHub Action review
- `/pr:code-rabbit` - handle CodeRabbit comments
- `/pr:merge` - squash merge with structured message

**Quality**
- `/quality:quick-fix` - small fix, no heavy workflow
- `/quality:find-large-files` - find + split recommendations

## Update

```bash
cd ~/.claude-config && git pull
```

Commands auto-update (symlinked). Configs don't (your customizations preserved).

## Plugins

Expects these installed via `/plugins`:
- `superpowers@superpowers-marketplace`
- `frontend-design@claude-plugins-official`
- `ralph-loop@claude-plugins-official`

## Structure

```
commands/
├── git/      catchup, commit, sync, cleanup
├── pr/       checks, create, review-local, review, code-rabbit, merge
└── quality/  quick-fix, find-large-files
scripts/
└── status-line.sh
config/
├── config.json    (model, theme, editor)
└── settings.json  (plugins, status line)
```

## Uninstall

```bash
rm ~/.claude/commands/{git,pr,quality}
rm ~/.claude/scripts/status-line.sh
# Restore backup if needed: mv ~/.claude/commands.bak.* ~/.claude/commands
```
