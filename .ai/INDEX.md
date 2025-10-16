# .ai Directory Index

**AI-assisted development resources index**

---

## 📁 Directory Structure

```
.ai/
├── INDEX.md                        # ← You are here
├── README.md                        # Knowledge graph system explained
├── templates/                       # File templates
│   └── PROJECT_VARIABLES.yaml      # Project configuration template
└── meta/                            # Meta-level knowledge compounding
    ├── README.md                    # Meta-system overview
    ├── KNOWLEDGE_COMPOUNDING_SYSTEM.md  # Complete system docs
    └── learnings/
        ├── README.md                # How to document learnings
        └── TEMPLATE.md              # Learning doc template
```

---

## 🎯 Quick Navigation

| File | Purpose | When to Use |
|------|---------|-------------|
| **[README.md](README.md)** | Knowledge graph system | Understanding `_used_in` |
| **[templates/PROJECT_VARIABLES.yaml](templates/PROJECT_VARIABLES.yaml)** | Project config template | Creating new project |
| **[meta/README.md](meta/README.md)** | Meta-system overview | After completing project |
| **[meta/KNOWLEDGE_COMPOUNDING_SYSTEM.md](meta/KNOWLEDGE_COMPOUNDING_SYSTEM.md)** | Complete system | Understanding meta-level |
| **[meta/learnings/TEMPLATE.md](meta/learnings/TEMPLATE.md)** | Learning doc template | Documenting project learnings |

---

## 📚 Main Resources

### [README.md](README.md) (500 lines)

**Purpose:** Explain the knowledge graph system

**Key Sections:**
- What is the knowledge graph?
- How `_used_in` works
- Workflow examples
- Benefits (impact analysis, onboarding, documentation)
- Maintenance procedures

**Read when:**
- Setting up new workspace
- Need to understand variable tracking
- Onboarding new team members

### [templates/PROJECT_VARIABLES.yaml](templates/PROJECT_VARIABLES.yaml) (200 lines)

**Purpose:** Complete project configuration template

**Features:**
- Full YAML structure with comments
- Example `_used_in` arrays throughout
- Knowledge compounding notes
- Maintenance tips

**Use when:**
- Creating new project
- Need reference for project config
- Want to see best practices

---

## 🧠 Meta-Level Resources

### [meta/README.md](meta/README.md) (150 lines)

**Purpose:** Overview of knowledge compounding system

**Key Sections:**
- Directory structure
- How to use the system
- Workflow after project completion
- Pattern extraction process

**Read when:**
- Finished a project
- Want to document learnings
- Planning framework improvements

### [meta/KNOWLEDGE_COMPOUNDING_SYSTEM.md](meta/KNOWLEDGE_COMPOUNDING_SYSTEM.md) (300+ lines)

**Purpose:** Complete meta-system documentation

**Key Sections:**
- The complete system explained
- How knowledge compounds
- Learning capture process
- Pattern extraction
- Framework improvement proposals

**Read when:**
- Want deep understanding of meta-level
- Planning to contribute patterns back
- Becoming framework maintainer

### [meta/learnings/TEMPLATE.md](meta/learnings/TEMPLATE.md) (100 lines)

**Purpose:** Template for documenting project learnings

**Sections:**
- Project overview
- What worked well
- Pain points
- Patterns discovered
- Metrics and statistics
- Recommendations for framework

**Use when:**
- Completed a project
- Want to capture learnings
- Preparing feedback for framework maintainer

---

## 🔄 Workflows

### Creating New Project

```bash
# 1. Copy template
cd projects/new-project
cp ../../.ai/templates/PROJECT_VARIABLES.yaml ./

# 2. Customize it
vim PROJECT_VARIABLES.yaml

# 3. Start building
claude
```

### After Project Completion

```bash
# 1. Document learnings
cp .ai/meta/learnings/TEMPLATE.md .ai/meta/learnings/2025-10-my-project.md
vim .ai/meta/learnings/2025-10-my-project.md

# 2. Extract patterns
# Create pattern files for reusable solutions

# 3. Propose improvements
# Document what should change in framework v2.0
```

---

## 🎓 Learning Paths

### For Project Developers

1. Read: [README.md](README.md) → Understand knowledge graph
2. Use: [templates/PROJECT_VARIABLES.yaml](templates/PROJECT_VARIABLES.yaml) → Create project
3. Maintain: Update `_used_in` as you code

### For Framework Maintainers

1. Read: [meta/README.md](meta/README.md) → Understand meta-system
2. Study: [meta/KNOWLEDGE_COMPOUNDING_SYSTEM.md](meta/KNOWLEDGE_COMPOUNDING_SYSTEM.md) → Deep dive
3. Review: [meta/learnings/](meta/learnings/) → Extract insights
4. Apply: Integrate learnings → Framework v2.0

---

## 📊 Statistics

| Category | Files | Lines | Purpose |
|----------|-------|-------|---------|
| **Knowledge Graph** | 1 | 500 | System documentation |
| **Templates** | 1 | 200 | Project boilerplate |
| **Meta-System** | 3 | 550+ | Knowledge compounding |
| **Total** | 5 | 1250+ | Complete AI resources |

---

## 🔗 Related Documentation

**From ROOT:**
- [../README.md](../README.md) - Main documentation
- [../INDEX.md](../INDEX.md) - Complete project index
- [../QUICK_REFERENCE.md](../QUICK_REFERENCE.md) - Quick reference

**From DOCS:**
- [../docs/QUICK_START.md](../docs/QUICK_START.md) - Getting started
- [../docs/CUSTOMIZATION.md](../docs/CUSTOMIZATION.md) - Customization
- [../docs/ARCHITECTURE.md](../docs/ARCHITECTURE.md) - Architecture

**From PROJECTS:**
- [../projects/README.md](../projects/README.md) - Project creation

---

**Last Updated:** 2025-10-16
**AI Resources Version:** 1.0.0
