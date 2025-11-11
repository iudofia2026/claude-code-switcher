# Claude Code Switcher

**Instantly switch between Z.AI GLM models and Anthropic Claude models in Claude Code**

---

## What This Does

Claude Code normally uses Anthropic's API by default. This tool lets you:

- **Switch to Z.AI's GLM models** (cheaper, faster for some tasks)
- **Switch back to Anthropic's Claude models** (your Pro subscription)
- **Toggle between them instantly** with a single command

No need to manually edit configuration files or remember API endpoints.

---

## Why You'd Want This

**Use Z.AI when:**
- You want to save money (starts at $3/month for GLM Coding Plan)
- You're doing high-volume coding tasks
- You want to try China's leading AI models

**Use Anthropic when:**
- You have a Claude Pro subscription
- You want the latest official Claude models
- You need maximum reliability and support

---

## Quick Start

### Installation

```bash
git clone https://github.com/iudofia2026/claude-code-switcher.git
cd claude-code-switcher
chmod +x install.sh
./install.sh
```

### Add Your Z.AI API Key

1. Get your API key from [Z.AI Platform](https://open.bigmodel.cn)
2. Edit the Z.AI configuration:
   ```bash
   nano ~/.claude/settings-zai.json
   ```
3. Replace `YOUR_ZAI_API_KEY_HERE` with your actual key

### Usage

Switch to Z.AI models:
```bash
~/switch-claude.sh zai
```

Switch to Anthropic models:
```bash
~/switch-claude.sh anthropic
```

Check current configuration:
```bash
~/switch-claude.sh
```

**Important:** After switching, restart Claude Code:
1. Close all Claude Code windows
2. Open a new terminal
3. Run `claude` to start Claude Code

Configuration changes only take effect on restart.

---

## How It Works

The switcher maintains three configuration files:

| File | Purpose |
|------|---------|
| `~/.claude/settings.json` | Active configuration (used by Claude Code) |
| `~/.claude/settings-zai.json` | Z.AI configuration template |
| `~/.claude/settings-anthropic.json` | Anthropic configuration template |

When you run the switch command, it copies the appropriate template to the active config file.

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
- `opus` → GLM-4.6
- `sonnet` → GLM-4.6
- `haiku` → GLM-4.5-Air

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

## Troubleshooting

### 401 Authentication Error with Z.AI

If you see `{"error":{"message":"身份验证失败。","type":"1000"}}`:

1. Verify your API key at https://open.bigmodel.cn
2. Check your Z.AI account has credits
3. Regenerate your API key if needed
4. Update `~/.claude/settings-zai.json` with the new key
5. Switch and restart:
   ```bash
   ~/switch-claude.sh zai
   pkill -f claude
   claude
   ```

### Configuration Not Updating

Make sure you restart Claude Code after switching:
```bash
pkill -f claude
cd your-project-directory
claude
```

### Script Not Found

Make the script executable:
```bash
chmod +x ~/switch-claude.sh
```

### Verify Active Configuration

Inside Claude Code, type:
```
/status
```

This shows which model and endpoint you're currently using.

---

## Manual Switching (If Script Fails)

You can manually copy configuration files:

**Switch to Z.AI:**
```bash
cp ~/.claude/settings-zai.json ~/.claude/settings.json
```

**Switch to Anthropic:**
```bash
cp ~/.claude/settings-anthropic.json ~/.claude/settings.json
```

Then restart Claude Code.

---

## File Locations

All configuration files are stored in `~/.claude/`:

```
~/.claude/
├── settings.json              # Active config (overwritten when switching)
├── settings-zai.json          # Z.AI template
└── settings-anthropic.json    # Anthropic template
```

The switch script is installed at `~/switch-claude.sh`.

---

## Requirements

- Claude Code installed and working
- Bash shell (standard on macOS and Linux)
- Z.AI API key (if using Z.AI models)

---

## Getting a Z.AI API Key

1. Visit https://open.bigmodel.cn
2. Create an account or log in
3. Navigate to API Keys section
4. Generate a new API key
5. Subscribe to a GLM Coding Plan (starts at $3/month)

---

## Resources

- **Z.AI Documentation:** https://open.bigmodel.cn/dev/api/
- **Z.AI Claude Code Setup Guide:** https://bigmodel.cn/docs/guides/claude-code
- **Z.AI Platform:** https://open.bigmodel.cn
- **Claude Code:** https://www.claudecode.com/

---

## License

MIT License - feel free to use, modify, and distribute.

---

## Contributing

Issues and pull requests welcome! This tool is meant to be simple and reliable.

---

## FAQ

**Q: Can I use this with Claude Code on Windows?**  
A: The script is written for bash. You'd need to adapt it for PowerShell or WSL.

**Q: Will this mess up my existing Claude Code configuration?**  
A: No. The installer checks for existing configs and won't overwrite them.

**Q: Do I need both Z.AI and Anthropic accounts?**  
A: No. You can use just one. The switcher is useful if you have both.

**Q: How much does Z.AI cost?**  
A: GLM Coding Plan starts at $3/month. Pay-as-you-go is also available.

**Q: Which model should I use?**  
A: Try both! Z.AI's GLM-4.6 is very capable and much cheaper. Anthropic's Claude is more widely known and supported.

---

**Made with practicality in mind. Switch models, save money, code better.**
