# Framework Improvement: Parallel Sprint Workflow with Git Worktrees
**Date:** 2025-10-16
**Discovered In:** book-cataloger / Sprint planning
**Priority:** CRITICAL
**Status:** Proposed → To Be Implemented

---

## Problem

**Current Manual Process:**
- Setting up parallel agent branches is tedious
- No standardized workflow for multi-agent sprints
- Brain/CEO merge process is ad-hoc
- Testing coordination is unclear
- Human handoff is ambiguous

**What's Missing:**
- Automated sprint setup commands
- Clear branching strategy
- Merge coordination protocol
- Testing pipeline integration
- Human testing handoff

---

## Current Behavior

**Manual steps required:**
```bash
# For each agent manually:
git checkout -b feature/backend-sprint-7A
git worktree add ~/worktrees/backend-sprint-7A feature/backend-sprint-7A

# Repeat for frontend, integration, testing...
# No standardization, easy to make mistakes
```

---

## Proposed Solution

### Complete Parallel Sprint Workflow

```
┌─────────────────────────────────────────────────────────────┐
│ Phase 1: Sprint Launch (Automated)                          │
│ • CEO plans sprint                                          │
│ • Create branches for all agents                           │
│ • Set up git worktrees                                     │
│ • Initialize sprint context                                │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ Phase 2: Parallel Development (Agent Work)                  │
│                                                             │
│  Backend Agent          Frontend Agent      Testing Agent   │
│      │                       │                   │          │
│      ├─ feature/backend      ├─ feature/frontend ├─ feature/testing
│      ├─ Work in parallel     ├─ Work in parallel ├─ Work in parallel
│      └─ Commit to branch     └─ Commit to branch └─ Commit to branch
│                                                             │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ Phase 3: Integration (Brain/CEO Coordinates)                │
│ • Review all agent branches                                 │
│ • Resolve conflicts                                         │
│ • Merge to integration branch                              │
│ • Run integration tests                                     │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ Phase 4: Automated Testing (Playwright/Pytest)              │
│ • Unit tests (all modules)                                  │
│ • Integration tests (API, DB, UI)                          │
│ • E2E tests (Playwright for UI)                            │
│ • Performance tests                                         │
│ • Generate test report                                      │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ Phase 5: Human Testing & Approval                           │
│ • Human reviews integration branch                          │
│ • Tests manually                                            │
│ • Provides feedback                                         │
│ • Approves or requests changes                             │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ Phase 6: Merge to Main & Sprint Closure                    │
│ • Merge integration → main                                  │
│ • Clean up worktrees                                        │
│ • Archive sprint artifacts                                 │
│ • Run retrospective                                         │
│ • Extract learnings                                         │
└─────────────────────────────────────────────────────────────┘
```

---

## Implementation Plan

### Commands to Create

#### 1. `/launch-sprint [number] [name]`

**Purpose:** Set up complete sprint environment

```bash
/launch-sprint 7A "Camera Scanner Completion"

# What it does:
# 1. Create sprint planning doc
# 2. Create branches: feature/backend, feature/frontend, etc.
# 3. Set up git worktrees in $HOME/.claude-workers/
# 4. Initialize sprint context for each agent
# 5. Update PROJECT_VARIABLES.yaml with sprint info
# 6. Create sprint directory: .ai/sprints/sprint-7A/
```

**File:** `.claude/commands/launch-sprint.md`

```markdown
# Launch Sprint

Create sprint environment with parallel agent workflows.

## Usage

/launch-sprint [sprint-number] "[sprint-name]"

Example: /launch-sprint 7A "Camera Scanner Completion"

## Process

1. **Create Sprint Plan:**
   - File: .ai/sprints/sprint-[number]/PLAN.md
   - Include: Goals, tasks, agents, timeline

2. **Ask: Which agents?**
   - Options: backend, frontend, integration, testing, devops, documentation
   - Default: backend, frontend, testing

3. **Create Git Branches:**
   ```bash
   git checkout main
   git pull origin main

   # For each selected agent:
   git branch feature/[agent]-sprint-[number]
   ```

4. **Set Up Worktrees:**
   ```bash
   mkdir -p $HOME/.claude-workers/[project-name]

   # For each agent:
   git worktree add $HOME/.claude-workers/[project-name]/[agent]-sprint-[number] feature/[agent]-sprint-[number]
   ```

5. **Initialize Agent Context:**
   Create in each worktree:
   ```
   .ai/sprints/sprint-[number]/
   ├── PLAN.md              # Sprint goals
   ├── agent-[name].md      # Agent-specific tasks
   └── INTEGRATION.md       # Integration checklist
   ```

6. **Update PROJECT_VARIABLES.yaml:**
   ```yaml
   sprints:
     current:
       number: "[sprint-number]"
       name: "[sprint-name]"
       phase: "development"
       agents: [list]
       branches:
         backend: "feature/backend-sprint-[number]"
         frontend: "feature/frontend-sprint-[number]"
         # etc.
   ```

7. **Display Summary:**
   ```
   ✅ Sprint [number] Launched: [name]

   Agents:
   • Backend:  $HOME/.claude-workers/[project]/backend-sprint-[number]
   • Frontend: $HOME/.claude-workers/[project]/frontend-sprint-[number]
   • Testing:  $HOME/.claude-workers/[project]/testing-sprint-[number]

   Branches:
   • feature/backend-sprint-[number]
   • feature/frontend-sprint-[number]
   • feature/testing-sprint-[number]

   Next Steps:
   1. Agents work in parallel (separate Claude Code sessions)
   2. When done, run: /integrate-sprint [number]
   ```
```

