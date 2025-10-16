# Bug Fix: {{BUG_TITLE}}

**Bug ID**: #{{BUG_NUMBER}}
**Severity**: {{SEVERITY}} (Critical / High / Medium / Low)
**Status**: {{STATUS}}
**Reported By**: {{REPORTER}}
**Reported Date**: {{REPORTED_DATE}}
**Assigned To**: {{AGENT}}
**Sprint**: {{SPRINT_NUMBER}}

---

## Bug Description

**Summary**:
{{BUG_SUMMARY}}

**Expected Behavior**:
{{EXPECTED}}

**Actual Behavior**:
{{ACTUAL}}

**Impact**:
{{IMPACT}}

---

## Reproduce Phase

**Goal**: Consistently reproduce the bug

- [ ] Reproduce bug locally
- [ ] Document exact steps to reproduce
- [ ] Create minimal test case
- [ ] Identify affected versions
- [ ] Check if bug exists in other environments

**Estimated**: 1-2 hours
**Definition of Done**: Bug reproducible 100% of the time

### Steps to Reproduce

1. {{STEP_1}}
2. {{STEP_2}}
3. {{STEP_3}}
4. {{STEP_4}}

**Environment**:
- OS: {{OS}}
- Version: {{VERSION}}
- Browser/Runtime: {{BROWSER_RUNTIME}}
- Other: {{OTHER_ENV}}

### Minimal Test Case

```{{LANGUAGE}}
# Code that reproduces the bug
{{TEST_CASE_CODE}}
```

---

## Diagnose Phase

**Goal**: Identify root cause

- [ ] Identify root cause
- [ ] Trace execution path
- [ ] Check related code
- [ ] Review recent changes that might have caused it
- [ ] Check for similar issues in codebase
- [ ] Document root cause

**Estimated**: 1-3 hours
**Definition of Done**: Root cause identified and documented

### Root Cause Analysis

**What caused the bug?**
{{ROOT_CAUSE}}

**Why wasn't it caught?**
{{WHY_NOT_CAUGHT}}

**Affected code**:
- File: {{FILE_1}}, Lines: {{LINES_1}}
- File: {{FILE_2}}, Lines: {{LINES_2}}

**Related issues**:
- {{RELATED_ISSUE_1}}
- {{RELATED_ISSUE_2}}

---

## Fix Phase

**Goal**: Fix the bug

- [ ] Write failing test that demonstrates bug
- [ ] Verify test fails
- [ ] Implement fix
- [ ] Verify test now passes
- [ ] Check for edge cases
- [ ] Ensure fix doesn't break other functionality
- [ ] Run full test suite

**Estimated**: 2-4 hours
**Definition of Done**: Bug fixed, test passes, no regressions

### Fix Implementation

**Approach**:
{{FIX_APPROACH}}

**Files changed**:
- {{FILE_1}}: {{CHANGE_1}}
- {{FILE_2}}: {{CHANGE_2}}

**Code changes**:
```{{LANGUAGE}}
# Before
{{CODE_BEFORE}}

# After
{{CODE_AFTER}}
```

---

## Prevent Phase

**Goal**: Prevent similar bugs in future

- [ ] Add regression tests
- [ ] Update related tests
- [ ] Add validation/checks to prevent similar bugs
- [ ] Document in CHANGELOG
- [ ] Update documentation if behavior changed
- [ ] Add code comments explaining fix

**Estimated**: 1-2 hours
**Definition of Done**: Regression tests added, documented

### Prevention Measures

**Regression tests added**:
- {{TEST_1}}: {{TEST_LOCATION_1}}
- {{TEST_2}}: {{TEST_LOCATION_2}}

**Preventive measures**:
- {{MEASURE_1}}
- {{MEASURE_2}}

**Documentation updated**:
- {{DOC_1}}: {{DOC_LOCATION_1}}
- {{DOC_2}}: {{DOC_LOCATION_2}}

---

## Verify Phase

**Goal**: Ensure bug is truly fixed

- [ ] Manual testing in dev
- [ ] Manual testing in staging
- [ ] Run full test suite
- [ ] Performance check (if performance-related)
- [ ] Security check (if security-related)
- [ ] Code review
- [ ] QA sign-off (if critical)

**Estimated**: 1-2 hours
**Definition of Done**: Bug verified fixed in all environments

### Verification Results

**Manual testing**:
- Dev: {{DEV_RESULT}}
- Staging: {{STAGING_RESULT}}
- Production: {{PROD_RESULT}}

**Test suite**:
- All tests: {{ALL_TESTS_RESULT}}
- Affected tests: {{AFFECTED_TESTS_RESULT}}

**Performance**:
- Before: {{PERF_BEFORE}}
- After: {{PERF_AFTER}}

---

## Deploy Phase (if applicable)

**Goal**: Ship the fix

