# Upgrading Guide: Claude-Dev-Framework

**Audience:** Workspace maintainers, DevOps engineers
**Time Required:** 10-30 minutes (depending on complexity)
**Prerequisites:** Working workspace with projects

---

## 🎯 Overview

This guide covers upgrading the Claude-Dev-Framework from one version to another in your workspace.

### Why Upgrade?

- **New Features**: Access latest framework improvements
- **Bug Fixes**: Get security and stability patches
- **Better Agents**: Improved agent capabilities
- **Community Patterns**: New patterns discovered by other users

### The Magic of This Architecture

**Traditional approach:** Fork framework → diverge over time → can't upgrade (merge conflicts)

**Our approach:** Reference framework → change version number → instant upgrade

```bash
# The entire upgrade
vim STARTUP_VARIABLES.yaml  # framework.version: "1.0.0" → "2.0.0"
./scripts/upgrade-framework.sh v2.0.0
# Done! Your projects unchanged, framework upgraded
```

---

## 🚀 Quick Upgrade (Standard Path)

### Prerequisites Check

```bash
# 1. Ensure you're on a clean branch
git status
# Should show: nothing to commit, working tree clean

# 2. Check current version
grep "version:" STARTUP_VARIABLES.yaml | head -1
# Shows: version: "1.0.0"

# 3. Backup current state
git tag "pre-upgrade-$(date +%Y%m%d)"
git push --tags
```

### Upgrade Steps (5 minutes)

```bash
# Step 1: Check available versions
gh api repos/fda3r6sbvdgq09gse2/claude-dev-framework/git/refs/tags | jq -r '.[].ref' | sed 's|refs/tags/||'

# Step 2: Run upgrade script
./scripts/upgrade-framework.sh v2.0.0

# Step 3: Review changes
git diff STARTUP_VARIABLES.yaml .claude/settings.json

# Step 4: Test (see Testing section below)

# Step 5: Commit if successful
git add STARTUP_VARIABLES.yaml .claude/settings.json
git commit -m "chore: Upgrade Claude-Dev-Framework to v2.0.0"
git push
```

---

## 🧪 Testing the Upgrade

### Phase 1: Basic Validation (2 minutes)

```bash
# 1. Verify configuration is valid
cat .claude/settings.json | jq .
# Should parse without errors

# 2. Check framework loads
cd projects/any-project
claude --version
# Should start without errors

# 3. List available agents
# In Claude Code:
/help
# Should show framework agents: agent-backend, agent-frontend, etc.
```

### Phase 2: Project Testing (10 minutes)

```bash
# Test in a non-critical project first
cd projects/test-project  # Or create a test project

# Try using framework agents
# In Claude Code:
# "Create a simple Python hello world"
# Framework should work correctly
```

### Phase 3: Integration Testing (15 minutes)

```bash
# Test in actual projects
cd projects/your-main-project

# Run existing tests
pytest  # Or your test command

# Try your typical workflow
# - Create files
# - Run agents
# - Build/deploy

# Check for any errors or warnings
```

---

## ⚠️ Upgrade Scenarios

### Scenario 1: Patch Version (1.0.0 → 1.0.1)

**Risk Level:** 🟢 Low
**Breaking Changes:** None expected
**Testing:** Basic validation sufficient
**Rollback:** Easy

```bash
./scripts/upgrade-framework.sh v1.0.1
# Quick test
cd projects/any-project && claude
# If works, commit
```

### Scenario 2: Minor Version (1.0.0 → 1.1.0)

**Risk Level:** 🟡 Medium
**Breaking Changes:** Rare, new features added
**Testing:** Phase 1 + Phase 2 testing
**Rollback:** Easy

```bash
# Read release notes first
gh api repos/fda3r6sbvdgq09gse2/claude-dev-framework/releases/tags/v1.1.0 | jq -r '.body'

# Upgrade
./scripts/upgrade-framework.sh v1.1.0

# Test thoroughly (Phase 1-2)
# Commit if successful
```

### Scenario 3: Major Version (1.0.0 → 2.0.0)

