# Claude-Workspace-Template

**A lightweight, fork-friendly starting point for building AI-assisted development workspaces with Claude-Dev-Framework.**

**Template Repository:** [github.com/fda3r6sbvdgq09gse2/claude-workspace-template](https://github.com/fda3r6sbvdgq09gse2/claude-workspace-template)

**Framework Repository:** [github.com/fda3r6sbvdgq09gse2/claude-dev-framework](https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework)

[![Framework Version](https://img.shields.io/badge/framework-v1.0.0-blue.svg)](https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🎯 What Is This?

This template provides the **minimal boilerplate** needed to start building projects with **Claude-Dev-Framework** (the framework repository). It's designed to be:

- **Forked** (not cloned) - Create your own company workspace
- **Lightweight** - Less than 100 files, mostly configuration
- **Upgradeable** - Change one line to upgrade the entire framework
- **Customizable** - Single source of truth for all your projects

## 🏗️ Architecture Overview

```
Claude-Dev-Framework (Marketplace)
    ↓ installed via Claude Code
Claude-Workspace-Template (This Template)
    ↓ forked by companies
blackford-workspace (Your Company Workspace)
    ↓ contains
Your Projects (book-cataloger, inventory-system, etc.)
```

**The Pattern:**
1. **Framework** = Reusable code (never fork, just reference)
2. **Template** = Starting point (fork this once)
3. **Workspace** = Your company's projects

**Why This Works:**
- Framework updates flow to all users
- Your customizations stay separate
- No merge conflicts when upgrading
- Clear separation of concerns

---

## 🚀 Quick Start (5 Minutes)

### Prerequisites

- [Claude Code](https://docs.claude.com/en/docs/claude-code/installation) installed
- Git configured with GitHub access
- Basic understanding of YAML

### Step 1: Fork This Template

```bash
# Option A: Via GitHub UI
# Go to: https://github.com/fda3r6sbvdgq09gse2/claude-workspace-template
# Click "Fork" → Create your company workspace

# Option B: Via CLI (Recommended)
gh repo fork fda3r6sbvdgq09gse2/claude-workspace-template \
  --clone=true \
  --remote=true \
  --fork-name="blackford-workspace"
cd claude-workspace-template
```

### Step 2: Customize Your Workspace

```bash
# Edit the master configuration file
vim STARTUP_VARIABLES.yaml

# Change these values:
# startup.name: "STARTUP_NAME"        → "blackford" (your company identifier)
# startup.display_name: "..."         → "Blackford Industries" (human-readable)
# startup.github_org: "..."           → "blackford-inc" (GitHub organization)
```

### Step 3: Rename and Push

```bash
# Rename directory to match your company
mv claude-workspace-template blackford-workspace
cd blackford-workspace

# Create new repo in your organization
gh repo create blackford-inc/blackford-workspace --private --source=. --remote=origin --push

# Or update remote if you forked via UI
git remote set-url origin git@github.com:blackford-inc/blackford-workspace.git
git add .
git commit -m "chore: Customize workspace for Blackford Industries"
git push
```

### Step 4: Create Your First Project

```bash
cd projects
mkdir my-first-project
cd my-first-project

# Start Claude Code
claude

# The framework agents are now available!
# Try: /agent-backend, /agent-frontend, /agent-ceo, etc.
```

**🎉 You're ready!** The framework is automatically loaded from the marketplace.

---

## 📁 Directory Structure

```
claude-workspace-template/  # Or: blackford-workspace (after you fork)
├── .claude/
│   └── settings.json              # Framework marketplace configuration
├── .ai/
│   ├── context/                   # Session context files
│   ├── patterns/                  # Reusable patterns
│   ├── scripts/                   # Automation scripts
│   └── templates/                 # Code templates
├── projects/                      # Your projects go here
│   └── README.md                  # How to add projects
├── docs/
│   ├── QUICK_START.md            # Detailed getting started
│   ├── CUSTOMIZATION.md          # How to customize
│   ├── UPGRADING.md              # How to upgrade framework
│   └── ARCHITECTURE.md           # System architecture
├── scripts/
│   └── upgrade-framework.sh      # Automated upgrade script
├── STARTUP_VARIABLES.yaml        # ⚠️ CUSTOMIZE THIS
├── README.md                      # This file
└── LICENSE                        # MIT License
```

---

## 🎛️ Configuration Files

### STARTUP_VARIABLES.yaml (Single Source of Truth)

This is **the most important file** in your workspace. All configuration flows from here.

```yaml
startup:
  name: "YourCompany"              # Your company identifier
  display_name: "Your Company"     # Your company name
  github_org: "your-org"           # Your GitHub org

framework:
  source: "Claude-Dev-Framework"   # The framework repo
  version: "1.0.0"                 # Upgrade by changing this
  marketplace_repo: "fda3r6sbvdgq09gse2/claude-dev-framework"

projects:
  - name: "my-project"
    directory: "./projects/my-project"
```

### .claude/settings.json (Framework Link)

**DO NOT edit this file directly.** It's automatically synced with `STARTUP_VARIABLES.yaml`.

```json
{
  "extraKnownMarketplaces": {
    "Claude-Dev-Framework": {
      "source": {
        "source": "github",
        "repo": "fda3r6sbvdgq09gse2/claude-dev-framework",
        "ref": "v1.0.0"
      }
    }
  }
}
```

---

## 📚 Documentation

Comprehensive guides for every aspect of using this template:

- **[Quick Start Guide](docs/QUICK_START.md)** - Detailed walkthrough (15 min read)
- **[Customization Guide](docs/CUSTOMIZATION.md)** - How to tailor this workspace to your needs
- **[Upgrade Guide](docs/UPGRADING.md)** - How to upgrade the framework (v1.0 → v2.0)
- **[Architecture Guide](docs/ARCHITECTURE.md)** - Deep dive into the three-tier system

---

## 🔄 Upgrading Framework

**The Magic of This Architecture:** Upgrading the entire framework is a **one-line change**.

```bash
# Current: Framework v1.0.0
# Goal: Upgrade to v2.0.0

# Step 1: Change version in STARTUP_VARIABLES.yaml
vim STARTUP_VARIABLES.yaml
# Change: framework.version: "1.0.0"
# To:     framework.version: "2.0.0"

# Step 2: Sync settings
./scripts/upgrade-framework.sh v2.0.0

# Step 3: Test
cd projects/your-project
claude
# All agents now use v2.0 framework!
```

**What Gets Updated:**
- ✅ All framework agents (backend, frontend, testing, etc.)
- ✅ All framework commands
- ✅ Framework documentation

**What Stays The Same:**
- ❌ Your company config (STARTUP_VARIABLES.yaml)
- ❌ Your projects (nothing breaks)
- ❌ Your custom scripts

See [docs/UPGRADING.md](docs/UPGRADING.md) for detailed upgrade procedures.

---

## 🎨 Adding Projects

Each project can have its own `PROJECT_VARIABLES.yaml`:

```bash
cd projects/book-cataloger
cat > PROJECT_VARIABLES.yaml <<'EOF'
project:
  name: "book-cataloger"
  version: "0.1.0"
  description: "Personal library management system"

# Inherits from STARTUP_VARIABLES.yaml
inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"

# Project-specific configuration
team:
  lead: "Alice"
  agents_used: ["backend", "frontend", "testing"]
EOF
```

**Variable Resolution Order:**
```
PROJECT_VARIABLES.yaml
    ↓ overrides
STARTUP_VARIABLES.yaml
    ↓ overrides
Framework Defaults (from marketplace)
```

---

## 🤝 Contributing Back to Framework

Found something useful in your project? Contribute it back!

```bash
# 1. Extract the generic pattern
cd ~/your-workspace/projects/book-cataloger
# You built an awesome ISBN scanner pattern

# 2. Document it
cat > pattern-isbn-scanner.md <<'EOF'
# ISBN Scanner Pattern
[Your documentation]
EOF

# 3. Submit to framework
cd ~/claude-dev-framework
gh issue create --title "Pattern: ISBN Scanner" --body "$(cat pattern-isbn-scanner.md)"
```

The framework maintainer (fda3r6sbvdgq09gse2) can then:
1. Review your pattern
2. Extract generic parts
3. Add to framework v2.0
4. You upgrade and get it back!

**Virtuous Cycle:**
```
Your Project → Learning → Framework v2.0 → All Users → More Learnings → v3.0
```

---

## 🔧 Advanced Configuration

### Multiple Environments

```yaml
# STARTUP_VARIABLES.yaml
environments:
  development:
    default: true
    framework_version: "2.0.0-beta"  # Test beta versions
  production:
    framework_version: "1.0.0"        # Stable version
```

### Custom Framework Fork

Using a custom fork of the framework:

```yaml
# STARTUP_VARIABLES.yaml
framework:
  marketplace_repo: "blackford-inc/claude-dev-framework-fork"
  version: "1.0.0-custom"
```

### MCP Server Integration (Advanced)

For real-time framework upgrades:

```json
// .claude/mcp.json
{
  "mcpServers": {
    "claude-dev-framework": {
      "command": "npx",
      "args": ["-y", "@fda3r6sbvdgq09gse2/claude-dev-framework-mcp@latest"]
    }
  }
}
```

See [Framework MCP Documentation](https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/blob/main/docs/MCP.md) for details.

---

## 🎓 Best Practices

### DO ✅

- **Customize** `STARTUP_VARIABLES.yaml` extensively
- **Pin** framework versions in production
- **Test** framework upgrades in development first
- **Document** project-specific patterns
- **Contribute** learnings back to framework

### DON'T ❌

- **Don't** edit `.claude/settings.json` directly
- **Don't** fork the framework (just reference it)
- **Don't** hardcode values (use VARIABLES.yaml)
- **Don't** skip reading the upgrade guide before upgrading
- **Don't** mix framework code with project code

---

## 📊 Comparison to Other Patterns

| Aspect | Fork Framework | Use This Template | MCP Only |
|--------|---------------|-------------------|-----------|
| Upgrade Ease | ❌ Merge conflicts | ✅ One-line change | ✅ Instant |
| Customization | ✅ Full control | ✅ Config-based | ⚠️ Limited |
| Offline Work | ✅ Yes | ✅ Yes | ❌ Needs server |
| Setup Time | ⚠️ Complex | ✅ 5 minutes | ⚠️ Requires Node.js |
| Code Duplication | ❌ High | ✅ Minimal | ✅ None |

**Recommended:** Start with this template. Add MCP later if needed.

---

## 🐛 Troubleshooting

### Framework Agents Not Loading

```bash
# Check marketplace is configured
cat .claude/settings.json | jq '.extraKnownMarketplaces'

# Verify framework version exists
gh api repos/fda3r6sbvdgq09gse2/claude-dev-framework/git/refs/tags | jq '.[].ref'

# Restart Claude Code
# Framework loads on startup
```

### Version Mismatch Errors

```bash
# Check current version
grep "version:" STARTUP_VARIABLES.yaml

# Check what's in settings
jq '.extraKnownMarketplaces."Claude-Dev-Framework".source.ref' .claude/settings.json

# Sync them
./scripts/upgrade-framework.sh $(grep version: STARTUP_VARIABLES.yaml | awk '{print $2}' | tr -d '"')
```

### Projects Not Finding Framework

```bash
# Ensure you're in a project directory
cd projects/your-project

# Framework is available workspace-wide
# But Claude Code needs to be launched from project dir
```

---

## 📞 Support

- **Framework Issues**: https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/issues
- **Template Issues**: https://github.com/fda3r6sbvdgq09gse2/claude-workspace-template/issues
- **Claude Code Docs**: https://docs.claude.com/en/docs/claude-code

---

## 📜 License

MIT License - See [LICENSE](LICENSE)

**Framework:** MIT License - See [Framework License](https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/blob/main/LICENSE)

---

## 🏆 Why This Architecture is World-Class

### Follows Industry Best Practices

**Like React:**
- `react` (framework) vs `create-react-app` (template)
- Users install framework, customize template
- Clear upgrade path via package manager

**Like Django:**
- `django` (framework) vs `startproject` (template)
- Separation of reusable code vs project structure
- pip install to upgrade

**Like Claude Code Itself:**
- Plugin marketplaces for reusable components
- Projects reference marketplaces
- Version pinning for stability

### Engineering Excellence

✅ **Separation of Concerns** - Framework, template, and projects are distinct
✅ **DRY Principle** - Code lives in one place (framework)
✅ **Semantic Versioning** - Clear upgrade paths (v1.0 → v2.0)
✅ **Configuration as Code** - YAML for all config
✅ **Documentation-First** - Comprehensive guides
✅ **Platform Native** - Uses Claude Code patterns correctly

---

## 🚀 Ready to Build?

```bash
# 1. Fork this template
gh repo fork fda3r6sbvdgq09gse2/claude-workspace-template --fork-name="blackford-workspace"

# 2. Customize it
vim STARTUP_VARIABLES.yaml

# 3. Create a project
cd projects && mkdir my-project && cd my-project

# 4. Start building
claude
```

**Welcome to world-class AI-assisted development!** 🎉

---

*Built with ❤️ using [Claude-Dev-Framework](https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework)*
