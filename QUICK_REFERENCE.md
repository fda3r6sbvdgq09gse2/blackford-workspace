# Quick Reference: Claude-Workspace-Template

**Version:** 1.0.0 | **Read Time:** 60 seconds | **For:** LLMs & Developers

---

## 🎯 What This Is

```
Framework (claude-dev-framework) → Template (this) → Your Workspace (blackford-workspace) → Projects
```

**Template Purpose:** Fork → Customize → Build projects with Claude-Dev-Framework agents

---

## 📁 Key Files (Priority Order)

| File | Purpose | Read First |
|------|---------|------------|
| `STARTUP_VARIABLES.yaml` | Single source of truth (all config) | Lines 1-50 |
| `README.md` | Overview + quick start | Lines 1-100 |
| `.ai/README.md` | Knowledge graph `_used_in` system | Lines 40-150 |
| `docs/QUICK_START.md` | Step-by-step setup (15 min) | Full |
| `projects/README.md` | How to create projects | Lines 1-100 |

---

## ⚡ Common Commands

```bash
# Fork template
gh repo fork fda3r6sbvdgq09gse2/claude-workspace-template --fork-name="your-workspace"

# Customize
vim STARTUP_VARIABLES.yaml  # Change: startup.name, github_org

# Create project
cd projects && mkdir my-project
cp ../.ai/templates/PROJECT_VARIABLES.yaml my-project/

# Upgrade framework
./scripts/upgrade-framework.sh v2.0.0
```

---

## 🔑 Configuration Hierarchy

```yaml
# STARTUP_VARIABLES.yaml (workspace level)
startup:
  name: "blackford"              # Line 20 - YOUR COMPANY
  github_org: "blackford-inc"    # Line 22 - YOUR GITHUB
framework:
  version: "1.0.0"               # Line 42 - FRAMEWORK VERSION

# projects/*/PROJECT_VARIABLES.yaml (project level)
inherits:
  startup_config: "../../STARTUP_VARIABLES.yaml"  # Gets all workspace config
```

---

## 🕸️ Knowledge Graph (`_used_in`)

```yaml
# Every variable tracks WHERE it's used
startup:
  name: "blackford"
  _used_in:                      # ← Obsidian-style links
    - "[[README.md:1]]"
    - "[[projects/*/PROJECT_VARIABLES.yaml:inherits]]"
```

**Purpose:** Know impact of changes, documentation, onboarding

---

## 📊 Directory Map

```
.
├── STARTUP_VARIABLES.yaml      # ⚠️ EDIT THIS FIRST
├── README.md                    # Start here
├── .claude/settings.json        # Framework config (auto-synced)
├── .ai/                         # Patterns, templates, meta-knowledge
├── docs/                        # QUICK_START, CUSTOMIZATION, UPGRADING, ARCHITECTURE
├── projects/                    # Your projects go here
└── scripts/                     # upgrade-framework.sh
```

---

## 🎓 Quick Tasks

| Task | Read | Commands |
|------|------|----------|
| **Setup** | README:58-93 | Fork + customize STARTUP_VARIABLES.yaml |
| **New Project** | projects/README.md | mkdir + copy template |
| **Upgrade** | docs/UPGRADING.md | Change version + run script |
| **Learn Graph** | .ai/README.md:43-150 | Understand `_used_in` |

---

## 🔗 URLs

- **Template:** github.com/fda3r6sbvdgq09gse2/claude-workspace-template
- **Framework:** github.com/fda3r6sbvdgq09gse2/claude-dev-framework
- **Docs:** docs.claude.com/en/docs/claude-code

---

## 🚨 Critical Rules

1. **Never edit `.claude/settings.json` directly** → Edit STARTUP_VARIABLES.yaml instead
2. **Always use `_used_in`** → Track variable usage for knowledge graph
3. **Reference, don't duplicate** → Use `inherits:` in PROJECT_VARIABLES.yaml
4. **Test before commit** → Run scripts, verify changes

---

## 📝 Next Steps for New Users

1. Read this file (1 min) ✓
2. Fork template (2 min)
3. Customize STARTUP_VARIABLES.yaml (5 min)
4. Read docs/QUICK_START.md (15 min)
5. Create first project (10 min)

**Total:** ~35 minutes to productive

---

**For Full Index:** See [INDEX.md](INDEX.md)
**For Deep Dive:** See [docs/CUSTOMIZATION.md](docs/CUSTOMIZATION.md)
