# .ai Directory - Workspace Intelligence

**Purpose:** This directory contains patterns, templates, and context for AI-assisted development using Claude-Dev-Framework.

---

## 🎯 Overview

The `.ai/` directory serves as the **knowledge center** for your workspace:

- **Patterns** - Reusable code patterns discovered during development
- **Templates** - Boilerplate files for common tasks
- **Context** - Session context and workspace state
- **Scripts** - Automation utilities
- **Knowledge Graph** - Bidirectional linking system (Obsidian-style)

---

## 📁 Directory Structure

```
.ai/
├── README.md                    # This file
├── context/                     # Session and workspace context
│   ├── current_sprint.md       # Active sprint information
│   ├── completed_work.md       # What's been accomplished
│   └── blockers.md             # Current blockers/issues
├── patterns/                    # Reusable patterns
│   ├── api-integration.md      # Successful API patterns
│   ├── testing-strategies.md   # Testing approaches that worked
│   └── ui-components.md        # UI component patterns
├── templates/                   # File templates
│   ├── PROJECT_VARIABLES.yaml  # Project configuration template
│   ├── README.md               # README template
│   └── ARCHITECTURE.md         # Architecture doc template
└── scripts/                     # Automation scripts
    ├── new-project.sh          # Create new project structure
    └── sync-variables.sh       # Sync VARIABLES.yaml changes
```

---

## 🕸️ Knowledge Graph System

**Source:** This system is defined in [Claude-Dev-Framework](https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework)

**Your Role:** Apply it to your `STARTUP_VARIABLES.yaml` and project configurations

This workspace template implements **Obsidian-style bidirectional linking** for complete traceability.

### What Is It?

**System Definition:** See [claude-dev-framework/VARIABLE_LINKS.md](https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/blob/main/VARIABLE_LINKS.md)

**Your Implementation:** Every variable in YOUR configuration files "knows" where it's used:

```yaml
# STARTUP_VARIABLES.yaml
startup:
  name: "blackford"

  # Knowledge graph: tracks all usage points
  _used_in:
    - "[[README.md:1]]"                  # Used in title
    - "[[projects/*/PROJECT_VARIABLES.yaml:inherits]]"  # Inherited by projects
    - "[[.github/workflows/ci.yml:12]]"  # Used in CI config
```

### Why Is This Powerful?

1. **Impact Analysis**: Know exactly what breaks if you change something
2. **Documentation**: The graph IS the documentation
3. **Onboarding**: New team members follow the links
4. **Knowledge Accumulation**: Understanding compounds over time

### How It Works

#### Format: Obsidian-Style Links

```
[[file_path:location]]
```

**Examples:**
- `[[README.md:1]]` - Line 1 of README.md
- `[[src/main.py:init]]` - The init section of main.py
- `[[projects/*/PROJECT_VARIABLES.yaml:team]]` - team section in all projects
- `[[**/*.py:imports]]` - imports in all Python files (pattern)

#### The `_used_in` Array

Every configuration variable can have a `_used_in` array:

```yaml
variable_name: "value"
_used_in:
  - "[[file1:location1]]"
  - "[[file2:location2]]"
  - "[[file3:location3]]"
```

**Real Example:**

```yaml
# STARTUP_VARIABLES.yaml
startup:
  github_org: "blackford-inc"
  _used_in:
    - "[[README.md:badge-urls]]"           # Badge links
    - "[[.github/workflows/*.yml:*]]"      # CI/CD workflows
    - "[[projects/*/README.md:*]]"         # Project documentation
    - "[[scripts/deploy.sh:ORG]]"          # Deployment scripts
    - "[[.claude/settings.json:marketplace]]"  # Framework installation
```

### Workflow: Growing the Knowledge Graph

#### Step 1: Add a New Variable

```yaml
# STARTUP_VARIABLES.yaml
startup:
  api_base_url: "https://api.blackford.com"
  _used_in: []  # Empty - not used yet
```

#### Step 2: Use It in Code

```python
# projects/api-client/src/config.py
API_BASE_URL = "https://api.blackford.com"  # TODO: Load from config
```

#### Step 3: Update Knowledge Graph

```yaml
# STARTUP_VARIABLES.yaml
startup:
  api_base_url: "https://api.blackford.com"
  _used_in:
    - "[[projects/api-client/src/config.py:3]]"  # ← Added this!
```

#### Step 4: Use It Elsewhere

```yaml
# projects/api-client/PROJECT_VARIABLES.yaml
inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"  # Gets api_base_url
```

