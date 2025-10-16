# Architecture Guide: Claude-Dev-Framework Ecosystem

**Audience:** Software architects, framework maintainers, senior engineers
**Time Required:** 30-45 minutes
**Purpose:** Deep understanding of the three-tier architecture

---

## 🎯 Executive Summary

This document explains the **three-tier architecture** that enables:
- Framework reusability without forking
- Company-specific customization
- Zero-conflict upgrades
- Knowledge compounding across projects

**Key Innovation:** Separation of framework (reusable) from template (starting point) from workspace (your instance).

---

## 🏗️ The Three-Tier Architecture

### Overview Diagram

```
┌────────────────────────────────────────────────────────────┐
│ TIER 1: claude-dev-framework                               │
│ Type: Plugin Marketplace                                   │
│ Owner: fda3r6sbvdgq09gse2                                 │
│ Purpose: Reusable framework components                    │
│ Install Method: Claude Code marketplace                    │
│ Update Method: Change version ref                         │
│ Fork: NEVER                                                │
└────────────────────────────────────────────────────────────┘
                          ↓ provides tools to
┌────────────────────────────────────────────────────────────┐
│ TIER 2: claude-workspace-template                          │
│ Type: Template Repository                                  │
│ Owner: fda3r6sbvdgq09gse2                                 │
│ Purpose: Starting point for companies                     │
│ Install Method: Fork on GitHub                            │
│ Update Method: git pull upstream                          │
│ Fork: ONCE (to create your workspace)                     │
└────────────────────────────────────────────────────────────┘
                          ↓ forked as
┌────────────────────────────────────────────────────────────┐
│ TIER 3: blackford-workspace                                │
│ Type: Company Workspace                                    │
│ Owner: blackford-inc (your company)                       │
│ Purpose: Your projects + customized config                │
│ Install Method: Your private repository                   │
│ Update Method: Edit STARTUP_VARIABLES.yaml                │
│ Fork: Never (this IS your workspace)                      │
└────────────────────────────────────────────────────────────┘
```

---

## 📊 Tier 1: Claude-Dev-Framework (Marketplace)

### Purpose

**Provides:** Reusable development tools (agents, commands, utilities)
**Analogy:** Like npm packages or Python libraries
**Users:** All companies using the framework

### Structure

```
claude-dev-framework/
├── .claude-plugin/
│   └── marketplace.json           # Marketplace manifest
├── plugins/
│   ├── agent-backend/
│   │   └── .claude-plugin/
│   │       └── plugin.json        # Backend agent definition
│   ├── agent-frontend/
│   ├── agent-testing/
│   └── ... (11 total plugins)
├── VARIABLES.yaml                 # Framework configuration
├── VARIABLE_LINKS.md              # Knowledge graph (framework level)
├── NAMING.md                      # Naming conventions
└── docs/
    └── VARIABLES_REFERENCE.md     # Complete variable reference
```

### How It's Installed

**Method 1: Via Claude Code Marketplace (Recommended)**

```json
// user-workspace/.claude/settings.json
{
  "extraKnownMarketplaces": {
    "Claude-Dev-Framework": {
      "source": {
        "source": "github",
        "repo": "fda3r6sbvdgq09gse2/claude-dev-framework",
        "ref": "v1.0.0"  // ← Version pinning
      }
    }
  }
}
```

**When Claude Code starts:**
1. Reads `.claude/settings.json`
2. Fetches framework from GitHub @ v1.0.0
3. Loads all plugins from `plugins/` directory
4. Makes agents available: `/agent-backend`, `/agent-frontend`, etc.

**Method 2: Via MCP Server (Advanced)**

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

### Upgrade Flow

```bash
# Tier 1 maintainer releases v2.0.0
cd claude-dev-framework
git tag v2.0.0
git push --tags

# Tier 3 user upgrades instantly
cd blackford-workspace
vim STARTUP_VARIABLES.yaml  # version: "1.0.0" → "2.0.0"
./scripts/upgrade-framework.sh v2.0.0
# Done! Framework upgraded, projects unchanged
```

### Why This Tier Exists

**Problem Solved:** Code duplication, upgrade conflicts

