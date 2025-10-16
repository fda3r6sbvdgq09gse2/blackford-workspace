# Claude-Workspace-Template: Complete Index

**Last Updated:** 2025-10-16 | **Version:** 1.0.0
**Purpose:** Token-efficient index for LLMs and developers to quickly find what they need

---

## 🎯 Quick Navigation (For LLMs: Read This First)

| Need | File | Lines | Purpose |
|------|------|-------|---------|
| **Get Started** | [README.md](README.md) | 1-50 | Overview, quick start |
| **Configuration** | [STARTUP_VARIABLES.yaml](STARTUP_VARIABLES.yaml) | 1-125 | Single source of truth |
| **Beginner Guide** | [docs/QUICK_START.md](docs/QUICK_START.md) | 1-100 | 15-minute walkthrough |
| **Deep Customization** | [docs/CUSTOMIZATION.md](docs/CUSTOMIZATION.md) | 1-150 | Variable hierarchy, patterns |
| **Knowledge Graph** | [.ai/README.md](.ai/README.md) | 40-150 | `_used_in` system explained |
| **Test Workflow** | [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) | 100-300 | Complete testing guide |
| **Upgrade Framework** | [scripts/upgrade-framework.sh](scripts/upgrade-framework.sh) | 1-50 | Automated upgrade script |
| **Create Project** | [projects/README.md](projects/README.md) | 1-100 | Project creation guide |

---

## 📁 Directory Structure (Complete Map)

```
claude-workspace-template/
├── INDEX.md                           # ← You are here (main index)
├── QUICK_REFERENCE.md                 # Ultra-compact reference (50 lines)
├── README.md                          # Main documentation (500 lines)
├── STARTUP_VARIABLES.yaml             # ⚠️ SINGLE SOURCE OF TRUTH (125 lines)
├── LICENSE                            # MIT License (40 lines)
├── .gitignore                         # Comprehensive ignore rules (150 lines)
│
├── .claude/
│   └── settings.json                  # Framework marketplace config (20 lines)
│
├── .ai/                               # AI-assisted development resources
│   ├── INDEX.md                       # AI resources index
│   ├── README.md                      # Knowledge graph system (500 lines)
│   ├── templates/
│   │   └── PROJECT_VARIABLES.yaml     # Project config template (200 lines)
│   └── meta/                          # Meta-level knowledge compounding
│       ├── README.md                  # Meta-system explained (150 lines)
│       ├── KNOWLEDGE_COMPOUNDING_SYSTEM.md  # Complete system (300 lines)
│       └── learnings/
│           └── TEMPLATE.md            # Learning doc template (100 lines)
│
├── docs/                              # Documentation
│   ├── INDEX.md                       # Documentation index
│   ├── QUICK_START.md                 # Beginner guide (575 lines)
│   ├── CUSTOMIZATION.md               # Developer deep dive (850 lines)
│   ├── UPGRADING.md                   # Framework upgrade guide
│   └── ARCHITECTURE.md                # System architecture deep dive
│
├── projects/                          # Your projects go here
│   └── README.md                      # Project creation guide (300 lines)
│
└── scripts/                           # Automation scripts
    └── upgrade-framework.sh           # Automated framework upgrade (200 lines)
```

---

## 🔍 Quick Lookup: Where to Find Things

### Configuration & Setup

| What | Where | Key Sections |
|------|-------|--------------|
| **Company name** | STARTUP_VARIABLES.yaml:20 | `startup.name` |
| **GitHub org** | STARTUP_VARIABLES.yaml:22 | `startup.github_org` |
| **Framework version** | STARTUP_VARIABLES.yaml:42 | `framework.version` |
| **Marketplace config** | .claude/settings.json:3-10 | `extraKnownMarketplaces` |
| **Team members** | STARTUP_VARIABLES.yaml:76-91 | `team.members` |
| **Project list** | STARTUP_VARIABLES.yaml:59-71 | `projects` |

### Documentation

| Topic | File | Key Sections |
|-------|------|--------------|
| **Installation** | README.md:46-93 | Quick Start |
| **Fork workflow** | docs/QUICK_START.md:106-138 | Step 2: Fork |
| **Customization** | docs/CUSTOMIZATION.md:51-104 | STARTUP_VARIABLES deep dive |
| **Knowledge graph** | .ai/README.md:43-200 | How `_used_in` works |
| **Upgrade process** | docs/UPGRADING.md | Version upgrade guide |
| **Architecture** | docs/ARCHITECTURE.md | Three-tier system |

### Templates & Examples

| What | Where | Purpose |
|------|-------|---------|
| **Project variables** | .ai/templates/PROJECT_VARIABLES.yaml | Per-project configuration |
| **Learning doc** | .ai/meta/learnings/TEMPLATE.md | Document project learnings |
| **Pattern doc** | .ai/meta/patterns/ | Document reusable patterns |

### Scripts & Automation

| Script | Purpose | Usage |
|--------|---------|-------|
| **upgrade-framework.sh** | Upgrade framework version | `./scripts/upgrade-framework.sh v2.0.0` |

---

## 🎓 Learning Paths

### Path 1: Complete Beginner (1 hour)