#### Step 5: Update Knowledge Graph Again

```yaml
# STARTUP_VARIABLES.yaml
startup:
  api_base_url: "https://api.blackford.com"
  _used_in:
    - "[[projects/api-client/src/config.py:3]]"
    - "[[projects/api-client/PROJECT_VARIABLES.yaml:inherits]]"  # ← Added this!
```

#### Step 6: Document It

```markdown
<!-- projects/api-client/docs/CONFIGURATION.md -->
# Configuration

## API Base URL

We use `startup.api_base_url` from workspace config.
Value: `https://api.blackford.com`
```

#### Step 7: Update Knowledge Graph Final Time

```yaml
# STARTUP_VARIABLES.yaml
startup:
  api_base_url: "https://api.blackford.com"
  _used_in:
    - "[[projects/api-client/src/config.py:3]]"
    - "[[projects/api-client/PROJECT_VARIABLES.yaml:inherits]]"
    - "[[projects/api-client/docs/CONFIGURATION.md:api-section]]"  # ← Added this!
```

**Result:** The variable now "knows" its complete usage map!

---

## 📚 Knowledge Graph Benefits

### 1. Impact Analysis

**Question:** "What breaks if I change `startup.name`?"

**Answer:** Look at `_used_in`:

```yaml
startup:
  name: "blackford"
  _used_in:
    - "[[README.md:1]]"                          # Title breaks
    - "[[projects/*/PROJECT_VARIABLES.yaml:*]]"  # All projects break
    - "[[.github/workflows/deploy.yml:12]]"      # Deployment breaks
```

**Action:** Update all these files when changing the name.

### 2. Orphan Detection

**Question:** "Is this variable still used?"

**Answer:** Check if `_used_in` is empty:

```yaml
old_api_url: "https://old.api.com"
_used_in: []  # ❌ Orphan! Safe to delete?
```

### 3. Documentation Generation

**Question:** "Where is this variable documented?"

**Answer:** Filter `_used_in` for docs:

```yaml
api_key: "secret"
_used_in:
  - "[[src/auth.py:10]]"
  - "[[.env.example:5]]"
  - "[[docs/AUTH.md:api-keys-section]]"  # ← Documentation
```

### 4. Onboarding

**New Team Member:** "How does authentication work?"

**You:** "Follow the knowledge graph!"

```
startup.api_key
  ↓ [[.env.example:5]]
    ↓ (they open .env.example)
      ↓ See: BLACKFORD_API_KEY=xxx
        ↓ [[docs/AUTH.md:api-keys-section]]
          ↓ (they read AUTH.md)
            ↓ [[src/auth.py:AuthClient]]
              ↓ (they understand the code)
```

---

## 🔧 Maintenance

### Weekly: Add New Links

As you develop, update `_used_in` arrays:

```bash
# Did you reference a variable this week?
# Add it to _used_in!

git diff --name-only | xargs grep -l "blackford"
# If any files use workspace variables, update knowledge graph
```

### Monthly: Verify Links

Check that references are still valid:

```bash
# Script: verify-knowledge-graph.sh
#!/bin/bash

# Extract all [[file:location]] references
grep -r "_used_in:" . -A 10 | grep "\[\[" | while read link; do
  file=$(echo $link | sed 's/.*\[\[\(.*\):.*\]\].*/\1/')
  if [ ! -f "$file" ]; then
    echo "❌ Broken link: $link (file not found)"
  else
    echo "✅ Valid: $link"
  fi
done
```

### Quarterly: Generate Reports

Visualize the knowledge graph:

```bash
# Script: graph-report.sh
#!/bin/bash

echo "# Knowledge Graph Report"
echo "Generated: $(date)"
echo ""

echo "## Most Referenced Variables"
grep -r "_used_in:" STARTUP_VARIABLES.yaml | \
  awk '{print $1, NF-2}' | \
  sort -k2 -nr | \
  head -10

echo ""
echo "## Orphaned Variables"
grep -B5 "_used_in: \[\]" STARTUP_VARIABLES.yaml | \
  grep -v "_used_in"
```

---

## 🎨 Templates

### Using Templates

Templates in `.ai/templates/` provide starting points:

```bash
# Create new project from template
cp .ai/templates/PROJECT_VARIABLES.yaml projects/my-project/

