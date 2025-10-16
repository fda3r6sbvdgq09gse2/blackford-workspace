# Customization Guide

**Audience:** Developers who want to tailor their workspace
**Prerequisites:** Completed [Quick Start Guide](QUICK_START.md)
**Time Required:** 30-45 minutes

---

## 🎯 Overview

This guide covers **everything you can customize** in your Claude-Dev-Template workspace to fit your company's needs.

### What You'll Learn

1. ✅ Deep dive into `STARTUP_VARIABLES.yaml` structure
2. ✅ How to configure per-project settings with `PROJECT_VARIABLES.yaml`
3. ✅ Team member configuration and role assignment
4. ✅ Environment-specific configurations (dev, staging, prod)
5. ✅ Advanced patterns for multi-project workspaces
6. ✅ Custom scripts and automation

---

## 📁 Configuration File Hierarchy

```
blackford-workspace/  # Your company workspace
├── .claude/
│   └── settings.json              # [AUTO-GENERATED] Don't edit directly
├── STARTUP_VARIABLES.yaml         # [PRIMARY] Edit this
└── projects/
    ├── project-a/
    │   └── PROJECT_VARIABLES.yaml # [OPTIONAL] Per-project overrides
    └── project-b/
        └── PROJECT_VARIABLES.yaml # [OPTIONAL] Per-project overrides
```

**Resolution Order** (later overrides earlier):
```
Claude-Dev-Framework defaults
    ↓ (overridden by)
STARTUP_VARIABLES.yaml
    ↓ (overridden by)
PROJECT_VARIABLES.yaml
```

---

## 🏗️ Part 1: STARTUP_VARIABLES.yaml Deep Dive

This file is the **single source of truth** for your entire workspace.

### Section 1: Startup Information

```yaml
startup:
  name: "blackford"                  # REQUIRED: Company identifier (no spaces)
  display_name: "Blackford Industries" # REQUIRED: Human-readable name
  github_org: "blackford-inc"        # REQUIRED: GitHub organization
  description: "Building innovative software" # Optional but recommended
  website: "https://blackford.com"   # Optional
  contact_email: "dev@blackford.com" # Optional

  # Usage tracking (where this variable is used)
  _used_in:
    - "[[README.md:line]]"
    - "[[docs/CUSTOMIZATION.md:line]]"
    - "[[projects/*/PROJECT_VARIABLES.yaml:line]]"
```

**Field Guidelines:**

| Field | Type | Pattern | Example | Notes |
|-------|------|---------|---------|-------|
| `name` | string | `[A-Za-z0-9_-]+` | `blackford` | Used in code, no spaces |
| `display_name` | string | Any | `Blackford Industries` | Used in documentation |
| `github_org` | string | GitHub username | `blackford-inc` | Must match GitHub org |
| `description` | string | Any | `Building...` | Appears in READMEs |
| `website` | URL | `https://...` | `https://...` | Company website |
| `contact_email` | email | `user@domain` | `dev@...` | Technical contact |

**Example: Startup Company**

```yaml
startup:
  name: "MyStartup"
  display_name: "My Awesome Startup"
  github_org: "mystartup"
  description: "Disrupting the widget industry with AI"
  website: "https://mystartup.io"
  contact_email: "eng@mystartup.io"
```

**Example: Enterprise Division**

```yaml
startup:
  name: "bigcorp-ailabs"
  display_name: "BigCorp AI Labs"
  github_org: "bigcorp-ailabs"
  description: "Research and development division"
  website: "https://ailabs.bigcorp.com"
  contact_email: "ailabs@bigcorp.com"
```

**Example: Solo Developer**

```yaml
startup:
  name: "JohnDoe_Projects"
  display_name: "John Doe's Projects"
  github_org: "johndoe"
  description: "Personal development projects"
  website: "https://johndoe.dev"
  contact_email: "john@johndoe.dev"
```

### Section 2: Framework Configuration

```yaml
framework:
  # Framework source - refers to the GitHub repository
  # Repository: github.com/fda3r6sbvdgq09gse2/claude-dev-framework
  source: "Claude-Dev-Framework"
  display_name: "Claude-Dev-Framework"  # Framework repo name

  # Version pinning
  version: "1.0.0"                     # CHANGE THIS to upgrade
  marketplace_repo: "fda3r6sbvdgq09gse2/claude-dev-framework"

  # Installation type
  installation_type: "marketplace"     # marketplace | git | mcp

  # Upgrade strategy
  auto_upgrade: false                  # Set to true for automatic upgrades
  upgrade_channel: "stable"            # stable | beta | latest

  _used_in:
    - "[[.claude/settings.json:4]]"   # extraKnownMarketplaces config
```

