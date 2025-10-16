# Claude Code Todo Workflow Integration

**Purpose**: Integrate Claude Code's native todo system with the knowledge compounding framework
**Audience**: Developers, AI agents, team leads
**Integration**: Works seamlessly with sprint cycles and learning capture

---

## Table of Contents

1. [Overview](#overview)
2. [How Claude Code Todos Work](#how-claude-code-todos-work)
3. [Todo Lifecycle](#todo-lifecycle)
4. [Integration with Sprints](#integration-with-sprints)
5. [Integration with Knowledge Compounding](#integration-with-knowledge-compounding)
6. [Best Practices](#best-practices)
7. [Templates](#templates)
8. [Examples](#examples)

---

## Overview

### What Are Claude Code Todos?

Claude Code has a built-in todo management system that allows AI agents to:
- Track work in progress
- Break complex tasks into manageable steps
- Provide visibility into current activities
- Maintain context between sessions
- Coordinate multi-step workflows

### Why Integrate with Our Framework?

```
Claude Code Todos (execution tracking)
    +
Knowledge Compounding System (learning capture)
    =
Complete workflow that improves over time
```

**Benefits**:
- **During Development**: Clear task tracking
- **After Sprint**: Todo patterns become learnings
- **Framework Evolution**: Common todo patterns → template improvements
- **Knowledge Compounds**: Better todos → faster development → better framework

---

## How Claude Code Todos Work

### Basic Mechanics

Claude Code agents use a `TodoWrite` tool to manage tasks:

```typescript
TodoWrite({
  todos: [
    {
      content: "Fix authentication bug",
      status: "pending",
      activeForm: "Fixing authentication bug"
    },
    {
      content: "Write tests for auth fix",
      status: "in_progress",
      activeForm: "Writing auth tests"
    },
    {
      content: "Update documentation",
      status: "completed",
      activeForm: "Updating documentation"
    }
  ]
})
```

### Todo States

| State | Meaning | When to Use |
|-------|---------|-------------|
| `pending` | Not started | Task is queued |
| `in_progress` | Currently working | Agent is actively working on this |
| `completed` | Finished | Task is done |

**IMPORTANT**: Only ONE task should be `in_progress` at a time.

### Todo Format Requirements

Each todo must have TWO forms:

1. **content**: Imperative form (what needs doing)
   - Example: "Run tests", "Fix bug", "Deploy to production"

2. **activeForm**: Present continuous (what's happening now)
   - Example: "Running tests", "Fixing bug", "Deploying to production"

**Why Two Forms?**
- `content`: Shows in task list (what to do)
- `activeForm`: Shows during execution (what's happening)
- Provides clear communication to users

---

## Todo Lifecycle

### Phase 1: Planning (Sprint Start)

**When**: Beginning of sprint, agent receives objectives
**Who**: CEO agent or human developer
**What**: Break sprint into actionable todos

```markdown
## Sprint 7A: Camera Scanner Improvements

**Agent: backend**
- [ ] Research OpenCV barcode detection APIs
- [ ] Implement ISBN-13 detection algorithm
- [ ] Add image preprocessing pipeline
- [ ] Write unit tests for scanner
- [ ] Integration test with real images

**Agent: frontend**
- [ ] Design camera preview UI
- [ ] Implement capture button with feedback
- [ ] Add progress indicator
- [ ] Handle camera permissions
- [ ] Test on different screen sizes
```

### Phase 2: Execution (During Sprint)

**Real-time todo management**:

```python
# Agent starts work
TodoWrite([
  {
    "content": "Research OpenCV barcode detection APIs",
    "status": "in_progress",
    "activeForm": "Researching OpenCV APIs"
  },
  {
    "content": "Implement ISBN-13 detection algorithm",
    "status": "pending",
    "activeForm": "Implementing ISBN detection"
  }
])

# ... does research, finds solution ...

# Agent completes research, moves to next
TodoWrite([
  {
    "content": "Research OpenCV barcode detection APIs",
    "status": "completed",
    "activeForm": "Researching OpenCV APIs"
  },
  {
    "content": "Implement ISBN-13 detection algorithm",
    "status": "in_progress",
    "activeForm": "Implementing ISBN detection"
  }
])
```

**Key Rule**: Mark completed IMMEDIATELY, don't batch completions.

### Phase 3: Blocking (When Stuck)

**If agent encounters blocker**:

```python
# Agent discovers issue
TodoWrite([
  {
    "content": "Implement ISBN-13 detection algorithm",
    "status": "in_progress",  # Keep in_progress, NOT completed
    "activeForm": "Implementing ISBN detection"
  },
  {
    "content": "Resolve: OpenCV version incompatibility",
    "status": "pending",
    "activeForm": "Resolving OpenCV version issue"
  }
])
```

**NEVER** mark blocked tasks as completed.

### Phase 4: Sprint Completion

**At end of sprint**:
1. All todos should be `completed` or documented as blocked
2. Capture todo patterns in learning notes
3. Extract common workflows for templates

---

## Integration with Sprints

### Sprint Planning → Initial Todos

**File**: `.ai/sprints/sprint-7A/plan.md`

```markdown
# Sprint 7A: Camera Scanner Improvements

## Objectives
1. Improve barcode detection accuracy
2. Add real-time camera preview
3. Handle edge cases (blur, angle, lighting)

## Todos by Agent

### backend (Priority: HIGH)
- [ ] Research OpenCV barcode detection
- [ ] Implement ISBN-13 detection
- [ ] Add image preprocessing
- [ ] Write scanner unit tests
- [ ] Integration tests with real images

### frontend (Priority: HIGH)
- [ ] Design camera preview UI
- [ ] Implement capture button
- [ ] Add progress indicator
- [ ] Handle camera permissions
- [ ] Screen size testing

### testing (Priority: MEDIUM)
- [ ] Create test image dataset
- [ ] Barcode accuracy benchmarks
- [ ] Performance testing
- [ ] User acceptance testing
```

### During Sprint → Dynamic Todos

Agents update todos in real-time as they work. Humans can see progress:

```bash
claude  # Start agent
```

**Agent displays**:
```
📋 Current Tasks:
✅ Research OpenCV barcode detection
🔄 Implementing ISBN-13 detection algorithm
⏳ Add image preprocessing
⏳ Write scanner unit tests
```

### Sprint Retrospective → Learning Capture

**File**: `.ai/sprints/sprint-7A/retrospective.md`

```markdown
# Sprint 7A Retrospective

## Todo Pattern Analysis

### What Worked Well

**Backend todos were well-scoped**:
- Each task 2-4 hours
- Clear success criteria
- Logical dependencies

**Learning**:
- Research → Implement → Test pattern works great
- Capture in: `.ai/meta/patterns/research-implement-test.md`

### What Didn't Work

**Frontend todos were too large**:
- "Design camera preview UI" took 2 days (expected 4 hours)
- Should have been: "Sketch UI layout", "Implement basic preview", "Add styling"

**Learning**:
- UI tasks need finer granularity
- Add to: `.ai/meta/learnings/todo-sizing-rules.md`

### Blocked Todos

**OpenCV version incompatibility (2 hours lost)**:
- Todo stayed `in_progress` (correct!)
- Created new todo for resolution
- Documented in learnings

**Learning**:
- Always check dependencies first
- Add "Verify dependencies" to todo templates
```

---

## Integration with Knowledge Compounding

### Capture Todo Patterns

**Good todo patterns become templates**:

```markdown
# .ai/meta/patterns/api-integration-todos.md

## Pattern: API Integration Todo Sequence

**Context**: Adding new external API

**Todo Sequence**:
1. Research API documentation
2. Create API client wrapper
3. Write unit tests for client
4. Implement rate limiting
5. Add error handling
6. Integration tests
7. Update monitoring

**Why this order?**
- Research first prevents false starts
- Tests before integration catch issues early
- Rate limiting/errors before integration prevents production issues

**Reusability**: HIGH - Use for every new API
```

### Extract Common Workflows

**File**: `.ai/meta/learnings/common-todo-workflows.md`

```markdown
# Common Todo Workflows Discovered

## 1. Feature Development Workflow

**Pattern**: Research → Design → Implement → Test → Document

**Todos**:
- [ ] Research existing solutions
- [ ] Design approach and interfaces
- [ ] Implement core functionality
- [ ] Write unit tests
- [ ] Write integration tests
- [ ] Update documentation

**When to use**: New features
**Success rate**: 95% (from 12 sprints)

## 2. Bug Fix Workflow

**Pattern**: Reproduce → Diagnose → Fix → Test → Prevent

**Todos**:
- [ ] Reproduce bug locally
- [ ] Write failing test
- [ ] Diagnose root cause
- [ ] Implement fix
- [ ] Verify test passes
- [ ] Add regression test
- [ ] Document in CHANGELOG

**When to use**: Bug fixes
**Success rate**: 98% (from 47 bugs)

## 3. Refactoring Workflow

**Pattern**: Document → Test → Refactor → Verify

**Todos**:
- [ ] Document current behavior
- [ ] Add characterization tests
- [ ] Refactor code
- [ ] Run full test suite
- [ ] Performance comparison
- [ ] Update documentation

**When to use**: Code quality improvements
**Success rate**: 90% (from 8 refactors)
```

### Feed Back to Framework

**These patterns → Framework v2.0 improvements**:

```yaml
# claude-dev-framework/templates/feature-development-todos.yaml

name: "Feature Development"
description: "Standard todo sequence for new features"

todos:
  - content: "Research existing solutions and approaches"
    activeForm: "Researching solutions"
    estimated_hours: 2

  - content: "Design approach and interfaces"
    activeForm: "Designing approach"
    estimated_hours: 4

  - content: "Implement core functionality"
    activeForm: "Implementing core functionality"
    estimated_hours: 8

  - content: "Write unit tests"
    activeForm: "Writing unit tests"
    estimated_hours: 4

  - content: "Write integration tests"
    activeForm: "Writing integration tests"
    estimated_hours: 4

  - content: "Update documentation"
    activeForm: "Updating documentation"
    estimated_hours: 2

total_estimated_hours: 24
success_rate: 0.95
times_used: 12
```

**Result**: Framework v2.0 includes todo templates, new projects start faster!

---

## Best Practices

### 1. Todo Sizing

**Good todo**: Can be completed in 2-4 hours
```
✅ "Implement user login endpoint"
✅ "Write tests for login validation"
✅ "Add rate limiting to login"
```

**Bad todo**: Too large (will take days)
```
❌ "Build authentication system"
❌ "Implement frontend"
❌ "Fix all bugs"
```

**Fix**: Break into smaller pieces
```
✅ "Build authentication system" becomes:
  - Implement user login endpoint
  - Implement user registration endpoint
  - Add password reset flow
  - Implement session management
  - Add OAuth integration
```

### 2. Todo Dependencies

**Make dependencies explicit**:

```python
TodoWrite([
  {
    "content": "Design database schema",
    "status": "completed",
    "activeForm": "Designing database schema"
  },
  {
    "content": "Implement database models (depends on schema)",
    "status": "in_progress",
    "activeForm": "Implementing database models"
  },
  {
    "content": "Write API endpoints (depends on models)",
    "status": "pending",
    "activeForm": "Writing API endpoints"
  }
])
```

**Benefits**:
- Clear order of operations
- Prevents out-of-order work
- Shows blocked state when dependency isn't ready

### 3. Todo Granularity by Phase

**Planning Phase**: High-level todos
```
- [ ] Implement camera scanner
- [ ] Add data enrichment
- [ ] Build UI
```

**Execution Phase**: Detailed todos
```
- [ ] Research OpenCV barcode APIs
- [ ] Implement ISBN-13 detection
- [ ] Add image preprocessing
- [ ] Write unit tests
- [ ] Integration tests
```

**Why?**: Planning needs overview, execution needs specifics.

### 4. Completion Criteria

**Every todo should have clear completion criteria**:

```
❌ "Improve performance"  (How much? When done?)
✅ "Reduce API response time to <200ms"  (Measurable)

❌ "Fix bugs"  (Which ones? How many?)
✅ "Fix authentication timeout bug (#123)"  (Specific)

❌ "Add tests"  (How many? For what?)
✅ "Achieve >85% test coverage for auth module"  (Measurable)
```

### 5. Status Accuracy

**ONLY mark completed when truly done**:

```python
# ❌ WRONG - Tests are failing
TodoWrite([
  {
    "content": "Implement login endpoint",
    "status": "completed",  # But tests fail!
    "activeForm": "Implementing login"
  }
])

# ✅ CORRECT - Keep in_progress until tests pass
TodoWrite([
  {
    "content": "Implement login endpoint",
    "status": "in_progress",  # Tests failing, not done
    "activeForm": "Implementing login"
  },
  {
    "content": "Fix failing login tests",
    "status": "pending",
    "activeForm": "Fixing login tests"
  }
])
```

### 6. One In-Progress Rule

**Always exactly ONE todo in_progress**:

```python
# ❌ WRONG - Multiple in_progress
TodoWrite([
  {"content": "Task A", "status": "in_progress", ...},
  {"content": "Task B", "status": "in_progress", ...},  # Confusing!
])

# ✅ CORRECT - One in_progress
TodoWrite([
  {"content": "Task A", "status": "in_progress", ...},
  {"content": "Task B", "status": "pending", ...},
])
```

**Why?**: Clear focus, prevents context switching.

---

## Templates

### Sprint Planning Template

**File**: `.ai/templates/sprint-todos-template.md`

```markdown
# Sprint {{SPRINT_NUMBER}}: {{SPRINT_NAME}}

**Duration**: {{DURATION}} days
**Start Date**: {{START_DATE}}
**Objectives**: {{OBJECTIVES}}

---

## Agent: backend

### High Priority
- [ ] {{TODO_1}}
- [ ] {{TODO_2}}

### Medium Priority
- [ ] {{TODO_3}}

### Low Priority
- [ ] {{TODO_4}}

**Estimated Hours**: {{BACKEND_HOURS}}

---

## Agent: frontend

### High Priority
- [ ] {{TODO_1}}
- [ ] {{TODO_2}}

### Medium Priority
- [ ] {{TODO_3}}

**Estimated Hours**: {{FRONTEND_HOURS}}

---

## Agent: testing

### Critical Tests
- [ ] {{TODO_1}}
- [ ] {{TODO_2}}

**Estimated Hours**: {{TESTING_HOURS}}

---

## Total Estimated Hours: {{TOTAL_HOURS}}
## Success Criteria: {{CRITERIA}}
```

### Feature Development Template

**File**: `.ai/templates/feature-todos-template.md`

```markdown
# Feature: {{FEATURE_NAME}}

**Description**: {{DESCRIPTION}}
**Priority**: {{PRIORITY}}
**Assigned To**: {{AGENT}}

---

## Research Phase
- [ ] Research existing solutions
- [ ] Review similar features in codebase
- [ ] Document approach and alternatives

**Estimated**: 2-4 hours

---

## Design Phase
- [ ] Design API/interface
- [ ] Design data models
- [ ] Design UI components (if applicable)
- [ ] Review design with team

**Estimated**: 4-6 hours

---

## Implementation Phase
- [ ] Implement core functionality
- [ ] Add error handling
- [ ] Add logging/monitoring
- [ ] Code review

**Estimated**: 8-12 hours

---

## Testing Phase
- [ ] Write unit tests (>80% coverage)
- [ ] Write integration tests
- [ ] Manual testing
- [ ] Performance testing

**Estimated**: 4-6 hours

---

## Documentation Phase
- [ ] Update API documentation
- [ ] Update user documentation
- [ ] Add code comments
- [ ] Update CHANGELOG

**Estimated**: 2-3 hours

---

## Total Estimated: {{TOTAL_HOURS}} hours
## Definition of Done: {{DOD}}
```

### Bug Fix Template

**File**: `.ai/templates/bugfix-todos-template.md`

```markdown
# Bug Fix: {{BUG_TITLE}}

**Bug ID**: #{{BUG_NUMBER}}
**Severity**: {{SEVERITY}}
**Reported By**: {{REPORTER}}
**Assigned To**: {{AGENT}}

---

## Reproduce
- [ ] Reproduce bug locally
- [ ] Document steps to reproduce
- [ ] Create minimal test case

**Estimated**: 1-2 hours

---

## Diagnose
- [ ] Identify root cause
- [ ] Document root cause
- [ ] Check for similar issues

**Estimated**: 1-3 hours

---

## Fix
- [ ] Write failing test
- [ ] Implement fix
- [ ] Verify test passes
- [ ] Check for edge cases

**Estimated**: 2-4 hours

---

## Prevent
- [ ] Add regression tests
- [ ] Update related tests
- [ ] Document in CHANGELOG
- [ ] Update documentation

**Estimated**: 1-2 hours

---

## Verify
- [ ] Manual testing
- [ ] Run full test suite
- [ ] Performance check
- [ ] Code review

**Estimated**: 1-2 hours

---

## Total Estimated: {{TOTAL_HOURS}} hours
## Success Criteria: Bug no longer reproducible
```

---

## Examples

### Example 1: Sprint 7A - Backend Agent

**Initial Planning Todos**:

```python
TodoWrite([
  {
    "content": "Research OpenCV barcode detection APIs",
    "status": "pending",
    "activeForm": "Researching OpenCV barcode APIs"
  },
  {
    "content": "Implement ISBN-13 detection algorithm",
    "status": "pending",
    "activeForm": "Implementing ISBN-13 detection"
  },
  {
    "content": "Add image preprocessing pipeline",
    "status": "pending",
    "activeForm": "Adding image preprocessing"
  },
  {
    "content": "Write unit tests for scanner",
    "status": "pending",
    "activeForm": "Writing scanner unit tests"
  },
  {
    "content": "Integration test with real images",
    "status": "pending",
    "activeForm": "Running integration tests"
  }
])
```

**During Execution (Day 1, 2pm)**:

```python
TodoWrite([
  {
    "content": "Research OpenCV barcode detection APIs",
    "status": "completed",  # Finished, found cv2.barcode
    "activeForm": "Researching OpenCV barcode APIs"
  },
  {
    "content": "Implement ISBN-13 detection algorithm",
    "status": "in_progress",  # Currently writing code
    "activeForm": "Implementing ISBN-13 detection"
  },
  {
    "content": "Add image preprocessing pipeline",
    "status": "pending",
    "activeForm": "Adding image preprocessing"
  },
  {
    "content": "Write unit tests for scanner",
    "status": "pending",
    "activeForm": "Writing scanner unit tests"
  },
  {
    "content": "Integration test with real images",
    "status": "pending",
    "activeForm": "Running integration tests"
  }
])
```

**Encountered Blocker (Day 1, 4pm)**:

```python
TodoWrite([
  {
    "content": "Research OpenCV barcode detection APIs",
    "status": "completed",
    "activeForm": "Researching OpenCV barcode APIs"
  },
  {
    "content": "Implement ISBN-13 detection algorithm",
    "status": "in_progress",  # Still working - hit issue
    "activeForm": "Implementing ISBN-13 detection"
  },
  {
    "content": "Resolve: OpenCV version requires Python 3.11+",
    "status": "pending",  # New blocker task
    "activeForm": "Resolving Python version requirement"
  },
  {
    "content": "Add image preprocessing pipeline",
    "status": "pending",
    "activeForm": "Adding image preprocessing"
  },
  {
    "content": "Write unit tests for scanner",
    "status": "pending",
    "activeForm": "Writing scanner unit tests"
  },
  {
    "content": "Integration test with real images",
    "status": "pending",
    "activeForm": "Running integration tests"
  }
])
```

**After Resolution (Day 2, 10am)**:

```python
TodoWrite([
  {
    "content": "Research OpenCV barcode detection APIs",
    "status": "completed",
    "activeForm": "Researching OpenCV barcode APIs"
  },
  {
    "content": "Implement ISBN-13 detection algorithm",
    "status": "completed",  # Finally done!
    "activeForm": "Implementing ISBN-13 detection"
  },
  {
    "content": "Resolve: OpenCV version requires Python 3.11+",
    "status": "completed",  # Upgraded Python
    "activeForm": "Resolving Python version requirement"
  },
  {
    "content": "Add image preprocessing pipeline",
    "status": "in_progress",  # Now working on this
    "activeForm": "Adding image preprocessing"
  },
  {
    "content": "Write unit tests for scanner",
    "status": "pending",
    "activeForm": "Writing scanner unit tests"
  },
  {
    "content": "Integration test with real images",
    "status": "pending",
    "activeForm": "Running integration tests"
  }
])
```

**Sprint Complete (Day 3, 5pm)**:

```python
TodoWrite([
  {
    "content": "Research OpenCV barcode detection APIs",
    "status": "completed",
    "activeForm": "Researching OpenCV barcode APIs"
  },
  {
    "content": "Implement ISBN-13 detection algorithm",
    "status": "completed",
    "activeForm": "Implementing ISBN-13 detection"
  },
  {
    "content": "Resolve: OpenCV version requires Python 3.11+",
    "status": "completed",
    "activeForm": "Resolving Python version requirement"
  },
  {
    "content": "Add image preprocessing pipeline",
    "status": "completed",
    "activeForm": "Adding image preprocessing"
  },
  {
    "content": "Write unit tests for scanner",
    "status": "completed",
    "activeForm": "Writing scanner unit tests"
  },
  {
    "content": "Integration test with real images",
    "status": "completed",  # All done!
    "activeForm": "Running integration tests"
  }
])
```

**Learnings Captured**:

```markdown
# .ai/sprints/sprint-7A/learnings.md

## Todo Pattern: Dependency Checking

**What Happened**:
- Started implementing ISBN detection
- Hit blocker: OpenCV version incompatible
- Lost 2 hours

**Better Approach**:
- Add "Verify dependencies" as first todo
- Check version requirements before coding

**New Todo Sequence**:
1. Research APIs
2. **Verify dependencies and versions** ← NEW
3. Implement feature
4. Write tests

**Reusability**: HIGH - Use for all external library integrations
**Save to**: `.ai/meta/patterns/dependency-verification-todos.md`
```

### Example 2: Frontend Agent - Breaking Down Large Task

**Initial (Too Large)**:

```python
TodoWrite([
  {
    "content": "Build camera scanner UI",
    "status": "pending",
    "activeForm": "Building camera scanner UI"
  }
])
```

**Problem**: This is days of work, not hours!

**Improved (Properly Sized)**:

```python
TodoWrite([
  {
    "content": "Sketch camera UI layout and components",
    "status": "pending",
    "activeForm": "Sketching UI layout"
  },
  {
    "content": "Implement basic camera preview component",
    "status": "pending",
    "activeForm": "Implementing camera preview"
  },
  {
    "content": "Add capture button with visual feedback",
    "status": "pending",
    "activeForm": "Adding capture button"
  },
  {
    "content": "Implement progress indicator for processing",
    "status": "pending",
    "activeForm": "Implementing progress indicator"
  },
  {
    "content": "Handle camera permission requests",
    "status": "pending",
    "activeForm": "Handling camera permissions"
  },
  {
    "content": "Add error states (no camera, permission denied)",
    "status": "pending",
    "activeForm": "Adding error states"
  },
  {
    "content": "Style components for light/dark themes",
    "status": "pending",
    "activeForm": "Styling components"
  },
  {
    "content": "Test on different screen sizes",
    "status": "pending",
    "activeForm": "Testing screen sizes"
  }
])
```

**Each todo**: 2-4 hours, clear completion criteria, manageable.

**Learning Captured**:

```markdown
# .ai/meta/learnings/ui-todo-sizing.md

## Pattern: Breaking Down UI Todos

**Rule**: UI work needs finer granularity than backend

**Template**:
1. Sketch/Design (2 hours)
2. Implement basic component (3 hours)
3. Add interactions (2 hours)
4. Add feedback/states (2 hours)
5. Handle edge cases (3 hours)
6. Styling (2 hours)
7. Responsive testing (2 hours)

**Total**: ~16 hours for medium-complexity UI component

**Reusability**: Use for all UI component development
```

---

## Summary

### Key Takeaways

1. **Todos = Execution Tracking**
   - Break work into 2-4 hour chunks
   - One in_progress at a time
   - Mark completed immediately

2. **Todos → Learnings**
   - Good todo patterns become templates
   - Blockers reveal missing steps
   - Sprint retrospectives analyze todo effectiveness

3. **Learnings → Framework**
   - Common workflows → todo templates in framework v2.0
   - Better sizing rules → more accurate estimates
   - Knowledge compounds!

4. **Integration Points**
   - Sprint planning: Create initial todos
   - During sprint: Real-time tracking
   - Sprint retro: Analyze patterns
   - Framework upgrade: Import improved templates

### Quick Reference

```bash
# During Sprint Planning
1. Read sprint objectives
2. Create todos from templates (.ai/templates/)
3. Size each todo (2-4 hours)
4. Make dependencies explicit

# During Execution
1. Mark ONE todo as in_progress
2. Work on it until done
3. Mark completed immediately
4. Move to next todo

# When Blocked
1. Keep blocker as in_progress (don't mark completed!)
2. Create new todo for resolution
3. Document blocker

# During Retrospective
1. Analyze todo patterns
2. Identify what worked / didn't work
3. Capture learnings in .ai/meta/learnings/
4. Extract patterns to .ai/meta/patterns/

# After Project
1. Review all captured patterns
2. Create todo templates for framework v2.0
3. Next project uses better templates
4. Knowledge has compounded!
```

---

**Next Steps**:
1. See [Templates](#templates) section for ready-to-use todo templates
2. Check `.ai/templates/` directory for all available templates
3. Read `EXECUTION_PLAN.md` for full workflow integration
4. Start your sprint and watch the system compound knowledge!

---

*This workflow makes every sprint teach the framework. That's world-class software engineering.* 🚀

---

*Last Updated: 2025-10-16*
*Part of: Claude-Dev-Framework Knowledge Compounding System*
*See Also: KNOWLEDGE_COMPOUNDING_SYSTEM.md, EXECUTION_PLAN.md*
