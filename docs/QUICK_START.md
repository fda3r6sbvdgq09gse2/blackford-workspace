# Quick Start Guide

**Audience:** First-time users, beginners, anyone who wants a guided walkthrough
**Time Required:** 15-20 minutes
**Prerequisites:** Basic command line knowledge, Git installed

---

## 📋 What You'll Learn

By the end of this guide, you will:

1. ✅ Understand what this template is and why it exists
2. ✅ Fork and customize your own workspace
3. ✅ Create your first project using the framework
4. ✅ Know where to find help when you need it

---

## 🎯 Part 1: Understanding the Pieces (5 minutes)

Before we start, let's clarify what we're working with.

### The Three-Tier System

Think of this like a software supply chain:

```
┌─────────────────────────────────────────────────────┐
│ TIER 1: Claude-Dev-Framework (The Factory)          │
│ • GitHub repo: claude-dev-framework                 │
│ • Creates the tools (agents, commands, utilities)   │
│ • Maintained by: fda3r6sbvdgq09gse2                │
│ • You: NEVER modify this directly                   │
│ • Access: Via Claude Code marketplace               │
└─────────────────────────────────────────────────────┘
                        ↓ provides tools to
┌─────────────────────────────────────────────────────┐
│ TIER 2: Claude-Dev-Template (The Starter Kit)      │
│ • Minimal configuration to get started              │
│ • Maintained by: fda3r6sbvdgq09gse2                │
│ • You: Fork this once, then customize               │
│ • Access: Fork on GitHub                            │
└─────────────────────────────────────────────────────┘
                        ↓ forked to create
┌─────────────────────────────────────────────────────┐
│ TIER 3: Your Workspace (Your Company's Projects)   │
│ • Contains all your projects                        │
│ • Maintained by: YOU                                │
│ • You: Customize freely, add projects               │
│ • Access: Your private GitHub repository            │
└─────────────────────────────────────────────────────┘
```

### Real-World Analogy

**Framework (Tier 1)** = Microsoft Visual Studio (the IDE itself)
**Template (Tier 2)** = New Project Template (File → New Project → Console App)
**Your Workspace (Tier 3)** = Your actual code (YourAwesomeApp.sln)

When Microsoft releases Visual Studio 2024:
- ✅ You click "upgrade" and get new features
- ❌ Your code doesn't break
- ❌ Your project settings stay the same

That's exactly how this works!

---

## 🚀 Part 2: Setting Up Your Workspace (10 minutes)

### Step 1: Check Prerequisites

Open a terminal and verify you have everything:

```bash
# Check Git
git --version
# Should show: git version 2.x.x

# Check GitHub CLI (optional but recommended)
gh --version
# Should show: gh version 2.x.x

# Check Claude Code
claude --version
# Should show: Claude Code version x.x.x
```

**Don't have Claude Code?**
```bash
# macOS
brew install anthropic/tap/claude-code

# Or follow: https://docs.claude.com/en/docs/claude-code/installation
```

**Don't have GitHub CLI?**
```bash
# macOS
brew install gh

# Or follow: https://cli.github.com/
```

### Step 2: Fork the Template

**Option A: Using GitHub CLI (Recommended)**

```bash
# Fork and clone in one command
gh repo fork fda3r6sbvdgq09gse2/claude-workspace-template \
  --clone=true \
  --remote=true \
  --fork-name="blackford-workspace"

# Navigate into your fork
cd claude-workspace-template

# You now have:
# • A fork under YOUR GitHub account
# • A local clone on your computer
# • Remote 'origin' pointing to YOUR fork
# • Remote 'upstream' pointing to original template
```

**Option B: Using GitHub Web UI**

1. Go to: https://github.com/fda3r6sbvdgq09gse2/claude-workspace-template
2. Click the **Fork** button (top right)
3. Choose your account or organization
4. Name it: `blackford-workspace` (use your company name)
5. Click **Create Fork**
6. Clone your fork:
   ```bash
   gh repo clone blackford-inc/blackford-workspace
   cd blackford-workspace
   ```

### Step 3: Customize Your Workspace

This is the **most important step**. Open the master configuration file:

```bash
# Open in your favorite editor
vim STARTUP_VARIABLES.yaml
# or: code STARTUP_VARIABLES.yaml
# or: nano STARTUP_VARIABLES.yaml
```

**Find these lines and change them:**

```yaml
# BEFORE (Template Defaults)
startup:
  name: "STARTUP_NAME"                    # ← Change this!
  display_name: "Startup Name"            # ← Change this!
  github_org: "startup-github-org"        # ← Change this!
  description: "Company description here" # ← Change this!
  website: "https://example.com"          # ← Change this!
  contact_email: "dev@example.com"        # ← Change this!
```

