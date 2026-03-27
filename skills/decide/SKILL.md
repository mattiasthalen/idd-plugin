---
name: decide
description: >-
  Use when evaluation is complete and a decision is needed.
  Trigger: "decide", "make decision", "accept", "redirect", "rethink", "park", "what's the verdict".
---

# IDD Decide

**Announce:** "Using idd:decide to record the decision for this intent."

## What This Skill Does

Prompts for a decision on the evaluated implementation, requires a rationale, and logs the outcome. The four decision states:

- **ACCEPT** — merge and release
- **REDIRECT** — improve generation constraints (loop back to generate)
- **RETHINK** — revisit the intent itself (loop back to intent)
- **PARK** — defer with retrieval criteria

## Procedure

### Step 1: Identify the Active Intent

Load the intent that was just evaluated (same as idd:generate Step 1-2).

### Step 2: Prompt for Decision

Ask the user to choose one of the four outcomes. Require a one-line rationale explaining why.

### Step 3: Log the Decision

**GitHub mode:**

Add a comment to the issue with the decision:

```bash
gh issue comment <number> --body "**Decision:** <OUTCOME>
**Rationale:** <rationale>
**Date:** <YYYY-MM-DD>"
```

Update labels based on outcome:

```bash
# Remove any prior decision labels
gh issue edit <number> --remove-label "accept,redirect,rethink,park" 2>/dev/null

# Add new decision label
gh issue edit <number> --add-label "<outcome>"
```

**Local mode:**

Append to `.idd/decision-log.md`:

```markdown
| <YYYY-MM-DD> | INTENT-<NNN> | <OUTCOME> | <rationale> |
```

### Step 4: Handle Outcome

**On ACCEPT:**
- Add `accept` label, close the issue (`gh issue close <number>`)
- Local mode: move intent file to `.idd/archive/`, update status to DONE
- Prompt to move to learn phase (`idd:learn`)
- If `superpowers:finishing-a-development-branch` is available, invoke it

**On REDIRECT:**
- Add `redirect` label, keep issue open
- Increment convergence counter: find current `loops:N` label, increment to `loops:N+1`
  ```bash
  # Add/update loops label
  gh issue edit <number> --add-label "loops:<N>"
  ```
- Add comment explaining what to change in the next generation round
- Loop back to `idd:generate`

**On RETHINK:**
- Add `rethink` label, keep issue open
- Add comment explaining what needs to change in the intent
- Loop back to `idd:intent` for revised intent

**On PARK:**
- Add `park` label, close the issue (`gh issue close <number>`)
- Local mode: move intent file to `.idd/archive/`, update status to PARKED
- Add comment with retrieval criteria (when should this be revisited?)

### Step 5: Report

Confirm the decision was logged. State the next action based on the outcome.