**Risk Level:** 🔴 High
**Breaking Changes:** Possible
**Testing:** Full Phase 1-3 testing
**Rollback:** Plan required

```bash
# IMPORTANT: Read migration guide first
# Check: https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/blob/main/MIGRATION_v1_to_v2.md

# Create migration branch
git checkout -b upgrade-to-v2.0.0

# Upgrade
./scripts/upgrade-framework.sh v2.0.0

# Test extensively (all phases)

# Review breaking changes
# Update your code if needed

# If successful, merge
git checkout main
git merge upgrade-to-v2.0.0
```

---

## 🔄 Rollback Procedures

### Quick Rollback (5 minutes)

```bash
# If you haven't committed yet
git checkout STARTUP_VARIABLES.yaml .claude/settings.json

# Or restore from backup
BACKUP_FILE=$(ls -t STARTUP_VARIABLES.yaml.backup.* | head -1)
cp $BACKUP_FILE STARTUP_VARIABLES.yaml
./scripts/upgrade-framework.sh v1.0.0  # Back to previous version
```

### Full Rollback (10 minutes)

```bash
# If you committed and pushed
git log --oneline  # Find commit before upgrade
git revert abc123  # Revert the upgrade commit

# Or reset to pre-upgrade tag
git reset --hard pre-upgrade-20251016
git push --force  # ⚠️ Use with caution

# Verify rollback
grep "version:" STARTUP_VARIABLES.yaml
# Should show old version
```

---

## 📋 Pre-Upgrade Checklist

**Before starting any upgrade:**

- [ ] Read release notes for target version
- [ ] Check for breaking changes
- [ ] Create backup tag (`git tag pre-upgrade-$(date +%Y%m%d)`)
- [ ] Ensure clean working directory (`git status`)
- [ ] Inform team members (if shared workspace)
- [ ] Have rollback plan ready
- [ ] Schedule testing time (15-30 minutes)

---

## 🎛️ Advanced Upgrade Scenarios

### Upgrading with Active Development

**Problem:** Team is actively developing, can't pause for upgrade

**Solution:** Use feature branch + staged rollout

```bash
# 1. Create upgrade branch
git checkout -b framework-upgrade-v2.0

# 2. Upgrade in branch
./scripts/upgrade-framework.sh v2.0.0
git add . && git commit -m "chore: Upgrade to v2.0.0"

# 3. Test in branch
cd projects/test-project
# Test thoroughly

# 4. When ready, merge
git checkout main
git merge framework-upgrade-v2.0

# 5. CI/CD deploys automatically
```

### Upgrading Multiple Workspaces

**Scenario:** You maintain 3 company workspaces

**Approach:** Staged rollout

```bash
# Week 1: Upgrade development workspace
cd ~/dev-workspace
./scripts/upgrade-framework.sh v2.0.0
# Team tests for a week

# Week 2: Upgrade staging workspace
cd ~/staging-workspace
./scripts/upgrade-framework.sh v2.0.0
# QA tests for a week

# Week 3: Upgrade production workspace
cd ~/prod-workspace
./scripts/upgrade-framework.sh v2.0.0
# Monitor closely
```

### Upgrading with Custom Framework Fork

**Scenario:** You forked claude-dev-framework and customized it

**Configuration:**

```yaml
# STARTUP_VARIABLES.yaml
framework:
  marketplace_repo: "your-org/claude-dev-framework-fork"
  version: "1.0.0-custom"
```

**Upgrade Process:**

```bash
# 1. Sync your fork with upstream
cd ~/your-fork-of-framework
git remote add upstream https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework
git fetch upstream
git merge upstream/main

# 2. Tag your custom version
git tag v2.0.0-custom
git push --tags

# 3. Upgrade your workspace
cd ~/your-workspace
vim STARTUP_VARIABLES.yaml  # version: "2.0.0-custom"
./scripts/upgrade-framework.sh v2.0.0-custom
```

---

## 🐛 Troubleshooting

### Issue: Agents Not Loading After Upgrade

**Symptoms:**
```
Claude Code starts but agents don't appear in /help
```

