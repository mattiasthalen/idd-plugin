---
name: intent
description: >-
  Use when starting new work, before implementation.
  Trigger: "create intent", "new intent", "write intent", "define intent", "start new work", "what should we build".
---

# IDD Intent

**Announce:** "Using idd:intent to create an intent document."

## What This Skill Does

Guides creation of an intent document — the highest-leverage artifact in IDD. An intent document is NOT a Jira ticket. It does not prescribe HOW to build. It consolidates what traditionally required user stories, PRDs, and technical specs into one artifact.

## Procedure

### Step 1: Load Template

Read the intent template from `@template.md` in this skill directory. Present the template sections to the user.

### Step 2: Guide Intent Creation

Walk through each section with the user:

1. **Desired Outcome** — What becomes possible after this change? Not implementation details.
2. **Context** — Why now? What signals led here?
3. **Constraints** — Hard boundaries: performance, compatibility, design standards.
4. **Acceptance Criteria** — Concrete, testable. Each independently verifiable.
5. **Non-Goals** — What this explicitly does NOT do.
6. **Open Questions** — Unknowns to resolve before or during generation.

### Step 3: Validate Completeness

Ensure all required sections are filled. Flag any section that is empty or vague:
- Desired outcome must describe an end state, not an implementation
- Acceptance criteria must be testable
- At least one non-goal must be stated
- Open questions should be acknowledged even if "none"

### Step 4: Detect Mode

Read `.idd/config.yml` to determine GitHub or local mode.

### Step 5: Create the Intent

**GitHub mode:**

```bash
# Create issue with intent label
gh issue create --title "<intent title>" --body "<intent body>" --label "intent"
```

The issue body is the full intent document content.

**Local mode:**

- Determine next sequential ID by counting files in `.idd/intent-queue/`
- Create file: `.idd/intent-queue/INTENT-<NNN>-<slugified-title>.md`
- Set status to DRAFT in the header

### Step 6: Superpowers Integration

If `superpowers:brainstorming` is available, offer to invoke it for deeper exploration of the intent before approving it.

### Step 7: Report

Show the created intent (issue URL or file path). Suggest next steps:
- Review and approve the intent (set status to APPROVED)
- Then run `idd:generate` to start building
