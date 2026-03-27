---
name: learn
description: >-
  Use after a decision has been made to capture learnings.
  Trigger: "learn", "capture learnings", "update principles", "what did we learn", "retrospective".
---

# IDD Learn

**Announce:** "Using idd:learn to capture learnings from this IDD loop."

## What This Skill Does

The learn phase closes the loop by updating shared context. This is what makes IDD accumulate intelligence over time rather than repeating mistakes. No superpowers dependency — this is IDD-native.

## Procedure

### Step 1: Review the Completed Loop

Gather context from the just-completed intent:
- The original intent document
- The evaluation summary
- The decision and rationale
- How many loops it took to converge (check `loops:N` label or decision log)

### Step 2: Prompt for Learnings

Ask the user four questions:

**1. New patterns or conventions?**
> Did this work reveal any patterns that should be followed in future work? (e.g., "Always use X pattern for Y situation")

If yes → Update `CLAUDE.md` with the new convention.

**2. Taste decisions?**
> Were there any judgment calls about quality, style, or design that should be remembered? (e.g., "We prefer X over Y because Z")

If yes → Append to `.idd/principles.md`:

```markdown
## <Principle Title>

**Date:** <YYYY-MM-DD>
**From:** <Intent title/ID>

<Description of the principle and why it matters>
```

**3. Regression risks?**
> Did any failures or near-misses during this loop suggest tests that should exist? (e.g., "We should have caught X with a test for Y")

If yes → Note the suggested tests for the user to add.

**4. Template gaps?**
> Did the intent template miss anything important? Were there sections that didn't apply or questions that should have been asked upfront?

If yes → Note suggested improvements to the intent template.

### Step 3: Apply Updates

- Edit `CLAUDE.md` with new conventions (if any)
- Append new principles to `.idd/principles.md` (if any)
- Report all changes made

### Step 4: Report

Summarize what was learned and what was updated. The IDD loop is now complete.

Remind the user: *"The goal is not to write more code faster. The goal is to converge on the right thing faster."*