**Solution:**
```bash
# 1. Verify framework version
cat .claude/settings.json | jq '.extraKnownMarketplaces."Claude-Dev-Framework".source.ref'

# 2. Check version exists
gh api repos/fda3r6sbvdgq09gse2/claude-dev-framework/git/refs/tags/v2.0.0

# 3. Restart Claude Code
# (Framework loads on startup)

# 4. Check for errors
# Look for framework loading errors in Claude Code output
```

### Issue: Version Mismatch

**Symptoms:**
```
STARTUP_VARIABLES.yaml says v2.0.0
.claude/settings.json says v1.0.0
```

**Solution:**
```bash
# Re-sync settings
./scripts/upgrade-framework.sh v2.0.0

# Verify both match
grep "version:" STARTUP_VARIABLES.yaml
jq '.extraKnownMarketplaces."Claude-Dev-Framework".source.ref' .claude/settings.json
```

### Issue: Breaking Changes in Projects

**Symptoms:**
```
Projects that worked with v1.0 fail with v2.0
```

**Solution:**
```bash
# 1. Read migration guide
gh api repos/fda3r6sbvdgq09gse2/claude-dev-framework/releases/tags/v2.0.0 | jq -r '.body'

# 2. Check what changed
git log --oneline v1.0.0..v2.0.0 --oneline

# 3. Update your code to match new API
# (Framework maintainer should provide migration guide)

# 4. If too complex, stay on v1.x until migration is ready
./scripts/upgrade-framework.sh v1.9.9
```

---

## 📊 Upgrade Impact Matrix

| Version Jump | Risk | Testing Time | Rollback Difficulty | Recommended Approach |
|--------------|------|--------------|---------------------|----------------------|
| 1.0.0 → 1.0.1 | 🟢 Low | 5 min | Easy | Direct upgrade |
| 1.0.0 → 1.1.0 | 🟡 Medium | 15 min | Easy | Test in dev first |
| 1.0.0 → 2.0.0 | 🔴 High | 30-60 min | Medium | Feature branch + staged |
| 1.0.0 → 3.0.0 | 🔴 Very High | 2-4 hours | Hard | Migration project |

---

## 🎓 Best Practices

### DO ✅

1. **Read release notes** before upgrading
   - Understand what changed
   - Check for breaking changes
   - Review new features

2. **Test in development first**
   - Never upgrade production directly
   - Use staged rollout approach

3. **Keep a backup**
   - Git tags before upgrade
   - Document rollback procedure

4. **Communicate with team**
   - Inform before upgrading shared workspace
   - Document what version is in use

5. **Update gradually**
   - Don't skip major versions
   - 1.0 → 1.1 → 2.0 is safer than 1.0 → 2.0

### DON'T ❌

1. **Don't upgrade blindly**
   - Always read release notes
   - Understand impact

2. **Don't skip testing**
   - Even "small" upgrades need verification
   - Automated tests are your friend

3. **Don't upgrade Friday afternoon**
   - Give yourself time to fix issues
   - Monday morning is better

4. **Don't upgrade all workspaces at once**
   - Start with dev, then staging, then prod
   - Learn from early deployments

---

## 📞 Getting Help

**Upgrade Issues:**
- Check: https://github.com/fda3r6sbvdgq09gse2/claude-dev-framework/issues
- Search for: "upgrade" or your version numbers
- Create issue if not found

**Migration Guides:**
- Framework repo: docs/MIGRATION_v1_to_v2.md
- Release notes: GitHub releases

**Community:**
- Framework discussions
- Ask in issues with `upgrade` label

---

## 📚 Related Documentation

- [QUICK_START.md](QUICK_START.md) - Initial setup
- [CUSTOMIZATION.md](CUSTOMIZATION.md) - Configuration options
- [ARCHITECTURE.md](ARCHITECTURE.md) - How upgrades work
- [scripts/upgrade-framework.sh](../scripts/upgrade-framework.sh) - Automated upgrade script

---

**Last Updated:** 2025-10-16
**Template Version:** 1.0.0
**Covers Framework Versions:** 1.0.0 → 2.x.x