#### 2. `/integrate-sprint [number]`

**Purpose:** Brain/CEO merges all agent branches

```markdown
# Integrate Sprint

Merge all agent branches into integration branch.

## Usage

/integrate-sprint [sprint-number]

Example: /integrate-sprint 7A

## Process

1. **Create Integration Branch:**
   ```bash
   git checkout main
   git pull origin main
   git checkout -b integration/sprint-[number]
   ```

2. **Review Agent Branches:**
   For each agent branch:
   ```bash
   git log feature/[agent]-sprint-[number] --oneline
   git diff main..feature/[agent]-sprint-[number]
   ```

3. **Merge Agents Sequentially:**
   ```bash
   # Merge backend first (usually has models, database)
   git merge feature/backend-sprint-[number] --no-ff -m "Merge backend work from sprint [number]"

   # Then frontend (depends on backend)
   git merge feature/frontend-sprint-[number] --no-ff -m "Merge frontend work from sprint [number]"

   # Then integration
   git merge feature/integration-sprint-[number] --no-ff -m "Merge integration work from sprint [number]"

   # Finally testing
   git merge feature/testing-sprint-[number] --no-ff -m "Merge testing work from sprint [number]"
   ```

4. **Resolve Conflicts:**
   If conflicts arise:
   - Review both changes
   - Merge intelligently
   - Test resolution
   - Commit

5. **Run Integration Tests:**
   ```bash
   pytest tests/integration/
   # If failures, fix before proceeding
   ```

6. **Create Integration Checklist:**
   File: `.ai/sprints/sprint-[number]/INTEGRATION_RESULTS.md`
   ```markdown
   # Sprint [number] Integration Results

   ## Branches Merged
   - [x] Backend: feature/backend-sprint-[number]
   - [x] Frontend: feature/frontend-sprint-[number]
   - [x] Testing: feature/testing-sprint-[number]

   ## Conflicts Resolved
   - Conflict 1: [description and resolution]
   - Conflict 2: [description and resolution]

   ## Integration Tests
   - [x] All unit tests pass
   - [x] All integration tests pass
   - [ ] E2E tests pass
   - [ ] Performance tests pass

   ## Ready for Human Testing: [YES/NO]
   ```

7. **Push Integration Branch:**
   ```bash
   git push origin integration/sprint-[number]
   ```

8. **Display Summary:**
   ```
   ✅ Sprint [number] Integrated

   Integration Branch: integration/sprint-[number]
   Commits: [count]
   Conflicts Resolved: [count]
   Tests Passing: [yes/no]

   Next Steps:
   1. Review integration results
   2. Run: /test-sprint [number] (automated tests)
   3. Run: /human-test-sprint [number] (manual testing)
   ```
```

#### 3. `/test-sprint [number]`

**Purpose:** Run all automated tests