**Version Pinning Strategies:**

| Strategy | Configuration | Use Case |
|----------|---------------|----------|
| **Locked** | `version: "1.0.0"` | Production: stability required |
| **Minor Updates** | `version: "1.x"` | Automatic patches, manual major |
| **Beta Testing** | `version: "2.0.0-beta"` | Test upcoming features |
| **Latest** | `version: "latest"` | Development only (risky!) |

**Example: Production-Safe Configuration**

```yaml
framework:
  source: "Claude-Dev-Framework"
  display_name: "Claude-Dev-Framework"
  version: "1.0.0"                     # Locked to stable
  marketplace_repo: "fda3r6sbvdgq09gse2/claude-dev-framework"
  installation_type: "marketplace"
  auto_upgrade: false                  # Manual upgrades only
  upgrade_channel: "stable"
```

**Example: Development-Edge Configuration**

```yaml
framework:
  source: "Claude-Dev-Framework"
  display_name: "Claude-Dev-Framework"
  version: "2.0.0-beta"                # Testing next version
  marketplace_repo: "fda3r6sbvdgq09gse2/claude-dev-framework"
  installation_type: "marketplace"
  auto_upgrade: true                   # Auto-update to latest beta
  upgrade_channel: "beta"
```

### Section 3: Projects Registry

```yaml
projects:
  - name: "book-cataloger"
    description: "Personal library management system"
    directory: "./projects/book-cataloger"
    status: "active"                   # active | paused | archived
    team_lead: "Alice"
    agents_used:
      - "backend"
      - "frontend"
      - "testing"
    started: "2025-10-01"
    repository: "https://github.com/blackford-inc/book-cataloger"

  - name: "inventory-system"
    description: "Warehouse inventory tracking"
    directory: "./projects/inventory-system"
    status: "active"
    team_lead: "Bob"
    agents_used:
      - "backend"
      - "integration"
      - "testing"
      - "devops"
    started: "2025-09-15"
    repository: "https://github.com/blackford-inc/inventory-system"
```

**Project Fields:**

| Field | Required | Type | Purpose |
|-------|----------|------|---------|
| `name` | ✅ Yes | string | Project identifier |
| `description` | ✅ Yes | string | What does it do? |
| `directory` | ✅ Yes | path | Relative path from workspace root |
| `status` | ⚠️ Recommended | enum | `active`, `paused`, `archived` |
| `team_lead` | No | string | Who's responsible? |
| `agents_used` | No | array | Which Claude-Dev-Framework agents? |
| `started` | No | date | When did this project start? |
| `repository` | No | URL | Project repository URL |

### Section 4: Team Configuration

```yaml
team:
  # Default agents for all projects
  default_agents:
    - "backend"
    - "frontend"
    - "integration"
    - "testing"

  # Team members (optional)
  members:
    - name: "Alice Johnson"
      role: "Lead Developer"
      github: "alice-j"
      focus: ["backend", "integration"]
      availability: "full-time"

    - name: "Bob Smith"
      role: "Frontend Developer"
      github: "bsmith"
      focus: ["frontend", "ui"]
      availability: "full-time"

    - name: "Carol Wu"
      role: "QA Engineer"
      github: "cwu"
      focus: ["testing", "qa"]
      availability: "full-time"

    - name: "David Lee"
      role: "DevOps Engineer"
      github: "dlee"
      focus: ["devops", "infrastructure"]
      availability: "part-time"
```

**Team Member Fields:**

| Field | Purpose | Example |
|-------|---------|---------|
| `name` | Full name | `"Alice Johnson"` |
| `role` | Job title | `"Lead Developer"` |
| `github` | GitHub username | `"alice-j"` |
| `focus` | Specializations | `["backend", "integration"]` |
| `availability` | Work schedule | `"full-time"` or `"part-time"` |

**Use Cases for Team Config:**

1. **Documentation**: Auto-generate team lists in READMEs
2. **Assignment**: Know who to ask about which projects
3. **Metrics**: Track which agents are used most
4. **Onboarding**: New team members see who does what

### Section 5: Environment Configuration

