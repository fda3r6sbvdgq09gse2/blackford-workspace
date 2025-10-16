# Project Inception Wizard

Guide the user through setting up a new project in the blackford-workspace.

## Two Modes

**Quick Mode (Default):** 3 questions, 2 minutes
**Custom Mode:** 10 questions, 10 minutes

## Quick Mode (Default)

Ask user only:

1. **Project name?** (e.g., "book-cataloger", "api-gateway")
   - Validate: lowercase, hyphens only, no spaces
   - Check: not already exists in projects/

2. **What does it do?** (1 sentence description)
   - Example: "Personal library management with ISBN scanning"

3. **Primary language?** (Python, TypeScript, Go, Rust, etc.)

Then use smart defaults:
- team_lead: From STARTUP_VARIABLES.yaml user.name
- agents: ["backend", "frontend", "testing"] (standard set)
- framework: Auto-detect from language (FastAPI for Python, Express for TS, etc.)
- status: "planning"
- started_date: Today

## Custom Mode

If user says "custom" or "advanced", ask:

1. Project name?
2. Display name? (human-readable)
3. Description? (2-3 sentences)
4. Primary language?
5. Framework/stack?
6. Team lead? (default: workspace user)
7. Which agents? (list: backend, frontend, integration, testing, devops, documentation)
8. Initial sprint focus? (what to build first)
9. Target timeline? (weeks or milestone)
10. Special requirements? (APIs, databases, hardware, etc.)

## After Questions - Generate Files

### 1. Create Directory Structure

```bash
mkdir -p projects/[project-name]/{src,tests,docs,.ai/context}
```

### 2. Generate PROJECT_VARIABLES.yaml

Use template from `.ai/templates/PROJECT_VARIABLES.yaml` and fill with answers:

```yaml
# PROJECT_VARIABLES.yaml
system:
  project_name: "[answer-1]"
  project_display_name: "[answer-2 or answer-1]"
  project_description: "[answer-2-or-3]"
  framework_version: "1.0"
  environment: "development"

# Inherit from workspace
inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"

# Project metadata
project:
  name: "[project-name]"
  version: "0.1.0"
  started_date: "[today]"
  status: "planning"  # planning | active | completed | archived

  # Technical stack
  language: "[answer-3]"
  framework: "[answer-5 or auto-detected]"

# Team configuration
team:
  lead: "[answer-6 or workspace-user]"
  agents_used: [answer-7 or defaults]

# Sprint planning
sprints:
  current:
    number: "1A"
    phase: "planning"
    focus: "[answer-8]"
    start_date: "[today]"

# Knowledge graph
_used_in:
  - "[[README.md:1]]"
  - "[[../../STARTUP_VARIABLES.yaml:projects]]"
```

### 3. Create README.md

```markdown
# [Project Display Name]

[Description from answer]

## Status

- **Phase:** Planning
- **Started:** [Date]
- **Team Lead:** [Name]
- **Framework:** [Name] v[Version]

## Quick Start

```bash
cd projects/[project-name]
source venv/bin/activate  # If Python
claude  # Start development
```

## Development

This project uses [Framework] with Claude-Dev-Framework v1.0.0 for AI-assisted development.

### Agents

- **Backend:** [If selected]
- **Frontend:** [If selected]
- **Integration:** [If selected]
- **Testing:** [If selected]

## Sprint Plan

### Sprint 1A: [Focus]
- [ ] Initial setup
- [ ] Core features
- [ ] Basic testing

---

*Created with `/project-inception` - Part of [blackford-workspace]*
```

### 4. Create .ai/context/current_task.md

```markdown
# Current Task: Initial Setup

**Status:** PLANNING
**Started:** [Date]

## Next Steps

1. Set up development environment
2. Initialize project structure
3. Plan Sprint 1A
4. Begin implementation

## Vision

[Description]

## Success Criteria

- [ ] Development environment working
- [ ] First feature implemented
- [ ] Basic tests passing
- [ ] Documentation complete
```

### 5. Initialize Git (Optional)

Ask: "Initialize git repository? (y/n)"

If yes:
```bash
cd projects/[project-name]
git init
git add .
git commit -m "feat: Initialize [project-name] project

Created with /project-inception wizard
Part of blackford-workspace"
```

## Final Output

Display summary:

```
═══════════════════════════════════════════════════════════
✅ PROJECT CREATED: [project-name]
═══════════════════════════════════════════════════════════

Location: /Users/z/dev/blackford-workspace/projects/[project-name]

Created:
✅ Directory structure
✅ PROJECT_VARIABLES.yaml
✅ README.md
✅ .ai/context/current_task.md
[✅ Git repository - if selected]

Configuration:
• Language: [language]
• Framework: [framework]
• Team Lead: [name]
• Agents: [list]
• Sprint: 1A - [focus]

Next Steps:
1. cd projects/[project-name]
2. [Setup command if needed, e.g., python -m venv venv]
3. claude  # Start development

Updated workspace registry:
✅ Added to STARTUP_VARIABLES.yaml:projects

═══════════════════════════════════════════════════════════
Ready to build! 🚀
═══════════════════════════════════════════════════════════
```

## Implementation Notes

- Keep tone friendly but professional
- Provide examples for each question
- Validate all inputs
- Check for conflicts (existing project name)
- Update STARTUP_VARIABLES.yaml:projects array
- Create all files with proper permissions
- Use workspace variables where possible
- Generate unique project ID if needed

## Example Session (Quick Mode)

```
User: /project-inception

═══════════════════════════════════════════════════════════
🚀 PROJECT INCEPTION WIZARD
═══════════════════════════════════════════════════════════

Quick setup (3 questions, 2 mins) or custom? [quick/custom]

User: quick

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
QUICK SETUP MODE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1️⃣ Project name? (lowercase, hyphens only)
   Example: api-gateway, data-pipeline, mobile-app

User: inventory-system

✅ Available: inventory-system

2️⃣ What does it do? (1 sentence)
   Example: "Real-time inventory tracking with barcode scanning"

User: Warehouse inventory management with real-time updates

✅ Got it

3️⃣ Primary language?
   Options: Python, TypeScript, Go, Rust, Java, Other

User: Python

✅ Python selected

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SMART DEFAULTS APPLIED:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• Framework: FastAPI (Python → FastAPI)
• Team Lead: Blackford Developer (from workspace)
• Agents: backend, frontend, testing (standard)
• Sprint: 1A - Initial Setup
• Status: planning

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Creating project structure...

[... creates files ...]

✅ PROJECT CREATED: inventory-system

[... shows summary as above ...]
```

## Error Handling

- Project name exists → suggest alternative
- Invalid project name → explain rules, ask again
- Empty description → require at least 10 characters
- Unknown language → ask to choose from list
- Any file creation error → report clearly, suggest fix

## Validation Rules

**Project Name:**
- Lowercase only
- Hyphens allowed, no underscores
- 3-50 characters
- Must start with letter
- No special characters except hyphen
- Not already in use

**Description:**
- 10-500 characters
- Complete sentence
- Clear and specific

**Language:**
- Must be from supported list OR "Other"
- If "Other", ask for specific language

## Post-Creation

After creation, automatically:
1. Add project to STARTUP_VARIABLES.yaml:projects array
2. Commit changes if workspace is git repo
3. Display next steps clearly
4. Suggest running `claude` to begin
