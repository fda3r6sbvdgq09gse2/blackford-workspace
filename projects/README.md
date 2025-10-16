# Projects Directory

**Purpose:** This directory contains all your company's projects that use Claude-Dev-Framework.

---

## 🎯 Quick Start

### Creating Your First Project

```bash
# 1. Navigate to projects directory
cd projects

# 2. Create project directory
mkdir my-project
cd my-project

# 3. Create PROJECT_VARIABLES.yaml (optional but recommended)
cat > PROJECT_VARIABLES.yaml <<'EOF'
# Project-specific configuration
project:
  name: "my-project"
  version: "0.1.0"
  description: "My awesome project"
  status: "active"

# Inherit from workspace configuration
inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"

# Team members working on this project
team:
  lead: "YourName"
  members: ["YourName"]
  agents_used:
    - "backend"
    - "frontend"
    - "testing"
EOF

# 4. Create initial README
cat > README.md <<'EOF'
# My Project

## Description

[Describe what your project does]

## Status

- [ ] Initial setup
- [ ] Core features
- [ ] Testing
- [ ] Documentation

## Team

- Lead: YourName

## Tech Stack

- Language: [Python/JavaScript/etc]
- Framework: [Framework name]
- Database: [If applicable]
EOF

# 5. Launch Claude Code
claude
```

**🎉 Your project is ready!** Claude-Dev-Framework agents are now available.

---

## 📁 Recommended Project Structure

Each project should follow this structure:

```
my-project/
├── PROJECT_VARIABLES.yaml      # Project-specific configuration (optional)
├── README.md                    # Project documentation
├── src/                         # Source code
│   ├── __init__.py             # (Python projects)
│   ├── main.py                 # Entry point
│   └── ...                     # Your code
├── tests/                       # Test files
│   ├── __init__.py
│   └── test_main.py
├── docs/                        # Additional documentation
│   ├── ARCHITECTURE.md
│   └── API.md
├── .gitignore                   # Git ignore rules
└── requirements.txt             # Dependencies (Python)
    or package.json              # Dependencies (Node.js)
    or go.mod                    # Dependencies (Go)
```

---

## 🎨 PROJECT_VARIABLES.yaml Template

Create a `PROJECT_VARIABLES.yaml` file in your project root to customize settings:

```yaml
# Project Configuration
# This file overrides workspace defaults for this specific project

project:
  name: "my-project"              # Project identifier
  version: "0.1.0"                # Semantic versioning
  description: "Project description"
  status: "active"                # active | paused | archived | completed

# Inherit from parent workspace
inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"

# Team configuration (overrides workspace defaults)
team:
  lead: "YourName"
  members:
    - "YourName"
    - "Teammate1"
  agents_used:
    - "backend"                   # Python/Go/Java backend development
    - "frontend"                  # React/Vue/UI development
    - "testing"                   # pytest/jest test automation
    - "integration"               # API integration work
    # - "devops"                  # Uncomment if needed
    # - "documentation"           # Uncomment if needed

# Technology stack
stack:
  language: "python"              # python | javascript | go | rust | etc
  version: "3.11+"                # Language version requirement
  framework: "fastapi"            # Framework (if applicable)
  database: "postgresql"          # Database (if applicable)
  testing: "pytest"               # Testing framework

# Project milestones
milestones:
  - version: "0.1.0"
    description: "MVP release"
    due: "2025-12-01"
    status: "in_progress"
  - version: "0.2.0"
    description: "Feature X implementation"
    due: "2025-12-15"
    status: "planned"

# External integrations
integrations:
  # - name: "stripe"
  #   type: "rest-api"
  #   endpoint: "https://api.stripe.com"
  # - name: "sendgrid"
  #   type: "email-api"

# Documentation links
documentation:
  architecture: "./docs/ARCHITECTURE.md"
  api_docs: "./docs/API.md"
  user_guide: "./docs/USER_GUIDE.md"
```

---

## 🔄 Variable Resolution Order

When Claude-Dev-Framework runs in your project, variables are resolved in this order:

```
1. PROJECT_VARIABLES.yaml (highest priority)
       ↓ overrides
2. STARTUP_VARIABLES.yaml (workspace level)
       ↓ overrides
3. Framework Defaults (from claude-dev-framework)
```

**Example:**

```yaml
# ../../STARTUP_VARIABLES.yaml
startup:
  name: "blackford"
team:
  default_agents: ["backend", "frontend"]

# ./PROJECT_VARIABLES.yaml
project:
  name: "book-cataloger"
team:
  agents_used: ["backend", "testing"]  # ← Overrides default_agents for this project
```