1. Read: [README.md](README.md) lines 1-100 (10 min)
2. Read: [docs/QUICK_START.md](docs/QUICK_START.md) (20 min)
3. Customize: [STARTUP_VARIABLES.yaml](STARTUP_VARIABLES.yaml) (15 min)
4. Create first project: [projects/README.md](projects/README.md) (15 min)

### Path 2: Developer Customizing (2 hours)

1. Review: [docs/CUSTOMIZATION.md](docs/CUSTOMIZATION.md) sections 1-3 (30 min)
2. Understand: [.ai/README.md](.ai/README.md) knowledge graph (30 min)
3. Explore: [.ai/templates/PROJECT_VARIABLES.yaml](.ai/templates/PROJECT_VARIABLES.yaml) (15 min)
4. Practice: Create 2-3 test projects (45 min)

### Path 3: Framework Maintainer (4 hours)

1. Study: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) complete (60 min)
2. Review: [.ai/meta/KNOWLEDGE_COMPOUNDING_SYSTEM.md](.ai/meta/KNOWLEDGE_COMPOUNDING_SYSTEM.md) (45 min)
3. Test: [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) phases 1-6 (90 min)
4. Plan: Review learnings, plan v2.0 (45 min)

---

## 🔧 Common Tasks (Quick Reference)

### Task: Fork Template

**Files to read:** README.md:58-93, docs/QUICK_START.md:106-138
**Commands:**
```bash
gh repo fork fda3r6sbvdgq09gse2/claude-workspace-template --fork-name="blackford-workspace"
cd claude-workspace-template && vim STARTUP_VARIABLES.yaml
```

### Task: Create New Project

**Files to read:** projects/README.md:1-100
**Template:** .ai/templates/PROJECT_VARIABLES.yaml
**Commands:**
```bash
cd projects && mkdir my-project && cd my-project
cp ../../.ai/templates/PROJECT_VARIABLES.yaml ./
vim PROJECT_VARIABLES.yaml
```

### Task: Upgrade Framework

**Files to read:** docs/UPGRADING.md, scripts/upgrade-framework.sh:1-50
**Commands:**
```bash
vim STARTUP_VARIABLES.yaml  # Change framework.version
./scripts/upgrade-framework.sh v2.0.0
```

### Task: Add Knowledge Graph Links

**Files to read:** .ai/README.md:43-150
**Pattern:**
```yaml
variable_name: "value"
_used_in:
  - "[[file:location]]"
```

### Task: Document Project Learnings

**Files to read:** .ai/meta/README.md:40-100, .ai/meta/learnings/TEMPLATE.md
**Commands:**
```bash
cp .ai/meta/learnings/TEMPLATE.md .ai/meta/learnings/2025-10-my-project.md
vim .ai/meta/learnings/2025-10-my-project.md
```

---

## 📊 File Statistics

| Category | Files | Lines | Purpose |
|----------|-------|-------|---------|
| **Configuration** | 2 | 145 | STARTUP_VARIABLES.yaml, .claude/settings.json |
| **Documentation** | 7 | 3500+ | README + docs/ |
| **Templates** | 2 | 300 | Project + learning templates |
| **Scripts** | 1 | 200 | upgrade-framework.sh |
| **Meta-System** | 5 | 800+ | Knowledge compounding |
| **Total** | 17+ | 5000+ | Complete system |

---

## 🔗 External References

### Framework (Tier 1)
- **Repository:** https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework
- **Key Files:** VARIABLES.yaml, VARIABLE_LINKS.md, NAMING.md

### Documentation
- **Claude Code Docs:** https://docs.claude.com/en/docs/claude-code
- **Plugin Reference:** https://docs.claude.com/en/docs/claude-code/plugins-reference

### Issue Tracking
- **Template Issues:** https://github.com/fda3r6sbvdgq09gse2/claude-workspace-template/issues
- **Framework Issues:** https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/issues

---

## 🎯 For LLMs: Token-Efficient Scanning

**Priority 1 Files** (Read these first):
- INDEX.md (this file) - Complete map
- QUICK_REFERENCE.md - 50-line ultra-compact reference
- STARTUP_VARIABLES.yaml:1-50 - Configuration overview

**Priority 2 Files** (Read when needed):
- README.md:1-100 - Overview
- docs/QUICK_START.md:1-150 - Getting started
- .ai/README.md:40-150 - Knowledge graph

**Priority 3 Files** (Deep dives):
- docs/CUSTOMIZATION.md - Complete customization
- docs/ARCHITECTURE.md - System design
- IMPLEMENTATION_SUMMARY.md - Testing workflow

**Scan Strategy:**
1. Read INDEX.md first (this file) → 2 minutes
2. Identify what you need from Quick Lookup table
3. Jump directly to relevant file:line ranges
4. Use knowledge graph `_used_in` to find related files

---

## 📝 Maintenance

**This index should be updated when:**
- New files are added
- Major sections are restructured
- File line ranges change significantly
- New learning paths are discovered

**Update frequency:** After each significant change

---

**Last Updated:** 2025-10-16
**Index Version:** 1.0.0
**Template Version:** 1.0.0
