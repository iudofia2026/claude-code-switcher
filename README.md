# Claude Code Switcher

**Instantly switch between Z.AI GLM models and Anthropic Claude models in Claude Code**

---

## What This Does

Claude Code normally uses Anthropic's API by default. This tool lets you:

- **Switch to Z.AI's GLM models** (cheaper, faster for some tasks)
- **Switch back to Anthropic's Claude models** (your Pro subscription)
- **Toggle between them instantly** with a single command
- **Manage API keys without editing JSON files**
- **Auto-restart Claude Code** after switching

No need to manually edit configuration files, remember API endpoints, or struggle with JSON syntax.

---

## Why You'd Want This

**Use Z.AI when:**
- You want to save money (starts at $3/month for GLM Coding Plan)
- You're doing high-volume coding tasks
- You want to try China's leading AI models (GLM-4.6)

**Use Anthropic when:**
- You have a Claude Pro subscription
- You want the latest official Claude models
- You need maximum reliability and support

---

## Installation

### Quick Install

```bash
git clone https://github.com/iudofia2026/claude-code-switcher.git
cd claude-code-switcher
chmod +x install.sh
./install.sh
```

The installer will:
1. Install the `claude-switch` command globally
2. Set up configuration templates
3. Optionally guide you through Z.AI API key setup
4. Let you choose your default provider

---

## Usage

### Basic Commands

**Check current configuration:**
```bash
claude-switch status
```

**Switch to Z.AI models:**
```bash
claude-switch zai
```

**Switch to Anthropic models:**
```bash
claude-switch anthropic
```

**Show help:**
```bash
claude-switch help
```

---

### Managing Z.AI API Keys

**Set up Z.AI interactively (recommended):**
```bash
claude-switch setup-zai
```

**Update API key directly:**
```bash
claude-switch set-key YOUR_ZAI_API_KEY
```

**Edit Z.AI config manually:**
```bash
claude-switch edit-zai
```

**Edit Anthropic config manually:**
```bash
claude-switch edit-anthropic
```

---

## Features

### User-Friendly Interface

- **Color-coded output** - Green checkmarks, yellow warnings, clear errors
- **Interactive prompts** - No need to remember complex commands
- **Auto-restart helper** - Offers to kill Claude Code after switching
- **Smart validation** - Checks JSON syntax and API key format
- **Status display** - Always know which provider you're using

### Safety & Reliability

- **Automatic backups** - Previous configs saved before switching
- **JSON validation** - Won't copy invalid configs
- **Provider detection** - Knows if you're already on the target provider
- **Helpful errors** - Clear messages when API keys are missing

### Convenience

- **Global command** - Run `claude-switch` from anywhere
- **No file editing** - Manage everything through commands
- **Shell integration** - Automatically adds to PATH during install
- **Wizard mode** - Guided setup for first-time users

---

## How It Works

The switcher maintains three configuration files:

| File | Purpose |
|------|---------|
| `~/.claude/settings.json` | Active configuration (used by Claude Code) |
| `~/.claude/settings-zai.json` | Z.AI configuration template |
| `~/.claude/settings-anthropic.json` | Anthropic configuration template |

When you run `claude-switch zai` or `claude-switch anthropic`, it copies the appropriate template to the active config file.

Backups of previous configs are automatically saved to `~/.claude/backups/` with timestamps.

---

## Configuration Details

### Z.AI Configuration

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "your_zai_api_key",
    "ANTHROPIC_BASE_URL": "https://api.z.ai/api/anthropic",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  },
  "alwaysThinkingEnabled": false,
  "model": "opus"
}
```

**Z.AI Model Mappings:**
- `opus` - GLM-4.6 (most capable)
- `sonnet` - GLM-4.6 (same as opus)
- `haiku` - GLM-4.5-Air (fastest, cheapest)

### Anthropic Configuration

```json
{
  "env": {},
  "alwaysThinkingEnabled": false,
  "model": "claude-sonnet-4-20250514"
}
```

Uses your default Claude Pro subscription credentials.

---

## Complete Command Reference

```bash
# Switching
claude-switch zai                  # Switch to Z.AI GLM models
claude-switch anthropic            # Switch to Anthropic Claude models
claude-switch status               # Show current configuration

# API Key Management
claude-switch setup-zai            # Interactive Z.AI setup wizard
claude-switch set-key <key>        # Set/update Z.AI API key

# Configuration Editing
claude-switch edit-zai             # Edit Z.AI config in $EDITOR
claude-switch edit-anthropic       # Edit Anthropic config

# Help
claude-switch help                 # Show all commands
claude-switch --help               # Same as help
```

---

## Typical Workflow

### First Time Setup

```bash
# Install the tool
git clone https://github.com/iudofia2026/claude-code-switcher.git
cd claude-code-switcher
./install.sh

# Set up Z.AI (if you have an account)
claude-switch setup-zai

# Choose your provider
claude-switch anthropic    # or: claude-switch zai

# Restart Claude Code
# (The tool will offer to do this for you)
```

### Daily Use

```bash
# Check what you're using
claude-switch status

# Switch to Z.AI for high-volume work
claude-switch zai

