#!/bin/bash
# install.sh - Install Claude Code configuration

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Installing Claude Code configuration..."
echo ""

# Backup existing commands if present
if [ -d "$CLAUDE_DIR/commands" ] && [ ! -L "$CLAUDE_DIR/commands/git" ]; then
  BACKUP_DIR="$CLAUDE_DIR/commands.bak.$(date +%Y%m%d-%H%M%S)"
  echo "Backing up existing commands to $BACKUP_DIR"
  mv "$CLAUDE_DIR/commands" "$BACKUP_DIR"
fi

# Create directories
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/scripts"

# Symlink command categories
for category in git pr quality; do
  if [ -L "$CLAUDE_DIR/commands/$category" ]; then
    rm "$CLAUDE_DIR/commands/$category"
  fi
  ln -sf "$REPO_DIR/commands/$category" "$CLAUDE_DIR/commands/$category"
  echo "  Linked commands/$category"
done

# Symlink scripts
if [ -L "$CLAUDE_DIR/scripts/status-line.sh" ]; then
  rm "$CLAUDE_DIR/scripts/status-line.sh"
fi
ln -sf "$REPO_DIR/scripts/status-line.sh" "$CLAUDE_DIR/scripts/status-line.sh"
echo "  Linked scripts/status-line.sh"

# Config files - copy if not exists
echo ""
if [ ! -f "$CLAUDE_DIR/config.json" ]; then
  cp "$REPO_DIR/config/config.json" "$CLAUDE_DIR/config.json"
  echo "Created config.json"
else
  echo "config.json exists - skipped (compare: diff $CLAUDE_DIR/config.json $REPO_DIR/config/config.json)"
fi

if [ ! -f "$CLAUDE_DIR/settings.json" ]; then
  cp "$REPO_DIR/config/settings.json" "$CLAUDE_DIR/settings.json"
  echo "Created settings.json"
else
  echo "settings.json exists - merge enabledPlugins manually if needed"
fi

echo ""
echo "Installation complete!"
echo ""
echo "Commands available:"
echo "  /git:catchup   /git:commit   /git:sync   /git:cleanup"
echo "  /pr:checks   /pr:create   /pr:review-local   /pr:review   /pr:merge   /pr:code-rabbit"
echo "  /quality:quick-fix   /quality:find-large-files"
echo ""
echo "To update: cd $REPO_DIR && git pull"