**Result:** This project uses `["backend", "testing"]` agents, not the workspace default.

---

## 🎯 Best Practices

### DO ✅

1. **Create PROJECT_VARIABLES.yaml for each project**
   - Helps track project-specific configuration
   - Makes onboarding new team members easier
   - Documents technology choices

2. **Use semantic versioning** (`major.minor.patch`)
   - `0.1.0` - Initial development
   - `1.0.0` - First production release
   - `1.1.0` - New features
   - `1.1.1` - Bug fixes

3. **Keep projects self-contained**
   - All code for the project lives in its directory
   - Use relative paths within the project
   - Document external dependencies

4. **Document team and ownership**
   - List who's responsible
   - Note which agents are most useful
   - Track project status

### DON'T ❌

1. **Don't create projects outside the projects/ directory**
   - Keep workspace organized
   - Framework expects projects here

2. **Don't duplicate STARTUP_VARIABLES.yaml**
   - Use `inherits:` to reference parent config
   - Only override what's different

3. **Don't hardcode workspace-level values**
   ```yaml
   # Bad:
   startup:
     name: "blackford"  # ❌ This belongs in STARTUP_VARIABLES.yaml

   # Good:
   inherits:
     startup_config: "../../STARTUP_VARIABLES.yaml"  # ✅ Reference parent
   ```

4. **Don't forget to update project status**
   - Mark projects as `paused` when not actively developing
   - Mark as `archived` when complete
   - Helps team understand project priorities

---

## 📊 Example Projects

### Web Application Project

```yaml
# projects/web-app/PROJECT_VARIABLES.yaml
project:
  name: "web-app"
  version: "1.0.0"
  description: "Customer-facing web application"

inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"

team:
  lead: "Alice"
  agents_used: ["backend", "frontend", "testing", "devops"]

stack:
  language: "javascript"
  framework: "nextjs"
  database: "postgresql"
  testing: "jest"
```

### CLI Tool Project

```yaml
# projects/cli-tool/PROJECT_VARIABLES.yaml
project:
  name: "cli-tool"
  version: "0.3.0"
  description: "Command-line utility for internal use"

inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"

team:
  lead: "Bob"
  agents_used: ["backend", "testing"]

stack:
  language: "go"
  version: "1.21+"
  testing: "go test"
```

### Data Pipeline Project

```yaml
# projects/data-pipeline/PROJECT_VARIABLES.yaml
project:
  name: "data-pipeline"
  version: "2.1.0"
  description: "ETL pipeline for analytics"

inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"

team:
  lead: "Carol"
  agents_used: ["backend", "integration", "testing"]

stack:
  language: "python"
  version: "3.11+"
  framework: "airflow"
  database: "postgresql"
  cache: "redis"
```

---

## 🔍 Finding Projects

### List All Projects

```bash
# From workspace root
ls -la projects/

# Or use tree (if installed)
tree projects/ -L 1
```

### Check Project Status

```bash
# From workspace root
grep -h "status:" projects/*/PROJECT_VARIABLES.yaml

# Output shows status of each project
```

### Find Projects by Language

```bash
# Find all Python projects
grep -l "language: \"python\"" projects/*/PROJECT_VARIABLES.yaml

# Find all JavaScript projects
grep -l "language: \"javascript\"" projects/*/PROJECT_VARIABLES.yaml
```

---

## 🚀 Advanced: Multi-Project Workflows

### Shared Libraries

If you have shared code across projects:

```
projects/
├── _shared/
│   ├── common-utils/
│   │   ├── src/
│   │   └── README.md
│   └── api-client/
│       ├── src/
│       └── README.md
├── project-a/  # Uses _shared/common-utils
├── project-b/  # Uses _shared/common-utils
└── project-c/  # Uses _shared/api-client
```

Reference shared code in `PROJECT_VARIABLES.yaml`:

```yaml
# projects/project-a/PROJECT_VARIABLES.yaml
dependencies:
  shared_libs:
    - "../_shared/common-utils"
```

### Monorepo Structure

For related projects that should be versioned together:

```
projects/
└── my-app/
    ├── PROJECT_VARIABLES.yaml  # Parent config
    ├── backend/
    │   └── src/
    ├── frontend/
    │   └── src/
    └── mobile/
        └── src/
```

---

## 📞 Need Help?

- **Template Questions**: https://github.com/fda3r6sbvdgq09gse2/claude-workspace-template/issues
- **Framework Questions**: https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/issues
- **Documentation**: See `/docs` in workspace root

---

*This directory is part of your Claude-Workspace-Template workspace.*

**Last Updated:** 2025-10-16
**Template Version:** 1.0.0