# Switch back to Claude Pro later
claude-switch anthropic
```

---

## Troubleshooting

### 401 Authentication Error with Z.AI

If you see `{"error":{"message":"身份验证失败。","type":"1000"}}`:

1. Check your API key is valid at https://open.bigmodel.cn
2. Update your key:
   ```bash
   claude-switch set-key YOUR_NEW_KEY
   ```
3. Verify your Z.AI account has credits
4. Confirm your plan is active

### Configuration Not Updating

The tool will offer to restart Claude Code for you. If you declined:

```bash
pkill -f claude
cd your-project-directory
claude
```

Configuration changes only take effect after restart.

### Script Not Found After Install

If `claude-switch` isn't found:

```bash
# Reload your shell configuration
source ~/.zshrc    # or ~/.bashrc
```

Or restart your terminal.

### API Key Not Saving

Make sure you have write permissions:

```bash
ls -la ~/.claude/
```

If needed:

```bash
chmod 644 ~/.claude/settings-*.json
```

### Verify Setup

Check if everything is configured correctly:

```bash
claude-switch status
cat ~/.claude/settings.json
```

Inside Claude Code, type:
```
/status
```

---

## Getting a Z.AI API Key

1. Visit https://open.bigmodel.cn
2. Create an account or log in
3. Navigate to API Keys section
4. Generate a new API key
5. Subscribe to a GLM Coding Plan (starts at $3/month)
6. Add your key:
   ```bash
   claude-switch set-key YOUR_API_KEY
   ```

---

## Uninstallation

To remove Claude Code Switcher:

```bash
# Remove the command
sudo rm /usr/local/bin/claude-switch

# Remove configurations (optional - keeps your API keys)
rm -rf ~/.claude/settings-zai.json
rm -rf ~/.claude/settings-anthropic.json
rm -rf ~/.claude/backups/

# Remove shell alias (if installed to home directory)
# Edit ~/.zshrc or ~/.bashrc and remove the claude-switch alias
```

---

## Requirements

- Claude Code installed and working
- Bash shell (standard on macOS and Linux)
- Z.AI API key (only if using Z.AI models)
- Python 3 or jq (optional, for better JSON validation)

---

## Advanced Usage

### Scripting

You can use claude-switch in scripts:

```bash
#!/bin/bash
# Use Z.AI for bulk operations
claude-switch zai
pkill -f claude
cd my-project && claude &

# Wait for tasks...
sleep 3600

# Switch back
claude-switch anthropic
```

### Custom Models

Edit configs directly to use different model versions:

```bash
claude-switch edit-anthropic
# Change "model" field to desired Claude model
```

### Backup Management

Backups are stored in `~/.claude/backups/` with timestamps:

```bash
# List backups
ls -lah ~/.claude/backups/

# Restore a backup
cp ~/.claude/backups/settings_20250111_143022.json ~/.claude/settings.json
```

---

## Resources

- **Z.AI Documentation:** https://open.bigmodel.cn/dev/api/
- **Z.AI Claude Code Setup Guide:** https://bigmodel.cn/docs/guides/claude-code
- **Z.AI Platform:** https://open.bigmodel.cn
- **Claude Code:** https://www.claudecode.com/
- **GitHub Repository:** https://github.com/iudofia2026/claude-code-switcher

---

## FAQ

**Q: Can I use this with Claude Code on Windows?**  
A: The script is written for bash. You'd need WSL (Windows Subsystem for Linux) or adapt it for PowerShell.

**Q: Will this mess up my existing Claude Code configuration?**  
A: No. The installer checks for existing configs and creates automatic backups before switching.

**Q: Do I need both Z.AI and Anthropic accounts?**  
A: No. You can use just one. The switcher is most useful if you have access to both.

**Q: How much does Z.AI cost?**  
A: GLM Coding Plan starts at $3/month. Pay-as-you-go options also available. Much cheaper than Claude Pro for high-volume use.

**Q: Which model should I use?**  
A: Try both! Z.AI's GLM-4.6 is very capable and cost-effective. Anthropic's Claude Sonnet 4 is the latest and most powerful.

**Q: Is my API key secure?**  
A: Your API keys are stored locally in `~/.claude/` with restricted permissions. They're never uploaded anywhere. The example configs in this repo don't contain real keys.

**Q: Can I switch while Claude Code is running?**  
A: Yes, but changes won't take effect until you restart Claude Code. The tool will offer to kill it for you.

**Q: What if I want to use a different Z.AI model?**  
A: Run `claude-switch edit-zai` and change the `"model"` field to `"sonnet"` or `"haiku"`.

---

## Contributing

Issues and pull requests welcome! This tool is meant to be simple, reliable, and user-friendly.

If you have ideas for improvements:
1. Open an issue to discuss
2. Fork and create a pull request
3. Ensure scripts remain cross-platform compatible

---

## License

MIT License - feel free to use, modify, and distribute.

---

## Changelog

### v2.0.0 (Latest)
- Interactive installation with guided setup
- `claude-switch` command available globally
- Color-coded output for better UX
- Auto-restart helper after switching
- API key management commands (`set-key`, `setup-zai`)
- Config editing shortcuts (`edit-zai`, `edit-anthropic`)
- Automatic backups before switching
- JSON validation
- Provider detection (knows if already on target)
- Improved error messages and help text

### v1.0.0
- Initial release
- Basic switching functionality
- Manual config editing required

---

**Made with practicality in mind. Switch models, save money, code better.**
