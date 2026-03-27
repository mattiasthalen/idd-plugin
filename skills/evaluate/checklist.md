# IDD Evaluation Checklist

Evaluate the implementation against all six dimensions. Each dimension gets a verdict: PASS, CONCERN, or FAIL.

---

## 1. Correctness

**Question:** Does it meet the acceptance criteria?

**Owner:** Tests + human review

- [ ] All acceptance criteria from the intent document are satisfied
- [ ] Tests pass and cover the acceptance criteria
- [ ] Edge cases identified in the intent are handled

## 2. Taste

**Question:** Does it feel right for users?

**Owner:** Humans exclusively

- [ ] The API/UX feels natural and intuitive
- [ ] Naming is clear and consistent
- [ ] The user experience matches the desired outcome

## 3. Simplicity

**Question:** Is this the simplest solution that works?

**Owner:** Collaborative judgment

- [ ] No unnecessary abstractions or indirection
- [ ] No premature generalization
- [ ] Could a new team member understand this quickly?

## 4. Coherence

**Question:** Does it fit existing patterns?

**Owner:** Linting + human context

- [ ] Follows established project conventions
- [ ] Consistent with existing code style and architecture
- [ ] Does not introduce conflicting patterns

## 5. Sustainability

**Question:** Will this be maintainable in 6 months?

**Owner:** Human foresight

- [ ] Dependencies are stable and well-maintained
- [ ] Error handling is appropriate
- [ ] Documentation is sufficient for future maintainers

## 6. Community Fit

**Question:** Will contributors understand this?

**Owner:** Maintainer assessment

- [ ] Follows community conventions for the ecosystem
- [ ] Contribution patterns remain clear
- [ ] No tribal knowledge required to work with this code
