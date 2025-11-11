#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
BOLD='\033[1m'

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_header() {
    echo -e "${BOLD}$1${NC}"
}

echo ""
print_header "════════════════════════════════════════"
print_header "   Claude Code Switcher - Installation  "
print_header "════════════════════════════════════════"
echo ""

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
    print_warning "Claude Code doesn't appear to be installed"
    print_info "This tool requires Claude Code to work"
    echo ""
    read -p "Continue anyway? (y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
    echo ""
fi

# Create .claude directory if it doesn't exist
mkdir -p ~/.claude

# Step 1: Install the main script
print_header "1. Installing claude-switch command..."
chmod +x claude-switch

# Try to install to /usr/local/bin first
if [ -w /usr/local/bin ]; then
    cp claude-switch /usr/local/bin/claude-switch
    print_success "Installed to /usr/local/bin/claude-switch"
    INSTALLED_TO_PATH=true
elif sudo -n true 2>/dev/null; then
    # Can sudo without password
    sudo cp claude-switch /usr/local/bin/claude-switch
    print_success "Installed to /usr/local/bin/claude-switch"
    INSTALLED_TO_PATH=true
else
    # Ask for sudo
    echo ""
    print_info "Need sudo permission to install to /usr/local/bin"
    if sudo cp claude-switch /usr/local/bin/claude-switch 2>/dev/null; then
        print_success "Installed to /usr/local/bin/claude-switch"
        INSTALLED_TO_PATH=true
    else
        # Fallback: install to home directory and add to PATH
        cp claude-switch ~/claude-switch
        chmod +x ~/claude-switch
        print_warning "Could not install to /usr/local/bin"
        print_info "Installed to ~/claude-switch instead"
        INSTALLED_TO_PATH=false
    fi
fi

echo ""

# Step 2: Setup Anthropic config
print_header "2. Setting up Anthropic configuration..."
if [ -f ~/.claude/settings-anthropic.json ]; then
    print_info "Anthropic config already exists, keeping it"
else
    cp settings-anthropic.example.json ~/.claude/settings-anthropic.json
    print_success "Created ~/.claude/settings-anthropic.json"
fi
echo ""

# Step 3: Interactive Z.AI setup
print_header "3. Z.AI Configuration"
echo ""

if [ -f ~/.claude/settings-zai.json ]; then
    print_info "Z.AI config already exists"
    read -p "Reconfigure Z.AI? (y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        SKIP_ZAI=true
    fi
    echo ""
fi

if [ "$SKIP_ZAI" != "true" ]; then
    print_info "Z.AI offers cheaper API access to GLM models"
    print_info "Get your API key from: ${BLUE}https://open.bigmodel.cn${NC}"
    echo ""
    read -p "Do you have a Z.AI API key? (y/n): " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo ""
        read -p "Enter your Z.AI API key: " zai_key
        
        if [ -n "$zai_key" ]; then
            # Create Z.AI config with the provided key
            cat > ~/.claude/settings-zai.json << EOF
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "$zai_key",
    "ANTHROPIC_BASE_URL": "https://api.z.ai/api/anthropic",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  },
  "alwaysThinkingEnabled": false,
  "model": "opus"
}
EOF
            print_success "Z.AI configuration created with your API key"
        else
            cp settings-zai.example.json ~/.claude/settings-zai.json
            print_warning "No key provided, created template config"
        fi
    else
        cp settings-zai.example.json ~/.claude/settings-zai.json
        print_info "Created template config (you can add your key later)"
    fi
    echo ""
fi

# Step 4: Add to shell PATH if needed
if [ "$INSTALLED_TO_PATH" = "false" ]; then
    print_header "4. Setting up shell alias..."
    echo ""
    
    # Detect shell
    if [ -n "$BASH_VERSION" ]; then
        SHELL_RC="$HOME/.bashrc"
        SHELL_NAME="bash"
    elif [ -n "$ZSH_VERSION" ]; then
        SHELL_RC="$HOME/.zshrc"
        SHELL_NAME="zsh"
    else
        SHELL_RC="$HOME/.profile"
        SHELL_NAME="shell"
    fi
    
    # Check if alias already exists
    if ! grep -q "alias claude-switch" "$SHELL_RC" 2>/dev/null; then
        echo "" >> "$SHELL_RC"
        echo "# Claude Code Switcher" >> "$SHELL_RC"
        echo "alias claude-switch='~/claude-switch'" >> "$SHELL_RC"
        print_success "Added alias to $SHELL_RC"
        print_warning "Run: ${BOLD}source $SHELL_RC${NC} to use claude-switch in this terminal"
    else
        print_info "Alias already exists in $SHELL_RC"
    fi
    echo ""
fi

# Step 5: Choose default
print_header "4. Choose Default API Provider"
echo ""
print_info "Which API would you like to use by default?"
echo ""
echo "  1) Anthropic Claude (your Pro subscription)"
echo "  2) Z.AI GLM Models (cheaper alternative)"
echo "  3) Skip - keep current settings"
echo ""
read -p "Enter choice (1-3): " -n 1 -r
echo ""
echo ""

case $REPLY in
    1)
        if [ -f ~/.claude/settings-anthropic.json ]; then
            cp ~/.claude/settings-anthropic.json ~/.claude/settings.json
            print_success "Set Anthropic as default"
        fi
        ;;
    2)
        if [ -f ~/.claude/settings-zai.json ]; then
            if grep -q "YOUR_ZAI_API_KEY_HERE" ~/.claude/settings-zai.json 2>/dev/null; then
                print_error "Z.AI API key not configured"
                print_info "Run: ${BOLD}claude-switch set-key YOUR_KEY${NC} to add it"
            else
                cp ~/.claude/settings-zai.json ~/.claude/settings.json
                print_success "Set Z.AI as default"
            fi
        fi
        ;;
    3)
        print_info "Keeping current settings"
        ;;
esac

echo ""
print_header "════════════════════════════════════════"
print_header "   Installation Complete!                "
print_header "════════════════════════════════════════"
echo ""

# Show next steps
print_success "Claude Code Switcher is ready to use!"
echo ""
print_header "QUICK START:"
echo ""

if [ "$INSTALLED_TO_PATH" = "true" ]; then
    echo "  ${GREEN}claude-switch status${NC}           Check current configuration"
    echo "  ${GREEN}claude-switch zai${NC}              Switch to Z.AI models"
    echo "  ${GREEN}claude-switch anthropic${NC}        Switch to Anthropic models"
    echo "  ${GREEN}claude-switch help${NC}             Show all commands"
else
    echo "  ${GREEN}source $SHELL_RC${NC}               Activate in current terminal"
    echo "  ${GREEN}claude-switch status${NC}           Check current configuration"
    echo "  ${GREEN}claude-switch zai${NC}              Switch to Z.AI models"
    echo "  ${GREEN}claude-switch anthropic${NC}        Switch to Anthropic models"
fi

echo ""

if ! grep -q "YOUR_ZAI_API_KEY_HERE" ~/.claude/settings-zai.json 2>/dev/null || [ ! -f ~/.claude/settings-zai.json ]; then
    :
else
    print_header "TODO:"
    echo "  Add your Z.AI API key: ${BOLD}claude-switch set-key YOUR_KEY${NC}"
    echo "  Or run the setup wizard: ${BOLD}claude-switch setup-zai${NC}"
    echo ""
fi

print_info "Remember: Restart Claude Code after switching providers"
echo ""