```yaml
# AFTER (Your Company)
startup:
  name: "blackford"                       # Your company identifier (no spaces)
  display_name: "Blackford Industries"    # Human-readable name
  github_org: "blackford-inc"             # Your GitHub org
  description: "Building awesome software with AI assistance"
  website: "https://blackford.com"
  contact_email: "dev@blackford.com"
```

**Important Notes:**

- `startup.name` should be a valid identifier (no spaces, underscores OK)
- `startup.display_name` can have spaces and special characters
- `startup.github_org` should match your GitHub organization name

**Save the file!** (In vim: `:wq`, in nano: `Ctrl+X` then `Y`)

### Step 4: Commit Your Customization

```bash
# See what changed
git diff STARTUP_VARIABLES.yaml

# Stage your changes
git add STARTUP_VARIABLES.yaml

# Commit with a clear message
git commit -m "chore: Customize workspace for Blackford Industries"

# Push to YOUR fork
git push origin main
```

### Step 5: Verify Everything Works

```bash
# Check that settings file exists
cat .claude/settings.json

# Should show something like:
# {
#   "extraKnownMarketplaces": {
#     "Claude-Dev-Framework": {
#       "source": {
#         "source": "github",
#         "repo": "fda3r6sbvdgq09gse2/claude-dev-framework",
#         "ref": "v1.0.0"
#       }
#     }
#   }
# }
```

**✅ If you see that JSON, you're all set!**

---

## 🎨 Part 3: Creating Your First Project (5 minutes)

### Step 1: Navigate to Projects Directory

```bash
cd projects
ls -la

# You should see:
# README.md  ← Instructions for adding projects
```

### Step 2: Create a New Project

```bash
# Create project directory
mkdir my-first-project
cd my-first-project

# Initialize with a README
cat > README.md <<'EOF'
# My First Project

This is my first project using Claude-Dev-Framework!

## Description

[Describe what your project does]

## Status

- [ ] Project setup
- [ ] Core features
- [ ] Testing
- [ ] Documentation
EOF
```

### Step 3: Launch Claude Code

```bash
# Make sure you're in the project directory
pwd
# Should show: .../blackford-workspace/projects/my-first-project

# Launch Claude Code
claude
```

**What Happens:**
1. Claude Code starts
2. Reads `.claude/settings.json` from workspace root
3. Installs Claude-Dev-Framework marketplace (if not cached)
4. All framework agents become available!

### Step 4: Test the Framework

Inside Claude Code, try these commands:

```
# List available agents
/help

# You should see Claude-Dev-Framework agents like:
# • agent-backend     - Backend development specialist
# • agent-frontend    - Frontend development specialist
# • agent-testing     - Testing and QA specialist
# • agent-ceo         - Strategic planning coordinator
# • etc.
```

**Try creating a simple file:**

```
User: Create a Python hello world script

# Claude will use Claude-Dev-Framework to:
# 1. Understand your request
# 2. Use appropriate agent (agent-backend)
# 3. Create the file following framework patterns
```

**✅ Success!** You're now using Claude-Dev-Framework (the framework repo)!

---

## 🎓 Part 4: Understanding What You Just Did (5 minutes)

### The Configuration Flow

When you ran `claude` in your project:

```
1. Claude Code starts
       ↓
2. Looks for .claude/settings.json
       ↓ (finds it in workspace root)
3. Reads: "Install Claude-Dev-Framework marketplace"
       ↓
4. Fetches: github.com/fda3r6sbvdgq09gse2/claude-dev-framework @ v1.0.0
       ↓
5. Loads: All agents, commands, utilities
       ↓
6. Ready! Framework tools available
```

### The File Hierarchy

```
blackford-workspace/
├── .claude/
│   └── settings.json              ← Tells Claude: "Use framework v1.0.0"
├── STARTUP_VARIABLES.yaml         ← Your company config
└── projects/
    └── my-first-project/          ← Your project
        └── README.md              ← Your code
```

**When Claude runs:**
- Reads `.claude/settings.json` → Knows to load framework
- Reads `STARTUP_VARIABLES.yaml` → Knows your company name
- Works in `projects/my-first-project/` → Builds your project

### The Upgrade Path

**Current state:** You're using framework v1.0.0

**When v2.0.0 is released:**

```bash
# 1. Change one line in STARTUP_VARIABLES.yaml
vim STARTUP_VARIABLES.yaml
# Change: framework.version: "1.0.0"
# To:     framework.version: "2.0.0"

# 2. Sync the settings file
./scripts/upgrade-framework.sh v2.0.0

# 3. Restart Claude Code
claude
# Now using v2.0.0 with new features!
```

**What changes:**
- ✅ Framework code (agents, commands, utilities)
- ❌ Your company config (stays the same)
- ❌ Your projects (nothing breaks)

**That's the magic!** One-line upgrades.

---

## 🆘 Troubleshooting

### Problem: "Framework agents not found"