```yaml
environments:
  development:
    default: true
    framework_version: "2.0.0-beta"    # Test latest features
    auto_upgrade: true
    debug_mode: true

  staging:
    enabled: true
    framework_version: "1.9.0"         # One version behind
    auto_upgrade: false
    debug_mode: false

  production:
    enabled: true
    framework_version: "1.8.0"         # Proven stable
    auto_upgrade: false
    debug_mode: false
    require_approval: true              # Manual approval for changes
```

**Environment Best Practices:**

```
Development → Staging → Production
   (beta)   →  (stable-1) → (stable-2)
```

- **Development**: Latest features, automatic upgrades
- **Staging**: One version behind, manual upgrades
- **Production**: Two versions behind, requires approval

---

## 📝 Part 2: PROJECT_VARIABLES.yaml

Each project can have its own configuration file that **overrides** workspace defaults.

### Basic PROJECT_VARIABLES.yaml

```yaml
# projects/book-cataloger/PROJECT_VARIABLES.yaml

project:
  name: "book-cataloger"
  version: "0.1.0"
  description: "Personal library management system with ISBN scanning"
  status: "active"

# Inherit from workspace
inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"

# Project-specific overrides
team:
  lead: "Alice"
  members: ["Alice", "Bob"]
  agents_used:
    - "backend"      # Python API development
    - "frontend"     # Tkinter UI
    - "testing"      # pytest test suite

# Technology stack
stack:
  language: "python"
  version: "3.11+"
  framework: "tkinter"
  testing: "pytest"
  dependencies:
    - "opencv-python"
    - "openpyxl"
    - "requests"

# Project-specific configuration
features:
  - "isbn-scanning"
  - "metadata-enrichment"
  - "spreadsheet-export"

milestones:
  - version: "0.1.0"
    description: "Basic ISBN scanning"
    due: "2025-11-01"
    status: "in_progress"
  - version: "0.2.0"
    description: "API integration"
    due: "2025-11-15"
    status: "planned"
```

### Advanced PROJECT_VARIABLES.yaml

```yaml
# projects/inventory-system/PROJECT_VARIABLES.yaml

project:
  name: "inventory-system"
  version: "1.2.3"
  description: "Enterprise warehouse inventory tracking"
  status: "active"
  criticality: "high"              # Mission-critical system

# Inherit from workspace
inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"

# Override framework version for this project
framework:
  version: "1.0.0"                 # This project uses older stable version
  upgrade_blocked: true            # Don't auto-upgrade
  upgrade_reason: "Production system, requires testing"

# Team (override workspace defaults)
team:
  lead: "Bob"
  members: ["Bob", "Carol", "David"]
  agents_used:
    - "backend"
    - "integration"
    - "testing"
    - "devops"                     # This project needs DevOps
  rotation:                        # On-call rotation
    - week: 1
      primary: "Bob"
      backup: "Carol"
    - week: 2
      primary: "Carol"
      backup: "Bob"

# Technology stack
stack:
  language: "python"
  version: "3.10"                  # Specific version requirement
  framework: "fastapi"
  database: "postgresql"
  cache: "redis"
  queue: "celery"
  testing: "pytest"
  ci_cd: "github-actions"

# External integrations
integrations:
  - name: "warehouse-management"
    type: "rest-api"
    endpoint: "https://wms.example.com/api"
    auth: "api-key"
  - name: "shipping-provider"
    type: "soap"
    endpoint: "https://shipping.example.com/soap"
    auth: "certificate"

# Deployment configuration
deployment:
  environments:
    - name: "development"
      url: "https://dev-inventory.blackford.com"
      auto_deploy: true
    - name: "staging"
      url: "https://staging-inventory.blackford.com"
      auto_deploy: false
    - name: "production"
      url: "https://inventory.blackford.com"
      auto_deploy: false
      requires_approval: true

# Monitoring and alerting
monitoring:
  health_check: "https://inventory.blackford.com/health"
  metrics_dashboard: "https://grafana.blackford.com/inventory"
  alert_email: "ops@blackford.com"
  alert_slack: "#inventory-alerts"

# Documentation links
documentation:
  architecture: "./docs/ARCHITECTURE.md"
  api_docs: "https://inventory.blackford.com/docs"
  runbook: "./docs/RUNBOOK.md"
```

---

## 🎨 Part 3: Common Customization Patterns

### Pattern 1: Multi-Team Workspace

For companies with multiple teams working on different projects:

