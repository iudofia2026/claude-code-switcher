#!/bin/bash
# Script to switch between Z.AI and Anthropic Claude models

if [ "$1" = "zai" ]; then
    echo "Switching to Z.AI GLM models..."
    cp ~/.claude/settings-zai.json ~/.claude/settings.json
    echo "✓ Now using Z.AI models"
    echo "Current config:"
    cat ~/.claude/settings.json
elif [ "$1" = "anthropic" ]; then
    echo "Switching to legacy Anthropic Claude models..."
    cp ~/.claude/settings-anthropic.json ~/.claude/settings.json
    echo "✓ Now using Anthropic models"
    echo "Current config:"
    cat ~/.claude/settings.json
else
    echo "Usage: ./switch-claude.sh [zai|anthropic]"
    echo ""
    echo "Current configuration:"
    cat ~/.claude/settings.json
    echo ""
    echo "Available options:"
    echo "  zai        - Switch to Z.AI GLM models"
    echo "  anthropic  - Switch to legacy Anthropic Claude models"
fi