```markdown
# Test Sprint

Run complete automated test suite.

## Usage

/test-sprint [sprint-number]

Example: /test-sprint 7A

## Process

1. **Checkout Integration Branch:**
   ```bash
   git checkout integration/sprint-[number]
   ```

2. **Run Test Suite:**
   ```bash
   # Unit tests
   pytest tests/unit/ -v --cov=src --cov-report=html

   # Integration tests
   pytest tests/integration/ -v

   # E2E tests with Playwright (if UI exists)
   pytest tests/e2e/ --headed

   # Performance tests
   pytest tests/performance/ --benchmark-only
   ```

3. **Generate Test Report:**
   File: `.ai/sprints/sprint-[number]/TEST_REPORT.md`
   ```markdown
   # Sprint [number] Test Report
   **Date:** [timestamp]
   **Branch:** integration/sprint-[number]

   ## Unit Tests
   - Total: [count]
   - Passed: [count]
   - Failed: [count]
   - Coverage: [percentage]%

   ## Integration Tests
   - Total: [count]
   - Passed: [count]
   - Failed: [count]

   ## E2E Tests (Playwright)
   - Total: [count]
   - Passed: [count]
   - Failed: [count]
   - Screenshots: [directory]

   ## Performance Tests
   - Benchmark results: [summary]

   ## Failed Tests
   [List any failures with details]

   ## Ready for Human Testing: [YES/NO]
   ```

4. **Display Summary:**
   ```
   ✅ Sprint [number] Automated Testing Complete

   Results:
   • Unit Tests:        [passed]/[total] ([coverage]%)
   • Integration Tests: [passed]/[total]
   • E2E Tests:         [passed]/[total]
   • Performance:       [PASS/FAIL]

   Report: .ai/sprints/sprint-[number]/TEST_REPORT.md

   Next Steps:
   [If all pass]
   ✅ Ready for human testing!
   Run: /human-test-sprint [number]

   [If failures]
   ⚠️ Fix failing tests first
   Review: TEST_REPORT.md
   ```
```

#### 4. `/human-test-sprint [number]`

**Purpose:** Prepare for and guide human testing

```markdown
# Human Test Sprint

Prepare integration branch for human testing and track feedback.

## Usage

/human-test-sprint [sprint-number]

Example: /human-test-sprint 7A

## Process

1. **Create Testing Checklist:**
   File: `.ai/sprints/sprint-[number]/HUMAN_TEST_CHECKLIST.md`
   ```markdown
   # Sprint [number] Human Testing Checklist
   **Tester:** [Name]
   **Date:** [Date]
   **Branch:** integration/sprint-[number]

   ## Setup
   - [ ] Checkout integration branch
   - [ ] Install dependencies
   - [ ] Run application
   - [ ] Verify startup

   ## Features to Test
   [For each feature added in sprint]
   - [ ] Feature 1: [description]
     - [ ] Happy path works
     - [ ] Error handling works
     - [ ] UI is intuitive
     - [ ] Performance acceptable
     - Notes: ___________

   - [ ] Feature 2: [description]
     - [ ] Happy path works
     - [ ] Error handling works
     - [ ] UI is intuitive
     - [ ] Performance acceptable
     - Notes: ___________

   ## Regression Testing
   - [ ] Existing features still work
   - [ ] No new bugs introduced
   - [ ] Performance hasn't degraded

   ## Overall Assessment
   - [ ] Ready to merge to main
   - [ ] Minor fixes needed
   - [ ] Major rework needed

   ## Feedback
   [Space for detailed feedback]

   ## Issues Found
   1. Issue: ___________
      Severity: [Critical/High/Medium/Low]
      Steps to reproduce: ___________

   ## Sign-off
   - [ ] Approved by: [Name]
   - [ ] Date: [Date]
   ```

2. **Display Testing Instructions:**
   ```
   ═══════════════════════════════════════════════════════════
   🧪 HUMAN TESTING READY: Sprint [number]
   ═══════════════════════════════════════════════════════════

   Branch: integration/sprint-[number]

   To test:

   1. Checkout the integration branch:
      git checkout integration/sprint-[number]

   2. Install dependencies (if needed):
      [installation commands]

   3. Run the application:
      [run commands]

   4. Follow the checklist:
      open .ai/sprints/sprint-[number]/HUMAN_TEST_CHECKLIST.md

   5. Record your feedback in the checklist

   6. When done, run:
      /finalize-sprint [number] [approve|request-changes]

   ═══════════════════════════════════════════════════════════
   ```

3. **Wait for Human Feedback:**
   - Human tests following checklist
   - Records issues and feedback
   - Makes approval decision

4. **Next Step Depends on Feedback:**
   ```
   If approved:     /finalize-sprint [number] approve
   If changes needed: /finalize-sprint [number] request-changes
   ```
```

#### 5. `/finalize-sprint [number] [approve|request-changes]`

**Purpose:** Complete sprint based on human testing

