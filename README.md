# Claude Code Switcher

**Instantly switch between Z.AI GLM models and Anthropic Claude models in Claude Code**

Stop manually editing JSON files. Switch APIs with a single command.

---

## Quick Start

```bash
git clone https://github.com/iudofia2026/claude-code-switcher.git
cd claude-code-switcher
./install.sh
```

The installer guides you through setup in under 2 minutes.

---

## Why Use This?

**Switch between two API providers:**

| Provider | Best For | Cost |
|----------|----------|------|
| **Z.AI** | High-volume coding, saving money | $3/month |
| **Anthropic** | Latest Claude models, Pro subscription | $20/month |

Toggle between them based on your needs. No configuration hassle.

---

## Usage

### Essential Commands

```bash
claude-switch status        # Check which API you're using
claude-switch zai          # Switch to Z.AI models
claude-switch anthropic    # Switch to Anthropic models
```

After switching, the tool offers to restart Claude Code for you.

### Managing Your Z.AI API Key

```bash
claude-switch setup-zai              # Interactive setup wizard
claude-switch set-key YOUR_KEY       # Update API key quickly
claude-switch edit-zai              # Manual config editing
```

Get your Z.AI API key: https://open.bigmodel.cn

### All Commands

| Command | Description |
|---------|-------------|
| `status` | Show current API provider and model |
| `zai` | Switch to Z.AI GLM models |
| `anthropic` | Switch to Anthropic Claude models |
| `setup-zai` | Interactive Z.AI configuration wizard |
| `set-key <key>` | Update Z.AI API key |
| `edit-zai` | Edit Z.AI config in your editor |
| `edit-anthropic` | Edit Anthropic config in your editor |
| `help` | Show help and all commands |

---

## Features

**User-Friendly:**
- Color-coded output (green success, yellow warnings, red errors)
- Interactive prompts guide you through setup
- Auto-restart helper after switching
- Smart validation catches errors before they break things

**Safe & Reliable:**
- Automatic backups before every switch
- JSON validation prevents broken configs
- Detects which provider you're already using
- Never overwrites API keys during installation

**Convenient:**
- Works from any directory
- No manual file editing required
- Installs globally as `claude-switch` command

---

## How It Works

Three simple config files:

```
~/.claude/settings.json              # Active config (Claude Code reads this)
~/.claude/settings-zai.json          # Z.AI template
~/.claude/settings-anthropic.json    # Anthropic template
```

When you run `claude-switch zai`, it copies the Z.AI template to the active config. That's it.

Backups are auto-saved to `~/.claude/backups/` with timestamps.

---

## Model Information

### Z.AI Models

| Model Name | Maps To | Best For |
|------------|---------|----------|
| `opus` | GLM-4.6 | Most capable, general use |
| `sonnet` | GLM-4.6 | Same as opus |
| `haiku` | GLM-4.5-Air | Fastest, cheapest |

### Anthropic Models

Uses your Claude Pro subscription. Default: `claude-sonnet-4-20250514`

Change models by editing configs: `claude-switch edit-anthropic`

---

## Troubleshooting

**"claude-switch: command not found"**

Reload your shell:
```bash
source ~/.zshrc    # or ~/.bashrc
```

**401 Authentication Error (Z.AI)**

Your API key is invalid or expired:
```bash
claude-switch set-key YOUR_NEW_KEY
```

Check your account at https://open.bigmodel.cn

**Changes Not Taking Effect**

Claude Code must restart after switching. The tool will offer to do this for you, or manually:
```bash
pkill -f claude
claude
```

**Verify Everything Works**

```bash
claude-switch status
```

Inside Claude Code:
```
/status
```

---

## Example Workflow

```bash
# First time setup
./install.sh

# Add your Z.AI key
claude-switch setup-zai

# Check current status
claude-switch status

# Switch to Z.AI for high-volume work
claude-switch zai

# Later, switch back to Claude Pro
claude-switch anthropic
```

---

## Configuration Examples

**Z.AI Config:**
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

**Anthropic Config:**
```json
{
  "env": {},
  "alwaysThinkingEnabled": false,
  "model": "claude-sonnet-4-20250514"
}
```

---

## FAQ

**Do I need both Z.AI and Anthropic accounts?**  
No. Use whichever you have. The switcher is most useful if you have both.

**Will this break my existing Claude Code setup?**  
No. The installer checks for existing configs and backs up before making changes.

**Is my API key secure?**  
Yes. Keys are stored locally in `~/.claude/` and never uploaded anywhere.

**Can I switch while Claude Code is running?**  
Yes, but changes require a restart. The tool offers to kill Claude Code for you.

---

## Requirements

- Claude Code installed
- Bash shell (macOS/Linux standard)
- Z.AI API key (only if using Z.AI)

Optional: Python 3 or jq for better JSON validation

---

## Uninstall

```bash
sudo rm /usr/local/bin/claude-switch
rm -rf ~/.claude/settings-zai.json
rm -rf ~/.claude/settings-anthropic.json
rm -rf ~/.claude/backups/
```

---

## Advanced

### Use in Scripts

```bash
#!/bin/bash
claude-switch zai
pkill -f claude && cd my-project && claude &
# ... do work ...
claude-switch anthropic
```

### Restore Backups

```bash
ls ~/.claude/backups/
cp ~/.claude/backups/settings_TIMESTAMP.json ~/.claude/settings.json
```

### Custom Models

```bash
claude-switch edit-anthropic
# Change "model" field to any Claude model version
```

---

## Resources

- Z.AI Platform: https://open.bigmodel.cn
- Z.AI Documentation: https://open.bigmodel.cn/dev/api/
- Claude Code: https://www.claudecode.com/
- This Repo: https://github.com/iudofia2026/claude-code-switcher

---

## Contributing

Issues and PRs welcome! Keep it simple and user-friendly.

**License:** MIT

---

## Changelog

**v2.0.0** - Interactive setup, global command, color output, auto-restart, smart validation  
**v1.0.0** - Initial release with basic switching

---

**Switch models. Save money. Code better.**