```yaml
# STARTUP_VARIABLES.yaml

startup:
  name: "bigcorp"
  display_name: "BigCorp Engineering"
  github_org: "bigcorp"

# Teams (plural)
teams:
  - name: "platform"
    display_name: "Platform Team"
    lead: "Alice"
    projects: ["auth-service", "api-gateway"]
    agents: ["backend", "devops", "integration"]

  - name: "mobile"
    display_name: "Mobile Team"
    lead: "Bob"
    projects: ["ios-app", "android-app"]
    agents: ["frontend", "testing"]

  - name: "data"
    display_name: "Data Team"
    lead: "Carol"
    projects: ["data-pipeline", "ml-models"]
    agents: ["backend", "testing", "integration"]

# Projects organized by team
projects:
  # Platform Team
  - name: "auth-service"
    team: "platform"
    directory: "./projects/platform/auth-service"

  - name: "api-gateway"
    team: "platform"
    directory: "./projects/platform/api-gateway"

  # Mobile Team
  - name: "ios-app"
    team: "mobile"
    directory: "./projects/mobile/ios-app"

  - name: "android-app"
    team: "mobile"
    directory: "./projects/mobile/android-app"

  # Data Team
  - name: "data-pipeline"
    team: "data"
    directory: "./projects/data/data-pipeline"

  - name: "ml-models"
    team: "data"
    directory: "./projects/data/ml-models"
```

**Directory Structure:**

```
bigcorp-workspace/
├── projects/
│   ├── platform/
│   │   ├── auth-service/
│   │   └── api-gateway/
│   ├── mobile/
│   │   ├── ios-app/
│   │   └── android-app/
│   └── data/
│       ├── data-pipeline/
│       └── ml-models/
```

### Pattern 2: Monorepo with Shared Libraries

For projects that share common code:

```yaml
# STARTUP_VARIABLES.yaml

projects:
  # Shared libraries
  - name: "common-utils"
    directory: "./shared/common-utils"
    type: "library"
    status: "active"
    consumers: ["project-a", "project-b", "project-c"]

  - name: "api-client"
    directory: "./shared/api-client"
    type: "library"
    status: "active"
    consumers: ["project-a", "project-c"]

  # Applications
  - name: "project-a"
    directory: "./projects/project-a"
    type: "application"
    dependencies: ["common-utils", "api-client"]

  - name: "project-b"
    directory: "./projects/project-b"
    type: "application"
    dependencies: ["common-utils"]

  - name: "project-c"
    directory: "./projects/project-c"
    type: "application"
    dependencies: ["common-utils", "api-client"]
```

**Directory Structure:**

```
workspace/
├── shared/
│   ├── common-utils/
│   │   ├── src/
│   │   └── PROJECT_VARIABLES.yaml
│   └── api-client/
│       ├── src/
│       └── PROJECT_VARIABLES.yaml
└── projects/
    ├── project-a/
    ├── project-b/
    └── project-c/
```

### Pattern 3: Client Project Management

For agencies/consultancies managing multiple client projects:

```yaml
# STARTUP_VARIABLES.yaml

startup:
  name: "AwesomeAgency"
  display_name: "Awesome Development Agency"
  github_org: "awesome-agency"

# Client configuration
clients:
  - name: "Client A"
    display_name: "Client A Corp"
    contact: "cto@clienta.com"
    contract_start: "2025-01-01"
    contract_end: "2025-12-31"
    projects: ["clienta-website", "clienta-api"]

  - name: "Client B"
    display_name: "Client B Industries"
    contact: "pm@clientb.com"
    contract_start: "2025-03-01"
    contract_end: "2026-02-28"
    projects: ["clientb-mobile-app"]

projects:
  - name: "clienta-website"
    client: "Client A"
    directory: "./projects/clienta/website"
    budget_hours: 200
    hours_used: 45

  - name: "clienta-api"
    client: "Client A"
    directory: "./projects/clienta/api"
    budget_hours: 300
    hours_used: 120

  - name: "clientb-mobile-app"
    client: "Client B"
    directory: "./projects/clientb/mobile-app"
    budget_hours: 500
    hours_used: 230
```

---

## 🔧 Part 4: Advanced Customization

### Custom Scripts Directory

Create reusable scripts for your workspace:

