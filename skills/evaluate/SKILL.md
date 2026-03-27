---
name: evaluate
description: >-
  Use when code has been produced and needs review against the intent.
  Trigger: "evaluate", "review output", "check against intent", "evaluate implementation", "is this done".
---

# IDD Evaluate

**Announce:** "Using idd:evaluate to assess the implementation against the intent."

## What This Skill Does

Performs a structured evaluation of the implementation against the six dimensions from the IDD manifesto. This is the judgment phase — no artifacts are produced, only a verdict.

## Procedure

### Step 1: Load the Active Intent

Identify and load the intent document (same as idd:generate Step 1-2). Extract the acceptance criteria for reference.

### Step 2: Load the Evaluation Checklist

Read `@checklist.md` in this skill directory for the six evaluation dimensions.

### Step 3: Evaluate Each Dimension

Walk through each dimension with the user. For each, provide a verdict: **PASS**, **CONCERN**, or **FAIL**.

1. **Correctness** — Do all acceptance criteria pass? Are tests green?
2. **Taste** — Does the API/UX feel right? Is naming clear? Does it match the desired outcome?
3. **Simplicity** — Is this the simplest solution? No unnecessary abstractions? Could a newcomer understand it?
4. **Coherence** — Does it follow project conventions? No conflicting patterns introduced?
5. **Sustainability** — Maintainable in 6 months? Dependencies stable? Error handling appropriate?
6. **Community Fit** — Follows ecosystem conventions? Contribution patterns remain clear?

### Step 4: Superpowers Integration

If `superpowers:requesting-code-review` is available, invoke it for a thorough code review alongside the IDD evaluation.

### Step 5: Produce Evaluation Summary

Format the results:

```
## Evaluation Summary

| Dimension      | Verdict | Notes                    |
|----------------|---------|--------------------------|
| Correctness    | PASS    | All criteria met         |
| Taste          | CONCERN | Naming could be clearer  |
| Simplicity     | PASS    | Minimal implementation   |
| Coherence      | PASS    | Follows existing patterns|
| Sustainability | PASS    | Well-documented          |
| Community Fit  | PASS    | Standard conventions     |

**Overall:** Ready for decision / Needs attention
```

### Step 6: Report

Present the evaluation summary. Suggest running `idd:decide` to make a decision based on the evaluation.
