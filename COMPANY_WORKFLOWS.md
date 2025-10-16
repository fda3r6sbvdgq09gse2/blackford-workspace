# Blackford Industries: Company Workflows & Standards
**Last Updated:** 2025-10-16
**Version:** 1.0
**Purpose:** Define HOW Blackford builds software

---

## 🎯 Philosophy

**"World-class software through systematic excellence"**

Blackford Industries doesn't just build projects - we build them THE RIGHT WAY:
- Proven workflows
- Automated processes
- Quality gates
- Knowledge compounding

**Every project follows the same high standards.**

---

## 📋 Table of Contents

1. [Project Inception](#1-project-inception)
2. [Sprint-Based Development](#2-sprint-based-development)
3. [Parallel Agent Workflow](#3-parallel-agent-workflow)
4. [Testing Standards](#4-testing-standards)
5. [Human Testing Protocol](#5-human-testing-protocol)
6. [Code Quality Standards](#6-code-quality-standards)
7. [Documentation Requirements](#7-documentation-requirements)
8. [Knowledge Compounding](#8-knowledge-compounding)

---

## 1. Project Inception

**Every project starts with `/project-inception`**

### Quick Mode (2 minutes)
```bash
/project-inception

# Answer 3 questions:
1. Project name? (e.g., "book-cataloger")
2. What does it do? (1 sentence)
3. Primary language? (Python, TypeScript, etc.)

# Smart defaults applied automatically
```

### Custom Mode (10 minutes)
```bash
/project-inception

Response: custom

# Answer 10 detailed questions
# Full control over configuration
```

### What Gets Created
```
projects/[project-name]/
├── PROJECT_VARIABLES.yaml    # Single source of truth
├── README.md                  # Project overview
├── .ai/
│   └── context/
│       └── current_task.md   # Initial task
├── src/                       # Source code
├── tests/                     # Test suite
└── docs/                      # Documentation
```

### Acceptance Criteria
- ✅ PROJECT_VARIABLES.yaml validates
- ✅ Directory structure complete
- ✅ Git initialized
- ✅ README has clear description
- ✅ Linked to workspace configuration

**Standard:** Every project has a clear inception, no ad-hoc starts.

---

## 2. Sprint-Based Development

**Blackford uses 3-day sprints with clear goals**

### Sprint Structure

```
Day 1: Implementation (70% of work)
Day 2: Integration + Testing (25% of work)
Day 3: Polish + Human Testing (5% of work)
```

### Sprint Naming Convention
```
Sprint [Number][Phase]: [Name]

Examples:
- Sprint 7A: Camera Scanner Completion
- Sprint 7B: UI Integration & Polish
- Sprint 8A: Performance Optimization
```

Where:
- **Number** = Major feature set (7, 8, 9)
- **Phase** = A, B, C (sub-sprints within feature)
- **Name** = Clear, descriptive goal

### Sprint Workflow

#### Phase 1: Launch
```bash
/launch-sprint 7A "Camera Scanner Completion"

# Creates:
- Sprint planning document
- Git branches for each agent
- Worktrees for parallel work
- Sprint context in .ai/sprints/sprint-7A/
```

#### Phase 2: Execution
- Agents work in parallel (separate branches)
- Daily progress updates
- Communication through sprint docs

#### Phase 3: Integration
```bash
/integrate-sprint 7A

# Brain/CEO:
- Reviews all agent branches
- Merges systematically
- Resolves conflicts
- Runs integration tests
```

#### Phase 4: Testing
```bash
/test-sprint 7A

# Automated:
- Unit tests
- Integration tests
- E2E tests (Playwright)
- Performance tests
```

#### Phase 5: Human Testing
```bash
/human-test-sprint 7A

# Human:
- Follows testing checklist
- Records feedback
- Approves or requests changes
```

#### Phase 6: Closure
```bash
/finalize-sprint 7A approve
# OR
/finalize-sprint 7A request-changes

# If approved:
- Merges to main
- Tags release
- Cleans up worktrees
- Runs retrospective
```

### Sprint Artifacts

Every sprint produces:
```
.ai/sprints/sprint-[number]/
├── PLAN.md                    # Goals and tasks
├── INTEGRATION_RESULTS.md     # Merge report
├── TEST_REPORT.md             # Automated test results
├── HUMAN_TEST_CHECKLIST.md    # Human testing
├── CHANGES_REQUESTED.md       # If changes needed
├── FINAL_STATUS.md            # Completion summary
└── RETROSPECTIVE.md           # Learnings
```

**Standard:** Every sprint follows this exact workflow. No shortcuts.

---

## 3. Parallel Agent Workflow

**Blackford uses git worktrees for true parallel development**

### Setup (Automated by `/launch-sprint`)

```bash
# Main repo at: /Users/z/dev/blackford-workspace/projects/[project]/
# Worktrees at: $HOME/.claude-workers/[project]/

Structure:
$HOME/.claude-workers/book-cataloger/
├── backend-sprint-7A/         # Backend agent works here
├── frontend-sprint-7A/        # Frontend agent works here
├── integration-sprint-7A/     # Integration agent works here
└── testing-sprint-7A/         # Testing agent works here
```

### Benefits
- ✅ Agents work simultaneously without conflicts
- ✅ Each agent has own Claude Code session
- ✅ Can test each agent's work independently
- ✅ Clean separation of concerns
- ✅ Easy to review individual contributions

### Branching Strategy

```
main (production)
  ├─ feature/backend-sprint-7A
  ├─ feature/frontend-sprint-7A
  ├─ feature/integration-sprint-7A
  └─ feature/testing-sprint-7A
       ↓ (all merge into)
  integration/sprint-7A
       ↓ (after testing)
  main (production)
```

### Communication Protocol

Agents communicate via:
- Sprint planning doc (initial)
- API contracts (interfaces.md)
- Integration checklist
- Test results

No direct agent-to-agent messaging - everything documented.

**Standard:** Always use worktrees for multi-agent sprints. Always.

---

## 4. Testing Standards

**Blackford has a 4-tier testing pyramid**

### Tier 1: Unit Tests (70% of tests)

**Coverage:** Every function with business logic

```python
# Example: src/core/isbn_validator.py
def validate_isbn(isbn: str) -> bool:
    """Validate ISBN-10 or ISBN-13."""
    ...

# Test: tests/unit/test_isbn_validator.py
def test_validate_isbn_10():
    assert validate_isbn("0-306-40615-2") == True

def test_validate_isbn_10_invalid():
    assert validate_isbn("0-306-40615-3") == False

def test_validate_isbn_13():
    assert validate_isbn("978-0-306-40615-7") == True
```

**Requirements:**
- Test happy path
- Test edge cases
- Test error conditions
- Use descriptive test names
- Include docstrings

### Tier 2: Integration Tests (20% of tests)

**Coverage:** Component interactions

```python
# Example: API + Database integration
def test_enrich_isbn_workflow():
    """Test complete enrichment: API → Merger → Database."""
    isbn = "978-0-306-40615-7"

    # API call
    data = openlibrary_api.fetch(isbn)

    # Merge
    merged = data_merger.merge([data])

    # Database
    db.save_book(merged)

    # Verify
    book = db.get_book(isbn)
    assert book.title == "Expected Title"
```

**Requirements:**
- Test realistic workflows
- Use test database
- Clean up after tests
- Mock external APIs (use fixtures)

### Tier 3: End-to-End Tests (9% of tests)

**Coverage:** Complete user journeys with Playwright

```python
# Example: tests/e2e/test_camera_scanner.py
def test_scan_isbn_and_enrich(page: Page):
    """Test: Launch app → Scan ISBN → Enrich → View result."""

    # Launch app
    page.goto("http://localhost:5000")

    # Click "Scan ISBN"
    page.click("button[id='scan-isbn']")

    # Simulate ISBN detection (mock camera)
    page.evaluate("window.simulateISBNDetection('978-0-306-40615-7')")

    # Click "Enrich"
    page.click("button[id='enrich']")

    # Wait for completion
    page.wait_for_selector(".enrichment-complete")

    # Verify result
    title = page.locator(".book-title").text_content()
    assert "Expected Title" in title
```

**Requirements:**
- Test critical user paths
- Run headless in CI, headed for debugging
- Take screenshots on failure
- Use realistic data

### Tier 4: Performance Tests (1% of tests)

**Coverage:** Speed and scalability

```python
# Example: tests/performance/test_batch_enrichment.py
def test_enrich_100_books_under_5_minutes():
    """Benchmark: 100 books in <5 min."""

    isbns = load_test_isbns(100)

    start = time.time()
    results = enrich_batch(isbns)
    duration = time.time() - start

    assert len(results) == 100
    assert duration < 300  # 5 minutes
    assert all(r.confidence > 0.8 for r in results)
```

**Requirements:**
- Benchmark critical operations
- Set performance budgets
- Track over time
- Alert on degradation

### Running Tests

```bash
# All tests
pytest

# Unit only
pytest tests/unit/

# Integration
pytest tests/integration/

# E2E (Playwright)
pytest tests/e2e/ --headed

# Performance
pytest tests/performance/ --benchmark-only

# Coverage report
pytest --cov=src --cov-report=html
```

### Test Coverage Requirements

| Category | Minimum | Target |
|----------|---------|--------|
| Overall | 80% | 90%+ |
| Core modules | 90% | 100% |
| UI modules | 70% | 85% |
| Utils | 85% | 95% |

**Standard:** All tests must pass before merge to main. No exceptions.

---

## 5. Human Testing Protocol

**After automated tests pass, human tests**

### Testing Checklist Format

Every sprint includes:
```
.ai/sprints/sprint-[number]/HUMAN_TEST_CHECKLIST.md
```

### Example Checklist

```markdown
# Sprint 7A Human Testing Checklist

**Tester:** [Your Name]
**Date:** [Date]
**Branch:** integration/sprint-7A

## Setup ✅
- [ ] Checkout integration branch
- [ ] Install dependencies
- [ ] Run application
- [ ] Verify startup

## Feature: Camera ISBN Scanner
- [ ] Camera opens on click
- [ ] Can focus on barcode
- [ ] Beep on successful scan
- [ ] ISBN appears in queue
- [ ] Can scan multiple books
- [ ] "Done" button works
- **Notes:** _________________

## Feature: Batch Enrichment
- [ ] Enrichment starts after scan
- [ ] Progress indicator works
- [ ] All ISBNs processed
- [ ] Results appear in catalog
- **Notes:** _________________

## Regression Testing
- [ ] Existing features work
- [ ] No new bugs
- [ ] Performance OK
- **Notes:** _________________

## Issues Found
1. **Issue:** _______________
   **Severity:** [Critical/High/Medium/Low]
   **Steps:** _______________

## Approval
- [ ] ✅ Approve (merge to main)
- [ ] ⚠️ Request changes

**Signature:** _____________
**Date:** _____________
```

### Testing Standards

**Requirements:**
- Test all new features
- Test regression (existing features)
- Test error scenarios
- Rate UX (1-10)
- Document all issues

**Approval Criteria:**
- All critical features work
- No critical bugs
- UX acceptable (7+/10)
- Performance acceptable

**If Changes Needed:**
- Document issues clearly
- Assign to relevant agent
- Re-test after fixes

**Standard:** Human must approve before merge to main.

---

## 6. Code Quality Standards

**Blackford code is world-class**

### Module Size
- **Target:** 200-400 lines
- **Maximum:** 600 lines
- **If >600:** Split into smaller modules

### Code Style

**Python:**
```python
# Use type hints
def process_isbn(isbn: str, cache: Cache) -> BookMetadata:
    """Process ISBN and return enriched metadata.

    Args:
        isbn: ISBN-10 or ISBN-13 string
        cache: Cache instance for API responses

    Returns:
        BookMetadata with enriched fields

    Raises:
        InvalidISBNError: If ISBN format invalid
    """
    ...

# Use descriptive names
def enrich_book_metadata_from_apis(isbn: str) -> dict:
    # NOT: def erich(i):
    ...

# Document complex logic
def calculate_confidence_score(data: dict) -> float:
    """Calculate confidence score for book data.

    Uses weighted average:
    - Data completeness: 40%
    - Source reliability: 30%
    - Consistency: 30%
    """
    ...
```

### Documentation Requirements

**Every module needs:**
```python
"""Module docstring.

AI Context: This module handles X in the Y system.
Related modules: a.py, b.py
Patterns used: Pattern from .ai/patterns/api_integration.md

Dependencies:
- requests: HTTP requests
- pydantic: Data validation

Example:
    from core import isbn_validator

    if isbn_validator.validate_isbn("978-0-123"):
        ...
"""
```

**Every function needs:**
- Docstring with purpose
- Args documented
- Returns documented
- Raises documented
- Example if complex

### Testing Requirements
- Unit test for every function
- Integration test for workflows
- Type hints everywhere
- No `# type: ignore` without reason

### Code Review Checklist
- [ ] Follows style guide
- [ ] Has docstrings
- [ ] Has tests
- [ ] Tests pass
- [ ] No TODOs without issue number
- [ ] No hardcoded values (use config)
- [ ] Error handling present
- [ ] Performance considered

**Standard:** All code follows these standards before merge.

---

## 7. Documentation Requirements

**Blackford documents everything**

### Project-Level Docs

Every project has:
```
docs/
├── README.md              # Overview
├── ARCHITECTURE.md        # System design
├── API.md                 # API documentation
├── USER_GUIDE.md          # How to use
├── DEVELOPMENT.md         # How to develop
└── TROUBLESHOOTING.md     # Common issues
```

### Code-Level Docs
- Module docstrings
- Function docstrings
- Inline comments for complex logic
- Type hints everywhere

### Sprint-Level Docs
```
.ai/sprints/sprint-[number]/
├── PLAN.md                # What we're building
├── RETROSPECTIVE.md       # What we learned
└── [other artifacts]      # Tests, checklists, etc.
```

### Workspace-Level Docs
```
blackford-workspace/
├── README.md              # Workspace overview
├── COMPANY_WORKFLOWS.md   # This file
├── docs/
│   ├── QUICK_START.md
│   ├── CUSTOMIZATION.md
│   └── ARCHITECTURE.md
└── .ai/
    ├── META_README.md     # Framework improvement system
    └── meta/
        └── [improvements] # Suggestions and learnings
```

### Documentation Standards

**User-Facing:**
- Written for beginners
- Include examples
- Include screenshots
- Clear step-by-step instructions
- Troubleshooting section

**Developer-Facing:**
- Architecture diagrams
- API contracts
- Data models
- Testing strategy
- Deployment procedures

**Update Frequency:**
- Update docs with code changes
- Review docs every sprint
- No outdated docs allowed

**Standard:** Documentation is not optional. It's required.

---

## 8. Knowledge Compounding

**Blackford learns from every project**

### The Meta-Loop

```
Build Project → Extract Learnings → Improve Framework → Build Better Next Project → ...
```

### What Gets Extracted

**From book-cataloger:**
1. Sprint management workflows → Framework commands
2. Testing patterns → Reusable test fixtures
3. API integration patterns → Framework utilities
4. UI patterns → Component library
5. Error handling strategies → Standard patterns
6. Performance optimizations → Best practices
7. Documentation templates → Framework templates
8. Deployment procedures → Automation scripts

### Where It Goes

```
.ai/meta/
├── framework-improvements/    # For claude-dev-framework
├── template-improvements/     # For claude-workspace-template
└── learnings/                 # General knowledge
```

### Improvement Lifecycle

1. **Discover** (during sprint)
   - Notice gap or opportunity
   - Quick note in .ai/meta/quick-notes.md

2. **Document** (end of sprint)
   - Create detailed improvement suggestion
   - Use template
   - Include examples

3. **Prioritize** (weekly review)
   - Assess impact
   - Group related suggestions
   - Plan implementation

4. **Implement** (quarterly releases)
   - Add to framework or template
   - Test thoroughly
   - Document
   - Release

5. **Use** (next project)
   - Apply improved framework
   - Validate improvement
   - Iterate

### Knowledge Compounding Goals

**From blackford-workspace:**
- 10+ framework improvements per quarter
- 5+ template improvements per quarter
- 20+ patterns documented per year

**Result:**
- Each project is 10% easier than last
- Framework grows more capable
- Template becomes more complete
- Blackford becomes more efficient

**Standard:** Every sprint includes retrospective and learning extraction.

---

## ✅ Project Checklist

**Every Blackford project follows this checklist:**

### Phase 1: Inception
- [ ] Run `/project-inception`
- [ ] Complete PROJECT_VARIABLES.yaml
- [ ] Create initial README
- [ ] Initialize git
- [ ] Link to workspace

### Phase 2: First Sprint
- [ ] Plan Sprint 1A
- [ ] Run `/launch-sprint 1A [name]`
- [ ] Assign agents
- [ ] Execute in parallel
- [ ] Daily progress checks

### Phase 3: Testing
- [ ] Run `/integrate-sprint 1A`
- [ ] Run `/test-sprint 1A`
- [ ] Fix any failures
- [ ] Run `/human-test-sprint 1A`
- [ ] Human tests and approves

### Phase 4: Closure
- [ ] Run `/finalize-sprint 1A approve`
- [ ] Merge to main
- [ ] Run `/retrospective 1A`
- [ ] Extract learnings

### Phase 5: Repeat
- [ ] Plan Sprint 1B
- [ ] Continue until project complete

### Phase 6: Completion
- [ ] All features complete
- [ ] All tests passing
- [ ] Documentation complete
- [ ] Deployment ready
- [ ] Final retrospective
- [ ] Framework improvements extracted

---

## 🎯 Success Metrics

**How Blackford measures success:**

### Project Metrics
- On-time delivery
- Test coverage > 85%
- Zero critical bugs in production
- User satisfaction > 8/10
- Documentation completeness

### Process Metrics
- Sprint completion rate
- Test pass rate
- Human approval rate
- Code review cycle time
- Deployment frequency

### Learning Metrics
- Improvements extracted per project
- Framework capabilities added
- Template completeness
- Time saved per sprint
- Error reduction rate

**Goal:** Every metric improves over time.

---

## 🚀 Getting Started

### For New Projects
```bash
cd blackford-workspace/projects
/project-inception

# Answer questions
# Project created!

cd [project-name]
/launch-sprint 1A "Initial Setup"
# Begin building!
```

### For Existing Projects
```bash
# Already in project directory

# Start next sprint
/launch-sprint [number] "[name]"

# Follow workflow
# Build → Integrate → Test → Approve → Merge
# Retrospective → Extract learnings
```

---

## 📞 Questions?

**For workflow questions:**
- Read: `blackford-workspace/README.md`
- Read: `blackford-workspace/docs/QUICK_START.md`
- Check: `.ai/META_README.md`

**For framework questions:**
- Read: `claude-dev-framework/docs/`
- Check GitHub issues

**For project-specific questions:**
- Read: `projects/[project]/README.md`
- Check sprint docs: `.ai/sprints/sprint-[number]/`

---

## 🎓 Philosophy Summary

**"Every project makes the next one better."**

Blackford Industries isn't just building software - we're building a systematic approach to building software that gets better with every project.

**That's knowledge compounding in action.**

---

**Last Updated:** 2025-10-16
**Next Review:** 2025-11-16 (monthly review)
**Maintained By:** Blackford Developer
**Status:** v1.0 - Initial company workflows defined