```markdown
# Finalize Sprint

Complete sprint workflow based on human testing results.

## Usage

/finalize-sprint [sprint-number] [approve|request-changes]

Examples:
- /finalize-sprint 7A approve
- /finalize-sprint 7A request-changes

## If Approved

1. **Merge to Main:**
   ```bash
   git checkout main
   git pull origin main
   git merge integration/sprint-[number] --no-ff -m "Complete Sprint [number]: [name]

   [Summary of changes]

   Tested-by: [Human name]
   All-tests: PASS"

   git push origin main
   ```

2. **Tag Release (if applicable):**
   ```bash
   git tag -a sprint-[number] -m "Sprint [number]: [name]"
   git push origin sprint-[number]
   ```

3. **Clean Up Worktrees:**
   ```bash
   # For each agent:
   git worktree remove $HOME/.claude-workers/[project]/[agent]-sprint-[number]

   # Delete remote feature branches (optional)
   git push origin --delete feature/backend-sprint-[number]
   git push origin --delete feature/frontend-sprint-[number]
   # etc.
   ```

4. **Archive Sprint:**
   ```bash
   # Sprint artifacts are already in .ai/sprints/sprint-[number]/
   # Add final status
   ```

   File: `.ai/sprints/sprint-[number]/FINAL_STATUS.md`
   ```markdown
   # Sprint [number] Final Status

   **Name:** [sprint name]
   **Duration:** [X days]
   **Agents:** [list]
   **Status:** ✅ COMPLETED

   ## Delivered
   - Feature 1
   - Feature 2
   - Feature 3

   ## Metrics
   - Commits: [count]
   - Files Changed: [count]
   - Lines Added: [count]
   - Lines Removed: [count]
   - Tests Added: [count]
   - Test Coverage: [percentage]%

   ## Human Testing
   - Tester: [name]
   - Result: APPROVED
   - Issues Found: [count]
   - Issues Fixed: [count]

   ## Merged
   - Date: [date]
   - Commit: [sha]
   - Tag: sprint-[number]
   ```

5. **Run Retrospective:**
   ```bash
   /retrospective [number]
   ```

6. **Display Summary:**
   ```
   ✅ Sprint [number] COMPLETED & MERGED TO MAIN

   Summary:
   • Agents: [list]
   • Duration: [X days]
   • Features: [count]
   • Tests: All passing
   • Human Testing: Approved

   Merged:
   • Commit: [sha]
   • Tag: sprint-[number]

   Artifacts:
   • Sprint docs: .ai/sprints/sprint-[number]/
   • Test reports: [link]
   • Retrospective: [link]

   Next:
   • Sprint [number] is complete!
   • Ready to plan next sprint
   • Run: /launch-sprint [next] "[name]"
   ```

## If Changes Requested

1. **Document Requested Changes:**
   File: `.ai/sprints/sprint-[number]/CHANGES_REQUESTED.md`
   ```markdown
   # Sprint [number] Changes Requested

   **Requested by:** [Human name]
   **Date:** [date]

   ## Issues Found
   [Copy from human test checklist]

   ## Changes Required
   1. Issue 1: [fix required]
   2. Issue 2: [fix required]

   ## Plan
   - Assign to: [which agent]
   - Estimated time: [hours/days]
   - Will re-test: [yes/no]
   ```

2. **Notify Relevant Agents:**
   ```
   ⚠️ Sprint [number] requires changes before merge

   Issues:
   • [Issue 1]
   • [Issue 2]

   Next Steps:
   1. Review: .ai/sprints/sprint-[number]/CHANGES_REQUESTED.md
   2. Fix issues in feature branch
   3. Re-run: /integrate-sprint [number]
   4. Re-run: /test-sprint [number]
   5. Re-run: /human-test-sprint [number]
   ```

3. **Keep Sprint Active:**
   - Don't merge to main
   - Don't clean up worktrees
   - Continue iteration

```

#### 6. `/retrospective [number]`

**Purpose:** Sprint retrospective and learning extraction

