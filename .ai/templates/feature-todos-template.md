# Feature: {{FEATURE_NAME}}

**Feature ID**: {{FEATURE_ID}}
**Description**: {{DESCRIPTION}}
**Priority**: {{PRIORITY}} (Critical / High / Medium / Low)
**Assigned To**: {{AGENT}}
**Sprint**: {{SPRINT_NUMBER}}
**Created**: {{CREATED_DATE}}

---

## Context

**Why this feature?**
{{WHY}}

**Who benefits?**
{{WHO_BENEFITS}}

**Success metrics**:
- {{METRIC_1}}
- {{METRIC_2}}
- {{METRIC_3}}

---

## Research Phase

**Goal**: Understand existing solutions and choose approach

- [ ] Research existing solutions in similar projects
- [ ] Review relevant code in current codebase
- [ ] Identify libraries/dependencies needed
- [ ] Document approach and alternatives
- [ ] Get approach approved (if high priority)

**Estimated**: 2-4 hours
**Definition of Done**: Approach documented and approved

---

## Design Phase

**Goal**: Design interfaces, data models, and components

- [ ] Design API endpoints / interfaces
- [ ] Design data models and schema
- [ ] Design UI components (if applicable)
- [ ] Create mockups/wireframes (if UI-heavy)
- [ ] Review design with team
- [ ] Document design decisions

**Estimated**: 4-6 hours
**Definition of Done**: Design reviewed and documented

**Design artifacts**:
- API spec: {{API_SPEC_LOCATION}}
- Data models: {{MODELS_LOCATION}}
- UI mockups: {{MOCKUPS_LOCATION}}

---

## Implementation Phase

**Goal**: Build the feature

### Core Functionality
- [ ] Implement core functionality
- [ ] Add input validation
- [ ] Add error handling
- [ ] Add logging for debugging
- [ ] Add monitoring/metrics

### Code Quality
- [ ] Follow project code standards
- [ ] Add inline documentation
- [ ] Extract reusable components
- [ ] Avoid code duplication

### Review
- [ ] Self code review
- [ ] Request peer code review
- [ ] Address review feedback

**Estimated**: 8-12 hours
**Definition of Done**: Core functionality working, code reviewed

---

## Testing Phase

**Goal**: Ensure feature works correctly

### Unit Tests
- [ ] Write unit tests for core functions
- [ ] Achieve >80% test coverage
- [ ] Test edge cases
- [ ] Test error conditions

### Integration Tests
- [ ] Write integration tests
- [ ] Test with real dependencies
- [ ] Test API contracts (if applicable)

### Manual Testing
- [ ] Test happy path
- [ ] Test error paths
- [ ] Test edge cases
- [ ] Test on different environments

### Performance
- [ ] Performance testing (if critical)
- [ ] Load testing (if high traffic)
- [ ] Optimize bottlenecks

**Estimated**: 4-6 hours
**Definition of Done**: All tests pass, >80% coverage

**Test results**:
- Unit tests: {{UNIT_TEST_RESULTS}}
- Integration tests: {{INTEGRATION_TEST_RESULTS}}
- Coverage: {{COVERAGE_PCT}}%

---

## Documentation Phase

**Goal**: Document for users and developers

- [ ] Update API documentation
- [ ] Update user-facing documentation
- [ ] Add code comments and docstrings
- [ ] Update CHANGELOG
- [ ] Create usage examples
- [ ] Document known limitations

**Estimated**: 2-3 hours
**Definition of Done**: All documentation updated

**Documentation locations**:
- API docs: {{API_DOCS_LOCATION}}
- User docs: {{USER_DOCS_LOCATION}}
- Changelog: {{CHANGELOG_LOCATION}}

---

## Deployment Phase (if applicable)

**Goal**: Ship the feature

- [ ] Create deployment plan
- [ ] Run pre-deployment checks
- [ ] Deploy to staging
- [ ] Verify in staging
- [ ] Deploy to production
- [ ] Verify in production
- [ ] Monitor for issues

**Estimated**: 1-2 hours
**Definition of Done**: Feature live in production, no errors

---

## Total Estimates

| Phase | Hours | Status |
|-------|-------|--------|
| Research | 2-4 | ⏳ Pending |
| Design | 4-6 | ⏳ Pending |
| Implementation | 8-12 | ⏳ Pending |
| Testing | 4-6 | ⏳ Pending |
| Documentation | 2-3 | ⏳ Pending |
| Deployment | 1-2 | ⏳ Pending |
| **Total** | **21-33** | ⏳ Pending |

**Actual Hours**: {{ACTUAL_HOURS}} (fill in as you go)
**Variance**: {{VARIANCE}} hours (actual - estimated)

---

## Definition of Done

**Feature is complete when**:
- [ ] All todos above are completed
- [ ] Tests pass (>80% coverage)
- [ ] Code reviewed and approved
- [ ] Documentation updated
- [ ] Deployed to production (if applicable)
- [ ] No critical bugs reported
- [ ] Success metrics achieved:
  - [ ] {{METRIC_1}}
  - [ ] {{METRIC_2}}
  - [ ] {{METRIC_3}}

---

## Dependencies

**Blocked by**:
- {{BLOCKER_1}}
- {{BLOCKER_2}}

**Blocks**:
- {{BLOCKS_1}}
- {{BLOCKS_2}}

---

## Related Work

**Related features**:
- {{RELATED_1}}
- {{RELATED_2}}

**Similar patterns in codebase**:
- {{PATTERN_1}} in {{LOCATION_1}}
- {{PATTERN_2}} in {{LOCATION_2}}

---

## Learnings (fill in during/after)

### What Went Well
- {{WENT_WELL_1}}
- {{WENT_WELL_2}}

### What Didn't Go Well
- {{DIDNT_GO_WELL_1}}
- {{DIDNT_GO_WELL_2}}

### Patterns Discovered
- {{PATTERN_1}}: {{DESCRIPTION_1}} (Reusability: HIGH/MEDIUM/LOW)
- {{PATTERN_2}}: {{DESCRIPTION_2}} (Reusability: HIGH/MEDIUM/LOW)

### Recommendations for Framework v2.0
- {{RECOMMENDATION_1}}
- {{RECOMMENDATION_2}}

**Save learnings to**: `.ai/meta/learnings/{{FEATURE_NAME}}-learnings.md`

---

## Variables Used

```yaml
# Reference from PROJECT_VARIABLES.yaml
features:
  - id: "{{FEATURE_ID}}"
    name: "{{FEATURE_NAME}}"
    status: "{{STATUS}}"
    assigned_to: "{{AGENT}}"

# Knowledge graph tracking
_used_in:
  - "[[README.md:features-section]]"
  - "[[CHANGELOG.md:{{VERSION}}]]"
  - "[[.ai/sprints/sprint-{{SPRINT_NUMBER}}/plan.md]]"
```

---

*Template Version: 1.0*
*Part of: Claude-Dev-Framework Knowledge Compounding System*
*See Also: docs/TODO_WORKFLOW.md, .ai/meta/learnings/TEMPLATE.md*
