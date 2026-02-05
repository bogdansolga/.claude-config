#!/bin/bash

# Sync claude-config repo to home folders
# Usage: ./sync-to-home.sh [--dry-run]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=""

if [ "$1" == "--dry-run" ]; then
    DRY_RUN="--dry-run"
    echo "DRY RUN - no changes will be made"
    echo ""
fi

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_sync() { echo -e "${GREEN}✓${NC} $1"; }
print_skip() { echo -e "${YELLOW}→${NC} $1"; }

echo "Syncing from: $SCRIPT_DIR"
echo ""

# =============================================================================
# Sync to ~/.claude
# =============================================================================
echo "=== Syncing to ~/.claude ==="

# Settings and config files
for file in settings.json settings.local.json config.json hooks.json; do
    if [ -f "$SCRIPT_DIR/claude-home/$file" ]; then
        rsync -av $DRY_RUN "$SCRIPT_DIR/claude-home/$file" ~/.claude/
        print_sync "$file"
    fi
done

# Directories
for dir in agents output-styles scripts; do
    if [ -d "$SCRIPT_DIR/claude-home/$dir" ]; then
        rsync -av $DRY_RUN --delete "$SCRIPT_DIR/claude-home/$dir/" ~/.claude/$dir/
        print_sync "$dir/"
    fi
done

# Commands - create symlinks to this repo's commands
echo ""
echo "=== Setting up command symlinks ==="
for cmd_dir in git pr quality workflow nextjs; do
    if [ -d "$SCRIPT_DIR/commands/$cmd_dir" ]; then
        # Remove existing (file, symlink, or directory)
        if [ -e ~/.claude/commands/$cmd_dir ] || [ -L ~/.claude/commands/$cmd_dir ]; then
            rm -rf ~/.claude/commands/$cmd_dir 2>/dev/null || true
        fi
        if [ -z "$DRY_RUN" ]; then
            ln -s "$SCRIPT_DIR/commands/$cmd_dir" ~/.claude/commands/$cmd_dir
        fi
        print_sync "~/.claude/commands/$cmd_dir -> $SCRIPT_DIR/commands/$cmd_dir"
    fi
done

# Skills symlink
echo ""
echo "=== Setting up skills symlink ==="
if [ -d "$SCRIPT_DIR/skills" ]; then
    if [ -e ~/.claude/skills ] || [ -L ~/.claude/skills ]; then
        rm -rf ~/.claude/skills 2>/dev/null || true
    fi
    if [ -z "$DRY_RUN" ]; then
        ln -s "$SCRIPT_DIR/skills" ~/.claude/skills
    fi
    print_sync "~/.claude/skills -> $SCRIPT_DIR/skills"
fi

# =============================================================================
# Sync to ~/.claude-config (for backwards compatibility)
# =============================================================================
echo ""
echo "=== Syncing to ~/.claude-config ==="

# Create ~/.claude-config if it doesn't exist
mkdir -p ~/.claude-config

# Sync commands, config, docs, scripts, skills, next-docs
for dir in commands config docs scripts skills next-docs; do
    if [ -d "$SCRIPT_DIR/$dir" ]; then
        rsync -av $DRY_RUN --delete "$SCRIPT_DIR/$dir/" ~/.claude-config/$dir/
        print_sync "$dir/"
    fi
done

# Copy install.sh and README
for file in install.sh README.md; do
    if [ -f "$SCRIPT_DIR/$file" ]; then
        rsync -av $DRY_RUN "$SCRIPT_DIR/$file" ~/.claude-config/
        print_sync "$file"
    fi
done

echo ""
echo "=== Summary ==="
if [ -n "$DRY_RUN" ]; then
    echo "Dry run complete. Run without --dry-run to apply changes."
else
    print_sync "Sync complete!"
    echo ""
    echo "Synced:"
    echo "  ~/.claude/settings.json"
    echo "  ~/.claude/commands/{git,pr,quality,workflow,nextjs} (symlinks)"
    echo "  ~/.claude/skills (symlink)"
    echo "  ~/.claude/agents/"
    echo "  ~/.claude/scripts/"
    echo "  ~/.claude-config/"
fi