**Before (traditional approach):**
- 100 companies fork framework
- Each maintains full copy
- Framework improvements don't propagate
- Merge conflicts when upgrading

**After (marketplace approach):**
- 100 companies reference framework
- Framework lives in one place
- Improvements flow to everyone
- Upgrade = change version number

---

## 📋 Tier 2: Claude-Workspace-Template (Boilerplate)

### Purpose

**Provides:** Minimal configuration boilerplate
**Analogy:** Like `create-react-app` or `django-admin startproject`
**Users:** Companies starting new workspace

### Structure

```
claude-workspace-template/
├── STARTUP_VARIABLES.yaml         # ⚠️ Single source of truth
├── .claude/
│   └── settings.json              # Framework reference (auto-synced)
├── .ai/
│   ├── README.md                  # Knowledge graph docs
│   ├── templates/
│   │   └── PROJECT_VARIABLES.yaml # Project template
│   └── meta/                      # Knowledge compounding system
├── docs/
│   ├── QUICK_START.md
│   ├── CUSTOMIZATION.md
│   ├── UPGRADING.md
│   └── ARCHITECTURE.md            # ← You are here
├── projects/
│   └── README.md                  # How to add projects
└── scripts/
    └── upgrade-framework.sh       # Automated upgrades
```

### What's Included

**Configuration:**
- STARTUP_VARIABLES.yaml (template with placeholders)
- .claude/settings.json (framework reference)

**Documentation:**
- Complete guides for all user types
- Examples and best practices

**Templates:**
- PROJECT_VARIABLES.yaml (for new projects)
- Learning documentation template

**Scripts:**
- Automated framework upgrade
- (Future: project creation, validation, etc.)

### Why This Tier Exists

**Problem Solved:** "How do I get started?"

**Without template:**
- User must figure out all configuration
- Easy to misconfigure
- No best practices guidance
- Steep learning curve

**With template:**
- Fork → customize 3 variables → start building
- All best practices baked in
- Clear documentation
- 5-minute setup

---

## 🏢 Tier 3: Your Workspace (Company Instance)

### Purpose

**Provides:** Your company's development environment
**Analogy:** Your actual codebase
**Users:** Your team

### Structure

```
blackford-workspace/
├── STARTUP_VARIABLES.yaml         # ⚠️ CUSTOMIZED for Blackford
│   # startup.name: "blackford"
│   # github_org: "blackford-inc"
├── .claude/settings.json          # Points to framework v1.0.0
├── projects/
│   ├── book-cataloger/
│   │   ├── PROJECT_VARIABLES.yaml # Project config
│   │   ├── src/                   # Your code
│   │   └── tests/
│   ├── inventory-system/
│   │   ├── PROJECT_VARIABLES.yaml
│   │   └── src/
│   └── customer-portal/
├── .ai/
│   ├── patterns/                  # Patterns you discovered
│   │   ├── api-retry-logic.md
│   │   └── auth-pattern.md
│   └── meta/
│       └── learnings/             # Project learnings
│           ├── 2025-10-book-cataloger.md
│           └── 2025-11-inventory-system.md
└── (everything from template, customized)
```

### Customization Points

**Level 1: Required (5 minutes)**
```yaml
# STARTUP_VARIABLES.yaml
startup:
  name: "blackford"                # Your company
  github_org: "blackford-inc"      # Your GitHub org
```

**Level 2: Recommended (15 minutes)**
```yaml
# STARTUP_VARIABLES.yaml
startup:
  description: "Building innovative software..."
  website: "https://blackford.com"

team:
  members:
    - name: "Alice"
      role: "Lead Developer"
```

**Level 3: Advanced (1-2 hours)**
```yaml
# PROJECT_VARIABLES.yaml (per project)
project:
  name: "book-cataloger"

team:
  agents_used: ["backend", "testing"]  # Overrides workspace default

stack:
  language: "python"
  framework: "fastapi"
```

### Why This Tier Exists

**Problem Solved:** Company-specific needs

**Separation allows:**
- Framework: Generic, reusable
- Template: Starting point
- Workspace: Your specific needs

You can customize everything in Tier 3 without affecting Tier 1 or 2.

---

## 🔄 Data Flow: Variable Resolution

### The Inheritance Chain

```
┌─────────────────────────────────────────┐
│ Framework Defaults                       │
│ (Tier 1: claude-dev-framework)          │
│ • framework.name                        │
│ • framework.version                     │
│ • agent definitions                     │
└─────────────────────────────────────────┘
                 ↓ overridden by
┌─────────────────────────────────────────┐
│ Workspace Configuration                  │
│ (Tier 3: STARTUP_VARIABLES.yaml)       │
│ • startup.name = "blackford"            │
│ • startup.github_org = "blackford-inc" │
│ • team.default_agents                   │
└─────────────────────────────────────────┘
                 ↓ overridden by
┌─────────────────────────────────────────┐
│ Project Configuration                    │
│ (Tier 3: PROJECT_VARIABLES.yaml)       │
│ • project.name = "book-cataloger"       │
│ • team.agents_used (project-specific)   │
└─────────────────────────────────────────┘
```

### Example Resolution

**Scenario:** What agents are used for book-cataloger project?

**Step 1:** Check PROJECT_VARIABLES.yaml
```yaml
# projects/book-cataloger/PROJECT_VARIABLES.yaml
team:
  agents_used: ["backend", "testing"]  # ← Found! Use these
```

**Result:** Use `["backend", "testing"]`

**Step 2 (if not found):** Check STARTUP_VARIABLES.yaml
```yaml
# STARTUP_VARIABLES.yaml
team:
  default_agents: ["backend", "frontend", "integration"]  # ← Fallback
```

**Result:** Use `["backend", "frontend", "integration"]`

**Step 3 (if not found):** Use framework defaults

---

## 🕸️ Knowledge Graph Architecture

### The `_used_in` System

**Problem:** How do you know where a variable is used?

**Solution:** Every variable tracks its usage points

```yaml
# STARTUP_VARIABLES.yaml
startup:
  name: "blackford"

  # Knowledge graph: Obsidian-style links
  _used_in:
    - "[[README.md:1]]"              # Used in line 1
    - "[[projects/*/PROJECT_VARIABLES.yaml:inherits]]"  # Inherited by all projects
    - "[[.github/workflows/deploy.yml:12]]"  # Used in CI/CD
```

### How It Compounds

**Week 1:** Start with empty `_used_in`
```yaml
api_key: "secret"
_used_in: []
```

**Week 2:** Use it in code
```yaml
api_key: "secret"
_used_in:
  - "[[src/auth.py:10]]"
```

**Week 3:** Document it
```yaml
api_key: "secret"
_used_in:
  - "[[src/auth.py:10]]"
  - "[[docs/AUTH.md:api-section]]"
```

**Result:** The variable "knows" everywhere it's used!

---

## 🔧 Component Interactions

### Startup Sequence

```
1. User runs: cd projects/book-cataloger && claude
                    ↓
2. Claude Code starts
                    ↓
3. Reads: ../../.claude/settings.json
                    ↓
4. Fetches: claude-dev-framework @ v1.0.0 from GitHub
                    ↓
5. Loads: All plugins from framework
                    ↓
6. Reads: ../../STARTUP_VARIABLES.yaml (workspace config)
                    ↓
7. Reads: ./PROJECT_VARIABLES.yaml (project config)
                    ↓
8. Resolves: Variables (project → workspace → framework)
                    ↓
9. Ready: Agents available, configuration loaded
```

### Configuration Sync

```
STARTUP_VARIABLES.yaml
    ↓ (edited by user)
scripts/upgrade-framework.sh
    ↓ (syncs)
.claude/settings.json
    ↓ (read by Claude Code)
Framework loads with new version
```

### Project Creation

```
User: "I want to create a new project"
    ↓
Copy: .ai/templates/PROJECT_VARIABLES.yaml → projects/new-project/
    ↓
Customize: project.name, team, stack
    ↓
Add: inherits: { startup_config: "../../STARTUP_VARIABLES.yaml" }
    ↓
Result: Project inherits workspace config + has own overrides
```

---