# Customize the copy
vim projects/my-project/PROJECT_VARIABLES.yaml
```

**Available Templates:**

| Template | Purpose | Copy To |
|----------|---------|---------|
| `PROJECT_VARIABLES.yaml` | Project configuration | `projects/*/PROJECT_VARIABLES.yaml` |
| `README.md` | Project README | `projects/*/README.md` |
| `ARCHITECTURE.md` | Architecture docs | `projects/*/docs/ARCHITECTURE.md` |

### Creating New Templates

Found a pattern you want to reuse?

```bash
# 1. Create template file
cat > .ai/templates/new-template.md <<'EOF'
# Template Name

[Template content with placeholders like {{PROJECT_NAME}}]
EOF

# 2. Document it
# Add entry to .ai/README.md (this file)

# 3. Commit it
git add .ai/templates/new-template.md
git commit -m "chore: Add new template for X"
```

---

## 🧠 Patterns

### What Are Patterns?

**Patterns** are solutions to recurring problems that worked well.

**Example Pattern:**

```markdown
<!-- .ai/patterns/api-retry-logic.md -->
# API Retry Logic Pattern

## Problem
API calls fail intermittently due to network issues.

## Solution
Use exponential backoff with max retries:

\`\`\`python
def api_call_with_retry(url, max_retries=3):
    for attempt in range(max_retries):
        try:
            return requests.get(url)
        except requests.RequestException:
            if attempt == max_retries - 1:
                raise
            time.sleep(2 ** attempt)  # Exponential backoff
\`\`\`

## Where Used
- [[projects/api-client/src/client.py:fetch]]
- [[projects/data-pipeline/src/fetcher.py:get_data]]

## Variations
- Add jitter to prevent thundering herd
- Use different backoff for different error codes
```

### Creating Patterns

When you solve a problem:

1. Document the solution in `.ai/patterns/`
2. Add knowledge graph links to where you used it
3. Reference it in future similar problems

---

## 🚀 Automation Scripts

### Purpose

Scripts in `.ai/scripts/` automate common workspace tasks.

### Example: Create New Project

```bash
# .ai/scripts/new-project.sh
#!/bin/bash

PROJECT_NAME=$1
PROJECT_DESC=$2

# Create directory structure
mkdir -p "projects/${PROJECT_NAME}"/{src,tests,docs}

# Copy template
cp .ai/templates/PROJECT_VARIABLES.yaml "projects/${PROJECT_NAME}/"
cp .ai/templates/README.md "projects/${PROJECT_NAME}/"

# Customize template
sed -i "" "s/PROJECT_NAME/${PROJECT_NAME}/g" "projects/${PROJECT_NAME}/PROJECT_VARIABLES.yaml"
sed -i "" "s/PROJECT_DESC/${PROJECT_DESC}/g" "projects/${PROJECT_NAME}/README.md"

echo "✅ Created project: ${PROJECT_NAME}"
```

**Usage:**

```bash
./.ai/scripts/new-project.sh my-api "REST API service"
```

---

## 🎓 Best Practices

### DO ✅

1. **Update knowledge graph as you code**
   - Add to `_used_in` when you reference a variable
   - This should become automatic (like writing tests)

2. **Document discovered patterns**
   - Solved a tricky problem? Write it down!
   - Future you will thank present you

3. **Use templates**
   - Don't reinvent the wheel for every project
   - Templates enforce consistency

4. **Keep templates DRY**
   - Templates should reference STARTUP_VARIABLES.yaml
   - Don't hardcode values

### DON'T ❌

1. **Don't let knowledge graph get stale**
   - Weekly review: Did I add all usage points?
   - Broken links = broken knowledge

2. **Don't create patterns prematurely**
   - Wait until you've used something 2-3 times
   - Premature patterns become noise

3. **Don't hardcode in templates**
   ```yaml
   # Bad:
   company: "Blackford Industries"  # ❌ Hardcoded

   # Good:
   inherits:
     startup_config: "../../STARTUP_VARIABLES.yaml"  # ✅ Reference
   ```

---

## 📞 Support

**Questions?**
- **Template Issues**: https://github.com/fda3r6sbvdgq09gse2/claude-workspace-template/issues
- **Framework Issues**: https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/issues

---

*This directory is part of your Claude-Workspace-Template workspace.*

**Last Updated:** 2025-10-16
**Template Version:** 1.0.0
**Knowledge Graph System:** Defined in claude-dev-framework v1.0.0+

**Related Framework Documentation:**
- [VARIABLE_LINKS.md](https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/blob/main/VARIABLE_LINKS.md) - Framework's knowledge graph
- [NAMING.md](https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/blob/main/NAMING.md) - Naming conventions
- [VARIABLES_REFERENCE.md](https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/blob/main/docs/VARIABLES_REFERENCE.md) - Complete variable reference