- [ ] Create deployment plan
- [ ] Deploy to staging
- [ ] Verify in staging
- [ ] Deploy to production
- [ ] Verify in production
- [ ] Monitor for 24 hours
- [ ] Close bug ticket

**Estimated**: 1-2 hours
**Definition of Done**: Fix deployed, verified, bug closed

---

## Total Estimates

| Phase | Hours | Status |
|-------|-------|--------|
| Reproduce | 1-2 | ⏳ Pending |
| Diagnose | 1-3 | ⏳ Pending |
| Fix | 2-4 | ⏳ Pending |
| Prevent | 1-2 | ⏳ Pending |
| Verify | 1-2 | ⏳ Pending |
| Deploy | 1-2 | ⏳ Pending |
| **Total** | **7-15** | ⏳ Pending |

**Actual Hours**: {{ACTUAL_HOURS}} (fill in as you go)
**Variance**: {{VARIANCE}} hours (actual - estimated)

---

## Success Criteria

**Bug is fixed when**:
- [ ] Bug no longer reproducible
- [ ] Regression tests pass
- [ ] No new bugs introduced
- [ ] Full test suite passes
- [ ] Code reviewed and approved
- [ ] Deployed to production
- [ ] Verified by reporter (if possible)
- [ ] No recurrence for 7 days

---

## Timeline

| Date | Event |
|------|-------|
| {{REPORTED_DATE}} | Bug reported |
| {{STARTED_DATE}} | Work started |
| {{DIAGNOSED_DATE}} | Root cause identified |
| {{FIXED_DATE}} | Fix implemented |
| {{DEPLOYED_DATE}} | Fix deployed |
| {{VERIFIED_DATE}} | Fix verified |
| {{CLOSED_DATE}} | Bug closed |

**Time to Fix**: {{TIME_TO_FIX}} (from report to deploy)

---

## Related Bugs

**Similar bugs**:
- #{{SIMILAR_1}}: {{SIMILAR_DESC_1}}
- #{{SIMILAR_2}}: {{SIMILAR_DESC_2}}

**Caused by same root cause**:
- #{{RELATED_1}}: {{RELATED_DESC_1}}

---

## Learnings (fill in during/after)

### What Went Well
- {{WENT_WELL_1}}
- {{WENT_WELL_2}}

### What Could Be Improved
- {{IMPROVE_1}}
- {{IMPROVE_2}}

### Why This Bug Happened
- {{REASON_1}}
- {{REASON_2}}

### How to Prevent Similar Bugs
- {{PREVENTION_1}}: {{PREVENTION_DESC_1}}
- {{PREVENTION_2}}: {{PREVENTION_DESC_2}}

### Patterns for Testing
- {{TEST_PATTERN_1}}: {{TEST_PATTERN_DESC_1}} (Add to framework: YES/NO)
- {{TEST_PATTERN_2}}: {{TEST_PATTERN_DESC_2}} (Add to framework: YES/NO)

### Recommendations for Framework v2.0
- {{RECOMMENDATION_1}}
- {{RECOMMENDATION_2}}

**Save learnings to**: `.ai/meta/learnings/bug-{{BUG_NUMBER}}-learnings.md`

---

## Post-Mortem (for critical bugs)

### Impact Assessment
- Users affected: {{USERS_AFFECTED}}
- Duration: {{DURATION}}
- Data loss: {{DATA_LOSS}}
- Revenue impact: {{REVENUE_IMPACT}}

### Timeline
1. {{TIME_1}}: {{EVENT_1}}
2. {{TIME_2}}: {{EVENT_2}}
3. {{TIME_3}}: {{EVENT_3}}

### Root Cause
{{DETAILED_ROOT_CAUSE}}

### What Went Wrong
1. {{WRONG_1}}
2. {{WRONG_2}}

### What Went Right
1. {{RIGHT_1}}
2. {{RIGHT_2}}

### Action Items
- [ ] {{ACTION_1}} (Owner: {{OWNER_1}}, Due: {{DUE_1}})
- [ ] {{ACTION_2}} (Owner: {{OWNER_2}}, Due: {{DUE_2}})

---

## Variables Used

```yaml
# Reference from PROJECT_VARIABLES.yaml
bugs:
  - id: "{{BUG_NUMBER}}"
    title: "{{BUG_TITLE}}"
    severity: "{{SEVERITY}}"
    status: "{{STATUS}}"
    assigned_to: "{{AGENT}}"

# Knowledge graph tracking
_used_in:
  - "[[CHANGELOG.md:{{VERSION}}]]"
  - "[[.ai/sprints/sprint-{{SPRINT_NUMBER}}/plan.md]]"
  - "[[tests/regression/test_bug_{{BUG_NUMBER}}.py]]"
```

---

*Template Version: 1.0*
*Part of: Claude-Dev-Framework Knowledge Compounding System*
*See Also: docs/TODO_WORKFLOW.md, .ai/meta/learnings/TEMPLATE.md*