**Symptom:**
```
User: /agent-backend
Claude: Command not found
```

**Solution:**
```bash
# 1. Check settings file exists
cat .claude/settings.json

# 2. Check you're in a project directory (not workspace root)
pwd
# Should be: .../workspace/projects/YOUR_PROJECT

# 3. Restart Claude Code
exit  # (if in Claude Code)
claude

# 4. Verify framework loaded
# Look for: "Loaded marketplace: Claude-Dev-Framework"
```

### Problem: "Git push rejected"

**Symptom:**
```bash
git push origin main
# Error: permission denied
```

**Solution:**
```bash
# Check remote URL
git remote -v

# Should show YOUR fork, not the template:
# origin  git@github.com:YOUR_USERNAME/workspace.git

# If it shows the template URL, fix it:
git remote set-url origin git@github.com:YOUR_USERNAME/workspace.git

# Try push again
git push origin main
```

### Problem: "How do I update my fork when template changes?"

**Answer:**

```bash
# 1. Add upstream remote (if not already added)
git remote add upstream https://github.com/fda3r6sbvdgq09gse2/claude-workspace-template.git

# 2. Fetch template updates
git fetch upstream

# 3. Merge into your main
git merge upstream/main

# 4. Resolve conflicts (if any)
# Usually in STARTUP_VARIABLES.yaml - keep YOUR values

# 5. Push to your fork
git push origin main
```

### Problem: "I want to use a different framework version"

**Answer:**

```bash
# Check available versions
gh api repos/fda3r6sbvdgq09gse2/claude-dev-framework/git/refs/tags | jq '.[].ref'

# Change version in STARTUP_VARIABLES.yaml
vim STARTUP_VARIABLES.yaml
# Edit: framework.version: "x.x.x"

# Sync settings
./scripts/upgrade-framework.sh x.x.x

# Restart Claude Code
```

---

## 📚 Next Steps

Congratulations! You now have a fully functional workspace. Here's what to explore next:

### 1. Learn to Customize (15 minutes)
Read: [docs/CUSTOMIZATION.md](CUSTOMIZATION.md)
- Add team members
- Configure environments
- Set up project templates

### 2. Understand the Architecture (20 minutes)
Read: [docs/ARCHITECTURE.md](ARCHITECTURE.md)
- Deep dive into three-tier system
- Variable resolution order
- How the marketplace works

### 3. Plan Your First Real Project (30 minutes)
- Identify a problem to solve
- Create a new project directory
- Use Claude Code with framework agents
- Follow patterns from successful projects

### 4. Learn to Upgrade (10 minutes)
Read: [docs/UPGRADING.md](UPGRADING.md)
- When to upgrade
- How to test upgrades
- Rollback procedures

---

## 🎯 Quick Reference Card

**Fork Template:**
```bash
gh repo fork fda3r6sbvdgq09gse2/claude-workspace-template --fork-name="blackford-workspace"
```

**Customize:**
```bash
vim STARTUP_VARIABLES.yaml  # Change startup.name
```

**Create Project:**
```bash
cd projects && mkdir myproject && cd myproject
```

**Start Building:**
```bash
claude
```

**Upgrade Framework:**
```bash
vim STARTUP_VARIABLES.yaml  # Change framework.version
./scripts/upgrade-framework.sh NEW_VERSION
```

---

## 💡 Pro Tips

1. **Use Version Control**: Commit after every significant change
2. **Document Everything**: Future you will thank present you
3. **Test Upgrades**: Use a development environment first
4. **Contribute Back**: Found something useful? Share it!
5. **Ask for Help**: Framework issues? Open a GitHub issue

---

## 📞 Getting Help

**Template Questions:**
- GitHub Issues: https://github.com/fda3r6sbvdgq09gse2/claude-workspace-template/issues
- Documentation: [/docs](/docs)

**Framework Questions:**
- GitHub Issues: https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/issues
- Framework Docs: [Framework README](https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework)

**Claude Code Questions:**
- Official Docs: https://docs.claude.com/en/docs/claude-code
- Community Forum: https://community.anthropic.com

---

## ✅ Checklist: Did You Complete Everything?

- [ ] Installed prerequisites (Git, GitHub CLI, Claude Code)
- [ ] Forked the template to your account
- [ ] Customized STARTUP_VARIABLES.yaml with your company info
- [ ] Committed and pushed your changes
- [ ] Created your first project directory
- [ ] Launched Claude Code and verified framework loaded
- [ ] Tested creating a simple file
- [ ] Read this entire guide
- [ ] Know where to find help

**All checked?** You're ready to build! 🚀

---

*This guide is part of the Claude-Workspace-Template. For the complete documentation, see the [main README](../README.md).*

**Last Updated:** 2025-10-16
**Template Version:** 1.0.0
**Claude-Dev-Framework Version:** 1.0.0
**Framework Repository:** https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework
