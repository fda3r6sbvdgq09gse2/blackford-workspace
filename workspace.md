⏺ 🎯 World-Class Architecture Plan for Claude-Dev-Framework

  Executive Summary

  You've identified a critical architectural challenge: How do users 
  customize and extend a framework while maintaining upgradeability?

  After deep analysis of Claude Code architecture, GitHub capabilities, and
  MCP patterns, I'm proposing a three-tier hybrid architecture that
  separates:

  1. Framework (upgradeable, never forked)
  2. Template (lightweight, forked once)
  3. Projects (custom applications)

  Let me break this down systematically:

  ---
  📊 Current Problem Analysis

  What You Have Now (Fork-Based)

  Claude-Dev-Framework
      ├─ All framework code
      ├─ All plugins
      ├─ All configuration
      └─ VARIABLES.yaml (ORG_NAME)
           ↓ FORK (breaks upgrade path)
  Blackford_Inc-Framework
      ├─ Same code (diverges over time)
      ├─ Customized variables
      └─ book-cataloger/

  Problems:
  - ❌ Forking breaks upgrade path (merge conflicts)
  - ❌ Code duplication across all forks
  - ❌ Framework improvements don't flow to users
  - ❌ Each company maintains entire codebase

  ---
  🏗️ Proposed Architecture: The "Marketplace + Template" Pattern

  Three-Tier System

  ┌─────────────────────────────────────────────────────────────┐
  │ TIER 1: Claude-Dev-Framework (Plugin Marketplace)          │
  │ Repository: claude-dev-framework                            │
  │ Owner: fda3r6sbvdgq09gse2                                  │
  │ Purpose: Reusable framework (NEVER FORKED)                 │
  │ Type: Claude Code Plugin Marketplace                        │
  │ Upgradeable: Yes (users just update marketplace ref)       │
  └─────────────────────────────────────────────────────────────┘
                              ↓ installed via Claude Code
  ┌─────────────────────────────────────────────────────────────┐
  │ TIER 2: Claude-Dev-Template (Minimal Boilerplate)          │
  │ Repository: claude-dev-template                             │
  │ Owner: fda3r6sbvdgq09gse2                                  │
  │ Purpose: Starting point for companies (FORK THIS)          │
  │ Contains: VARIABLES.yaml, .claude/settings.json, docs      │
  │ Size: <100 files, mostly config                            │
  └─────────────────────────────────────────────────────────────┘
                              ↓ forked/cloned by companies
  ┌─────────────────────────────────────────────────────────────┐
  │ TIER 3: Blackford_Inc (Company Instance)                   │
  │ Repository: blackford-inc-workspace                         │
  │ Owner: User's company account                               │
  │ Contains: Projects (book-cataloger, etc.)                  │
  │ References: Claude-Dev-Framework v1.0                       │
  └─────────────────────────────────────────────────────────────┘

  ---
  📝 Detailed Architecture

  Tier 1: Claude-Dev-Framework (Plugin Marketplace)

  What It Is:
  - NOT meant to be forked
  - Installed as a Claude Code plugin marketplace
  - Contains all reusable framework code

  Structure:
  claude-dev-framework/
  ├─ .claude-plugin/
  │  └─ marketplace.json          # Marketplace manifest
  ├─ plugins/
  │  ├─ agent-backend/
  │  ├─ agent-frontend/
  │  ├─ agent-ceo/
  │  └─ ... (all agents)
  ├─ docs/
  ├─ VARIABLES_REFERENCE.md       # Documentation of variables
  ├─ README.md                    # Framework documentation
  └─ CHANGELOG.md                 # Version history

  How Users Install:
  // .claude/settings.json (in user's workspace)
  {
    "extraKnownMarketplaces": {
      "Claude-Dev-Framework": {
        "source": {
          "source": "github",
          "repo": "fda3r6sbvdgq09gse2/claude-dev-framework",
          "ref": "v1.0.0"  // ← Pin to version!
        }
      }
    }
  }

  Upgrading:
  // Just change the ref!
  "ref": "v1.0.0"  →  "ref": "v2.0.0"

  Tier 2: Claude-Dev-Template (Minimal Boilerplate)

  What It Is:
  - Lightweight starting point
  - THIS is what companies fork/clone
  - Contains configuration, not code

  Structure:
  claude-dev-template/
  ├─ .claude/
  │  └─ settings.json             # Points to Claude-Dev-Framework
  marketplace
  ├─ STARTUP_VARIABLES.yaml       # Company-specific config
  ├─ projects/                    # Where projects live
  │  └─ README.md
  ├─ docs/
  │  ├─ QUICK_START.md
  │  └─ CUSTOMIZATION.md
  └─ README.md                    # How to use this template

  STARTUP_VARIABLES.yaml:
  # Company/Startup Configuration
  # Fork this template and customize these values

  startup:
    name: "STARTUP_NAME"          # Change to "Blackford_Inc"
    display_name: "Blackford Inc"
    github_org: "blackford-inc"

  framework:
    source: "Claude-Dev-Framework"
    version: "1.0.0"               # Can upgrade later
    marketplace_repo: "fda3r6sbvdgq09gse2/claude-dev-framework"

  projects:
    - name: "book-cataloger"
      description: "Book cataloging system"
      directory: "./projects/book-cataloger"

  How Companies Use:
  # 1. Clone template
  git clone https://github.com/fda3r6sbvdgq09gse2/claude-dev-template
  blackford-inc-workspace

  # 2. Customize
  cd blackford-inc-workspace
  vim STARTUP_VARIABLES.yaml
  # Change STARTUP_NAME to "Blackford_Inc"

  # 3. Create new repo
  gh repo create blackford-inc/workspace --private
  git remote set-url origin git@github.com:blackford-inc/workspace.git
  git push

  # 4. Start building projects
  cd projects
  mkdir book-cataloger
  cd book-cataloger
  # Build your project using Claude Code with framework agents

  Tier 3: Blackford_Inc (Company Workspace)

  What It Is:
  - Forked from template
  - Company-specific customization
  - Contains all company projects

  Structure:
  blackford-inc-workspace/
  ├─ .claude/
  │  └─ settings.json             # References Claude-Dev-Framework v1.0
  ├─ STARTUP_VARIABLES.yaml       # startup.name = "Blackford_Inc"
  ├─ projects/
  │  ├─ book-cataloger/          # Project 1
  │  │  ├─ src/
  │  │  ├─ tests/
  │  │  └─ PROJECT_VARIABLES.yaml
  │  ├─ inventory-system/        # Project 2
  │  └─ customer-portal/         # Project 3
  └─ docs/
     └─ company-specific-docs.md

  PROJECT_VARIABLES.yaml (per project):
  # Project-specific configuration
  project:
    name: "book-cataloger"
    version: "0.1.0"
    description: "Personal library management system"

  # Inherits from parent STARTUP_VARIABLES.yaml
  inherits:
    startup_config: "../../STARTUP_VARIABLES.yaml"

  # Project-specific overrides
  team:
    lead: "Alice"
    agents_used:
      - "backend"
      - "frontend"
      - "testing"

  ---
  🔄 Upgrade Flow

  Scenario: Claude-Dev-Framework v1.0 → v2.0

  Step 1: User develops with v1.0
  # Blackford_Inc uses Claude-Dev-Framework v1.0
  # Works on book-cataloger project
  # Learns what works, what doesn't

  Step 2: Learnings → Framework v2.0
  # You (fda3r6sbvdgq09gse2) extract learnings
  # Improve Claude-Dev-Framework
  # Tag new release: v2.0.0
  git tag v2.0.0
  git push --tags

  Step 3: Blackford_Inc upgrades
  # In blackford-inc-workspace
  cd blackford-inc-workspace

  # Option A: Conservative (test first)
  vim .claude/settings.json
  # Change: "ref": "v1.0.0"
  # To:     "ref": "v2.0.0-beta"  # Test in beta
  # Test with projects...
  # If good: change to "v2.0.0"

  # Option B: Automatic (CI/CD)
  ./scripts/upgrade-framework.sh v2.0.0
  # Runs tests, validates, updates ref

  What Gets Updated:
  - ✅ All framework agents (from marketplace)
  - ✅ All framework commands
  - ✅ Documentation references
  - ❌ NOT your company config (STARTUP_VARIABLES.yaml stays same)
  - ❌ NOT your projects (book-cataloger unchanged)

  ---
  🎛️ Variable Hierarchy

  Three levels of variables:

  # FRAMEWORK (Claude-Dev-Framework - never modified)
  framework:
    name: "ClaudeDevFramework"
    display_name: "Claude Multi-Agent Development Framework"
    version: "1.0.0"
    author: "fda3r6sbvdgq09gse2"

  # STARTUP (Blackford_Inc - modified at fork time)
  startup:
    name: "Blackford_Inc"
    display_name: "Blackford Inc"
    github_org: "blackford-inc"

  # PROJECT (book-cataloger - modified per project)
  project:
    name: "book-cataloger"
    version: "0.1.0"
    team_lead: "Alice"

  Resolution Order:
  PROJECT_VARIABLES.yaml 
      ↓ (overrides)
  STARTUP_VARIABLES.yaml
      ↓ (overrides)
  FRAMEWORK defaults (from marketplace)

  ---
  🔧 Implementation Plan

  Phase 1: Restructure Current Repo

  Current: claude-dev-framework (everything mixed)
  Goal: Separate into marketplace + template

  # 1. Tag current state as v1.0-alpha
  git tag v1.0-alpha
  git push --tags

  # 2. Create marketplace branch (this becomes main)
  git checkout -b marketplace-only
  # Remove: template files, startup configs
  # Keep: plugins/, .claude-plugin/, docs/
  git commit -m "refactor: Convert to marketplace-only structure"

  # 3. Create template in new repo
  gh repo create fda3r6sbvdgq09gse2/claude-dev-template
  # Minimal structure with STARTUP_VARIABLES.yaml

  Phase 2: Create Template Repo

  # New repo: claude-dev-template
  mkdir claude-dev-template && cd claude-dev-template
  git init

  # Create structure
  mkdir -p .claude projects docs scripts
  touch STARTUP_VARIABLES.yaml
  touch .claude/settings.json
  touch README.md

  # .claude/settings.json template
  cat > .claude/settings.json <<'EOF'
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
  EOF

  # Push template
  git add . && git commit -m "Initial template"
  git push

  Phase 3: Test with Blackford_Inc

  # Clone template as Blackford_Inc
  git clone claude-dev-template blackford-inc-workspace

  # Customize
  cd blackford-inc-workspace
  vim STARTUP_VARIABLES.yaml
  # Set startup.name = "Blackford_Inc"

  # Create book-cataloger project
  cd projects
  mkdir book-cataloger
  # Develop with Claude Code
  # Framework agents are loaded from marketplace

  Phase 4: Extract Learnings → v2.0

  # After book-cataloger is complete
  # Compare: What did you change in Blackford_Inc?
  # Extract: Generic improvements
  # Update: claude-dev-framework repo

  cd claude-dev-framework
  # Make improvements
  git commit -m "feat: Improvements from book-cataloger learnings"
  git tag v2.0.0
  git push --tags

  # Blackford_Inc can now upgrade
  cd blackford-inc-workspace
  vim .claude/settings.json
  # Change ref to v2.0.0

  ---
  🚀 Advanced: MCP Server Option

  For even more dynamic upgrades:

  Architecture with MCP

  ┌────────────────────────────────────────────┐
  │ Claude-Dev-Framework-MCP-Server            │
  │ (Dynamic, real-time upgrades)              │
  │ Provides: Tools, context, AI coordination  │
  └────────────────────────────────────────────┘
                 ↓ mcp install
  ┌────────────────────────────────────────────┐
  │ Blackford_Inc Workspace                    │
  │ .claude/settings.json → MCP server config  │
  │ STARTUP_VARIABLES.yaml                     │
  │ projects/book-cataloger/                   │
  └────────────────────────────────────────────┘

  MCP Configuration:
  // .claude/mcp.json
  {
    "mcpServers": {
      "claude-dev-framework": {
        "command": "npx",
        "args": [
          "-y",
          "@fda3r6sbvdgq09gse2/claude-dev-framework-mcp@latest"
        ],
        "env": {
          "STARTUP_NAME": "Blackford_Inc"
        }
      }
    }
  }

  Benefits:
  - Real-time upgrades (just restart Claude Code)
  - No version pinning needed
  - Framework can be more dynamic
  - Can fetch context from APIs

  Tradeoffs:
  - More complex setup
  - Requires Node.js/npm
  - Network dependency

  ---
  📊 Comparison Matrix

  | Aspect           | Fork-Based               | Marketplace + Template  |
  MCP Server          |
  |------------------|--------------------------|-------------------------|-
  --------------------|
  | Upgrade Ease     | ❌ Hard (merge conflicts) | ✅ Easy (change version)
  | ✅ Instant (restart) |
  | Customization    | ✅ Full control           | ✅ Config-based
  | ⚠️ Limited          |
  | Code Duplication | ❌ High                   | ✅ Minimal
  | ✅ None              |
  | Setup Complexity | ✅ Simple                 | ✅ Simple
  | ⚠️ Medium           |
  | Offline Work     | ✅ Yes                    | ✅ Yes
  | ❌ No (needs server) |
  | Version Pinning  | ✅ Implicit               | ✅ Explicit
  | ⚠️ Auto-updates     |

  ---
  🎯 Recommended Solution

  Hybrid: Marketplace + Template + Optional MCP

  Core: Marketplace + Template (Tiers 1 & 2)
  Advanced: MCP server for dynamic features

  Claude-Dev-Framework (Marketplace)
      + Claude-Dev-Framework-MCP (Optional)
      ↓ installed into
  Claude-Dev-Template (Minimal boilerplate)
      ↓ forked as
  Blackford_Inc-Workspace
      ↓ contains
  Projects (book-cataloger, etc.)

  Why This Works:
  1. Marketplace = Stable, versioned framework
  2. Template = Lightweight, fork-friendly starting point
  3. MCP = Advanced dynamic features (opt-in)

  ---
  📋 Action Items

  Immediate (This Week)

  1. Create claude-dev-template repo
    - Minimal structure
    - STARTUP_VARIABLES.yaml
    - Documentation
  2. Refactor claude-dev-framework
    - Remove company-specific concepts
    - Focus on reusable plugins
    - Tag as v1.0.0
  3. Test fork flow
    - Clone template → Blackford_Inc
    - Build book-cataloger
    - Document pain points

  Short-term (Next Sprint)

  4. Build upgrade mechanism
    - Script to change framework version
    - Validation/testing
    - Rollback capability
  5. Document patterns
    - How to customize
    - How to upgrade
    - How to contribute back

  Long-term (Future)

  6. MCP server (if needed)
    - For real-time features
    - Optional enhancement
    - Advanced users

  ---
  🎓 Why This is World-Class

  Follows Industry Best Practices

  Like React:
  - Framework (react package) vs Template (create-react-app)
  - Users install framework, customize template
  - Upgrades via package manager

  Like Django:
  - Framework (django) vs Project (startproject template)
  - Separation of reusable code vs project structure
  - Clear upgrade path

  Like Claude Code Itself:
  - Plugin marketplaces for reusable components
  - Projects reference marketplaces
  - Version pinning for stability

  Andrej Karpathy Would Approve

  ✅ Clear separation of concerns
  ✅ Minimal duplication
  ✅ Easy upgrade path
  ✅ Scales to many users
  ✅ Follows platform conventions (Claude Code patterns)
  ✅ Well-documented
  ✅ Flexible (marketplace OR MCP)

  ---
  🔗 References

  - https://docs.claude.com/en/docs/claude-code/plugin-marketplaces
  - https://docs.claude.com/en/docs/claude-code/settings
  - https://modelcontextprotocol.io
  - https://docs.github.com/en/repositories/creating-and-managing-repositori
  es/creating-a-template-repository

  ---
  💡 Next Steps

  What do you want to tackle first?

  1. Create the template repo structure?
  2. Refactor current repo to pure marketplace?
  3. Design the STARTUP_VARIABLES.yaml schema?
  4. Build the upgrade script?
  5. Document the complete architecture?

  Let me know and I'll execute with world-class thoroughness! 🚀