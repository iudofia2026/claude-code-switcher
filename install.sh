#!/bin/bash

echo "========================================"
echo "  Claude Code Switcher - Installation  "
echo "========================================"
echo ""

# Create .claude directory if it doesn't exist
mkdir -p ~/.claude

# Copy the switching script to home directory
echo "1. Installing switch script..."
cp switch-claude.sh ~/switch-claude.sh
chmod +x ~/switch-claude.sh
echo "   ✓ Installed to ~/switch-claude.sh"
echo ""

# Set up Z.AI configuration
echo "2. Setting up Z.AI configuration..."
if [ -f ~/.claude/settings-zai.json ]; then
    echo "   ! settings-zai.json already exists, skipping..."
else
    cp settings-zai.example.json ~/.claude/settings-zai.json
    echo "   ✓ Created ~/.claude/settings-zai.json"
    echo "   → You need to edit this file and add your Z.AI API key"
fi
echo ""

# Set up Anthropic configuration
echo "3. Setting up Anthropic configuration..."
if [ -f ~/.claude/settings-anthropic.json ]; then
    echo "   ! settings-anthropic.json already exists, skipping..."
else
    cp settings-anthropic.example.json ~/.claude/settings-anthropic.json
    echo "   ✓ Created ~/.claude/settings-anthropic.json"
fi
echo ""

echo "========================================"
echo "  Installation Complete!                "
echo "========================================"
echo ""
echo "Next steps:"
echo ""
echo "1. Add your Z.AI API key:"
echo "   nano ~/.claude/settings-zai.json"
echo ""
echo "2. Choose which API to use:"
echo "   ~/switch-claude.sh zai        # Use Z.AI models"
echo "   ~/switch-claude.sh anthropic  # Use Anthropic models"
echo ""
echo "3. Restart Claude Code for changes to take effect"
echo ""