```markdown
# Sprint Retrospective

Conduct retrospective and extract learnings.

## Usage

/retrospective [sprint-number]

Example: /retrospective 7A

## Process

1. **Create Retrospective Document:**
   File: `.ai/sprints/sprint-[number]/RETROSPECTIVE.md`
   ```markdown
   # Sprint [number] Retrospective
   **Date:** [date]
   **Participants:** [agents + human]
   **Duration:** [X days]

   ## What Went Well ✅
   - Item 1
   - Item 2
   - Item 3

   ## What Could Be Improved ⚠️
   - Item 1: [suggestion]
   - Item 2: [suggestion]
   - Item 3: [suggestion]

   ## What We Learned 🎓
   - Learning 1
   - Learning 2
   - Learning 3

   ## Metrics
   - Planned vs Actual Duration: [X days vs Y days]
   - Planned vs Delivered Features: [X vs Y]
   - Test Coverage: [percentage]%
   - Issues Found in Human Testing: [count]
   - Time to Fix Issues: [hours]

   ## Action Items for Next Sprint
   - [ ] Action 1
   - [ ] Action 2
   - [ ] Action 3

   ## Framework Improvements Identified
   [Link to framework improvement suggestions]

   ## Patterns Discovered
   [Link to pattern documents]
   ```

2. **Extract Framework Improvements:**
   For each improvement identified:
   ```bash
   # Create in .ai/meta/framework-improvements/
   # Or .ai/meta/template-improvements/
   ```

3. **Archive Patterns:**
   ```bash
   # Move to .ai/patterns/
   # Document for reuse
   ```

4. **Display Summary:**
   ```
   ✅ Retrospective Complete: Sprint [number]

   Highlights:
   • What Went Well: [count items]
   • Improvements: [count items]
   • Learnings: [count items]
   • Framework Suggestions: [count]
   • Patterns Extracted: [count]

   Documents:
   • .ai/sprints/sprint-[number]/RETROSPECTIVE.md
   • Framework improvements in .ai/meta/

   Knowledge compounding in action! 🚀
   ```
```

---

## Benefits

**Time Savings:**
- Sprint setup: 60 min → 5 min (12x faster)
- Integration: 90 min → 15 min (6x faster)
- Testing coordination: 30 min → 5 min (6x faster)
- **Total per sprint: 180 min → 25 min (7x faster)**

**Error Prevention:**
- Branch naming consistency
- Worktree setup errors
- Merge conflict reduction
- Testing gaps
- Documentation omissions

**Usability:**
- Clear workflow
- Standardized process
- Better coordination
- Automated checklists
- Knowledge capture

**Reusability:**
- Every project using sprints benefits
- Consistent across teams
- Easy to teach
- Scales to any project size

---

## Example Usage

### Complete Sprint Cycle

```bash
# Week 1: Launch Sprint
/launch-sprint 7A "Camera Scanner Completion"
# → Creates branches, worktrees, context
# → Agents work in parallel

# Day 3: Integration
/integrate-sprint 7A
# → Brain merges all agent branches
# → Resolves conflicts
# → Runs integration tests

# Day 3: Automated Testing
/test-sprint 7A
# → Runs all tests
# → Generates report

# Day 3-4: Human Testing
/human-test-sprint 7A
# → Human tests following checklist
# → Records feedback

# Day 4: Finalize
/finalize-sprint 7A approve
# → Merges to main
# → Cleans up worktrees
# → Archives sprint

# Day 5: Learn
/retrospective 7A
# → Extracts learnings
# → Identifies improvements
# → Compounds knowledge
```

---

## Related Patterns

- Multi-agent coordination
- Git worktree management
- Branch strategy
- Testing pyramid
- Human-AI collaboration

---

## Implementation Status

**Phase 1: Document (Current)**
- [x] Define complete workflow
- [x] Specify all commands
- [x] Detail implementation

**Phase 2: Prototype in blackford-workspace**
- [ ] Create `/launch-sprint` command
- [ ] Create `/integrate-sprint` command
- [ ] Create `/test-sprint` command
- [ ] Create `/human-test-sprint` command
- [ ] Create `/finalize-sprint` command
- [ ] Create `/retrospective` command
- [ ] Test with Sprint 7A

**Phase 3: Refine**
- [ ] Gather feedback from Sprint 7A
- [ ] Fix issues
- [ ] Improve UX
- [ ] Add error handling

**Phase 4: Extract to Framework**
- [ ] Move to claude-dev-framework
- [ ] Generalize for all projects
- [ ] Document in framework
- [ ] Release in v1.1.0

**Phase 5: Template Integration**
- [ ] Update claude-workspace-template
- [ ] Add sprint management docs
- [ ] Include in quick start
- [ ] Release template v1.1.0

---

## ROI Calculation

**Time Investment:**
- Design: 2 hours ✅
- Implementation: 8 hours
- Testing: 4 hours
- Documentation: 2 hours
- **Total: 16 hours**

**Time Saved Per Sprint:**
- Setup: 55 min
- Integration: 75 min
- Testing: 25 min
- Documentation: 30 min
- **Total: 185 min = 3 hours**

**Break-even:** After 5.3 sprints

**With 20 sprints/year:**
- Time saved: 60 hours/year
- Error reduction: ~20 issues/year
- **High ROI improvement**

---

## Status Updates

- **2025-10-16:** Proposed, documented complete workflow
- **TBD:** Prototype in blackford-workspace Sprint 7A
- **TBD:** Extract to framework v1.1.0

---

*This improvement turns sprint management from manual to automated, saving hours per sprint and ensuring consistency across all projects.*
