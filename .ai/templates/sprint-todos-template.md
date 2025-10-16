# Sprint {{SPRINT_NUMBER}}: {{SPRINT_NAME}}

**Duration**: {{DURATION}} days
**Start Date**: {{START_DATE}}
**End Date**: {{END_DATE}}
**Sprint Goal**: {{SPRINT_GOAL}}

---

## Objectives

{{OBJECTIVES}}

**Success Criteria**:
- {{CRITERIA_1}}
- {{CRITERIA_2}}
- {{CRITERIA_3}}

---

## Agent: backend

**Responsibilities**: {{BACKEND_RESPONSIBILITIES}}

### High Priority 🔴
- [ ] {{BACKEND_HIGH_1}}
- [ ] {{BACKEND_HIGH_2}}
- [ ] {{BACKEND_HIGH_3}}

### Medium Priority 🟡
- [ ] {{BACKEND_MED_1}}
- [ ] {{BACKEND_MED_2}}

### Low Priority 🟢
- [ ] {{BACKEND_LOW_1}}

**Estimated Hours**: {{BACKEND_HOURS}}
**Dependencies**: {{BACKEND_DEPS}}

---

## Agent: frontend

**Responsibilities**: {{FRONTEND_RESPONSIBILITIES}}

### High Priority 🔴
- [ ] {{FRONTEND_HIGH_1}}
- [ ] {{FRONTEND_HIGH_2}}
- [ ] {{FRONTEND_HIGH_3}}

### Medium Priority 🟡
- [ ] {{FRONTEND_MED_1}}
- [ ] {{FRONTEND_MED_2}}

### Low Priority 🟢
- [ ] {{FRONTEND_LOW_1}}

**Estimated Hours**: {{FRONTEND_HOURS}}
**Dependencies**: {{FRONTEND_DEPS}}

---

## Agent: integration

**Responsibilities**: {{INTEGRATION_RESPONSIBILITIES}}

### High Priority 🔴
- [ ] {{INTEGRATION_HIGH_1}}
- [ ] {{INTEGRATION_HIGH_2}}

### Medium Priority 🟡
- [ ] {{INTEGRATION_MED_1}}

**Estimated Hours**: {{INTEGRATION_HOURS}}
**Dependencies**: {{INTEGRATION_DEPS}}

---

## Agent: testing

**Responsibilities**: {{TESTING_RESPONSIBILITIES}}

### Critical Tests 🔴
- [ ] {{TESTING_CRITICAL_1}}
- [ ] {{TESTING_CRITICAL_2}}

### Important Tests 🟡
- [ ] {{TESTING_IMPORTANT_1}}
- [ ] {{TESTING_IMPORTANT_2}}

### Nice-to-Have Tests 🟢
- [ ] {{TESTING_NICE_1}}

**Estimated Hours**: {{TESTING_HOURS}}
**Dependencies**: {{TESTING_DEPS}}

---

## Timeline

| Day | Agent | Focus |
|-----|-------|-------|
| 1 | backend | {{DAY1_BACKEND}} |
| 1 | frontend | {{DAY1_FRONTEND}} |
| 2 | backend | {{DAY2_BACKEND}} |
| 2 | frontend | {{DAY2_FRONTEND}} |
| 3 | integration | {{DAY3_INTEGRATION}} |
| 3 | testing | {{DAY3_TESTING}} |

---

## Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| {{RISK_1}} | {{PROB_1}} | {{IMPACT_1}} | {{MITIGATION_1}} |
| {{RISK_2}} | {{PROB_2}} | {{IMPACT_2}} | {{MITIGATION_2}} |
| {{RISK_3}} | {{PROB_3}} | {{IMPACT_3}} | {{MITIGATION_3}} |

---

## Total Estimated Hours: {{TOTAL_HOURS}}

**Distribution**:
- Backend: {{BACKEND_HOURS}} hours ({{BACKEND_PCT}}%)
- Frontend: {{FRONTEND_HOURS}} hours ({{FRONTEND_PCT}}%)
- Integration: {{INTEGRATION_HOURS}} hours ({{INTEGRATION_PCT}}%)
- Testing: {{TESTING_HOURS}} hours ({{TESTING_PCT}}%)

---

## Notes

{{ADDITIONAL_NOTES}}

---

## Variables Used

```yaml
# Reference from PROJECT_VARIABLES.yaml
sprint:
  number: "{{SPRINT_NUMBER}}"
  name: "{{SPRINT_NAME}}"
  duration_days: {{DURATION}}
  start_date: "{{START_DATE}}"

# Knowledge graph tracking
_used_in:
  - "[[../../STARTUP_VARIABLES.yaml:sprints.current]]"
  - "[[retrospective.md:sprint-reference]]"
```

---

*Template Version: 1.0*
*Part of: Claude-Dev-Framework Knowledge Compounding System*
*See Also: docs/TODO_WORKFLOW.md*
