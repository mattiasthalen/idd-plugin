---
name: generate
description: >-
  Use when an intent is approved and ready to build.
  Trigger: "generate", "start building", "implement intent", "build this intent", "ready to build".
---

# IDD Generate

**Announce:** "Using idd:generate to set up generation from the approved intent."

## What This Skill Does

Prepares the generation phase by loading the full intent context, setting constraints from acceptance criteria and non-goals, and guiding the AI to produce candidates. The human's job during generation: provide complete context, avoid over-specification, and request multiple options when uncertain.

## Procedure

### Step 1: Identify the Active Intent

**GitHub mode:**

```bash
# List open intents
gh issue list --label "intent" --state open
```

Ask the user which intent to generate from, or accept an intent number as argument.

**Local mode:**

List files in `.idd/intent-queue/` with status APPROVED or IN-LOOP.

### Step 2: Load the Intent Document

**GitHub mode:**

```bash
gh issue view <number> --json title,body,labels
```

**Local mode:**

Read the intent file from `.idd/intent-queue/`.

Update status to IN-LOOP (add label in GitHub mode, update header in local mode).

### Step 3: Extract Generation Constraints

From the intent document, extract and present:
- **Acceptance criteria** — these are the success conditions
- **Non-goals** — these are the boundaries (do NOT do these things)
- **Constraints** — hard limits to respect
- **Open questions** — resolve these before or during generation

### Step 4: Check for Prior Attempts

**GitHub mode:**

```bash
gh issue view <number> --json comments
```

Look for prior REDIRECT decisions — they contain feedback on what to change. Present prior attempt feedback to inform this generation round.

**Local mode:**

Check `.idd/decision-log.md` for entries matching this intent ID.

### Step 5: Superpowers Integration

If superpowers is available:
- Invoke `superpowers:writing-plans` to create an implementation plan
- Invoke `superpowers:test-driven-development` for TDD execution

If superpowers is NOT available, provide built-in generation guidance:
- Request multiple approaches when the path is ambiguous
- Write tests before implementation
- Start with the simplest approach that satisfies acceptance criteria
- Respect non-goals — actively avoid scope creep
- Check constraints continuously during implementation

### Step 6: Report

Confirm generation is set up. The user (or AI) now implements against the intent. When implementation is complete, suggest running `idd:evaluate` to review the output.