```bash
# scripts/create-project.sh
#!/bin/bash
# Usage: ./scripts/create-project.sh project-name "Project Description"

PROJECT_NAME=$1
PROJECT_DESC=$2
PROJECT_DIR="./projects/${PROJECT_NAME}"

mkdir -p "${PROJECT_DIR}"
cat > "${PROJECT_DIR}/PROJECT_VARIABLES.yaml" <<EOF
project:
  name: "${PROJECT_NAME}"
  version: "0.1.0"
  description: "${PROJECT_DESC}"
  status: "active"

inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"
EOF

cat > "${PROJECT_DIR}/README.md" <<EOF
# ${PROJECT_NAME}

${PROJECT_DESC}

## Status

- [ ] Initial setup
- [ ] Core features
- [ ] Testing
- [ ] Documentation
EOF

echo "✅ Created project: ${PROJECT_NAME}"
```

### Workspace Configuration Validation

```bash
# scripts/validate-config.sh
#!/bin/bash
# Validates STARTUP_VARIABLES.yaml structure

echo "Validating workspace configuration..."

# Check required fields
if ! grep -q "startup:" STARTUP_VARIABLES.yaml; then
  echo "❌ ERROR: Missing 'startup:' section"
  exit 1
fi

if ! grep -q "  name:" STARTUP_VARIABLES.yaml; then
  echo "❌ ERROR: Missing 'startup.name' field"
  exit 1
fi

echo "✅ Configuration is valid"
```

### Auto-Sync Settings

```bash
# scripts/sync-settings.sh
#!/bin/bash
# Syncs STARTUP_VARIABLES.yaml → .claude/settings.json

FRAMEWORK_VERSION=$(grep "version:" STARTUP_VARIABLES.yaml | head -1 | awk '{print $2}' | tr -d '"')
MARKETPLACE_REPO=$(grep "marketplace_repo:" STARTUP_VARIABLES.yaml | awk '{print $2}' | tr -d '"')

cat > .claude/settings.json <<EOF
{
  "\$schema": "https://api.claude.com/schemas/settings.json",
  "extraKnownMarketplaces": {
    "Claude-Dev-Framework": {
      "source": {
        "source": "github",
        "repo": "${MARKETPLACE_REPO}",
        "ref": "v${FRAMEWORK_VERSION}"
      }
    }
  }
}
EOF

echo "✅ Synced settings.json with STARTUP_VARIABLES.yaml"
```

---

## ✅ Best Practices

### DO ✅

1. **Keep STARTUP_VARIABLES.yaml as single source of truth**
   ```yaml
   # Good: All configuration in one place
   startup:
     name: "MyCompany"
     github_org: "mycompany"
   ```

2. **Use PROJECT_VARIABLES.yaml for project-specific overrides**
   ```yaml
   # Good: Project-specific configuration
   project:
     name: "my-project"
     version: "1.0.0"
   ```

3. **Document why you made customizations**
   ```yaml
   # Good: Explain non-obvious choices
   framework:
     version: "1.0.0"  # Locked because project X requires stability
   ```

4. **Version control all configuration files**
   ```bash
   git add STARTUP_VARIABLES.yaml
   git commit -m "config: Update team members"
   ```

5. **Validate configuration after changes**
   ```bash
   ./scripts/validate-config.sh
   ```

### DON'T ❌

1. **Don't edit .claude/settings.json directly**
   ```json
   // Bad: This file is auto-generated
   // Edit STARTUP_VARIABLES.yaml instead
   ```

2. **Don't hardcode values across multiple files**
   ```yaml
   # Bad: Duplicating company name
   # Use variables and references instead
   ```

3. **Don't use spaces in `startup.name`**
   ```yaml
   # Bad:
   startup:
     name: "My Company"  # ❌ Spaces cause issues

   # Good:
   startup:
     name: "My_Company"  # ✅ Underscores OK
   ```

4. **Don't upgrade framework versions without testing**
   ```yaml
   # Bad: Jumping to latest without testing
   framework:
     version: "latest"  # ❌ Dangerous!

   # Good: Test in development first
   framework:
     version: "1.0.0"   # ✅ Stable, tested
   ```

---

## 🎓 Next Steps

You've mastered customization! Here's what to explore next:

1. **[Upgrading Guide](UPGRADING.md)** - Learn to upgrade Claude-Dev-Framework versions
2. **[Architecture Guide](ARCHITECTURE.md)** - Understand the system deeply
3. **[Quick Start Guide](QUICK_START.md)** - Review the basics if needed

---

## 📞 Support

**Questions about customization?**
- GitHub Issues: https://github.com/fda3r6sbvdgq09gse2/claude-workspace-template/issues
- Framework Repo: https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework

---

*This guide is part of the Claude-Workspace-Template documentation.*

**Last Updated:** 2025-10-16
**Template Version:** 1.0.0
**Claude-Dev-Framework Version:** 1.0.0