## 🚀 Scaling Considerations

### Single Workspace, Multiple Projects

**Pattern:** All projects in one workspace

```
blackford-workspace/
├── projects/
│   ├── project-a/  # 10 developers
│   ├── project-b/  # 5 developers
│   └── project-c/  # 3 developers
└── STARTUP_VARIABLES.yaml  # Shared config
```

**Pros:**
- Single configuration source
- Easy to maintain consistency
- Framework version consistent across all projects

**Cons:**
- All projects must use same framework version
- Large workspaces can be slow

**Best For:** 1-10 projects, single team

### Multiple Workspaces

**Pattern:** Separate workspaces per environment or team

```
~/dev/
├── blackford-dev-workspace/      # Development
│   └── framework.version: "2.0.0-beta"
├── blackford-staging-workspace/  # Staging
│   └── framework.version: "1.9.0"
└── blackford-prod-workspace/     # Production
    └── framework.version: "1.8.0"
```

**Pros:**
- Different framework versions per environment
- Isolated changes
- Safer upgrades (test in dev first)

**Cons:**
- Must maintain multiple workspaces
- Configuration can diverge

**Best For:** Enterprises, multi-environment deployments

---

## 🔐 Security Architecture

### Secrets Management

**Never commit secrets to STARTUP_VARIABLES.yaml!**

```yaml
# STARTUP_VARIABLES.yaml ❌ DON'T DO THIS
api_key: "sk-1234567890abcdef"  # ❌ EXPOSED IN GIT
```

**Instead:**

```yaml
# STARTUP_VARIABLES.yaml ✅ DO THIS
api_key: "${API_KEY}"  # Reference environment variable

# .env (git-ignored)
API_KEY=sk-1234567890abcdef

# .gitignore
.env
*.key
*secret*
```

### Access Control

**Workspace Level:**
- Private GitHub repository
- Team access controls
- Branch protection rules

**Framework Level:**
- Public repository (marketplace)
- Community contributions welcome
- Maintainer approval required

---

## 📊 Performance Characteristics

### Startup Time

```
Without framework: ~1 second
With framework:    ~2-3 seconds

Breakdown:
- Fetch framework from GitHub: 1-2s (cached after first run)
- Load plugins: 0.5s
- Parse configuration: 0.5s
```

### Token Usage

```
Without knowledge graph: Variable lookup requires full file scan
With knowledge graph:     Direct jump to usage points

Example:
- Find all uses of "startup.name"
- Without _used_in: grep entire codebase (slow, high tokens)
- With _used_in: read array directly (fast, low tokens)
```

---

## 🎓 Design Patterns Used

### 1. Strategy Pattern
**Where:** Framework selection
**How:** `.claude/settings.json` defines which marketplace to use

### 2. Template Method Pattern
**Where:** Project creation
**How:** `.ai/templates/` provides method, user fills in details

### 3. Observer Pattern
**Where:** Knowledge graph
**How:** Variables "notify" via `_used_in` when they're referenced

### 4. Facade Pattern
**Where:** `upgrade-framework.sh`
**How:** Simple interface to complex upgrade process

### 5. Single Source of Truth Pattern
**Where:** STARTUP_VARIABLES.yaml
**How:** One authoritative source for all configuration

---

## 🔄 Evolution Path

### Current State (v1.0)

- Three-tier architecture
- Marketplace-based framework
- Template-based workspaces
- Manual configuration

### Near Future (v1.x)

- Automated template sync
- Configuration validation
- More templates (API projects, data pipelines, etc.)
- Better CLI tools

### Long-term (v2.x)

- MCP server for dynamic features
- Visual workspace management
- AI-powered configuration suggestions
- Community pattern marketplace

---

## 📚 Related Documentation

- [QUICK_START.md](QUICK_START.md) - Get started quickly
- [CUSTOMIZATION.md](CUSTOMIZATION.md) - Deep customization
- [UPGRADING.md](UPGRADING.md) - Upgrade procedures
- [../README.md](../README.md) - Overview

---

**Last Updated:** 2025-10-16
**Template Version:** 1.0.0
**Covers Architecture:** Three-Tier v1.0
