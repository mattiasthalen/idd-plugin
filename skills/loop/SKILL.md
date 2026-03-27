---
name: loop
description: >-
  Use to orchestrate a full IDD cycle from intent through learn.
  Trigger: "idd loop", "full loop", "run the loop", "start idd cycle", "intent to learn".
---

# IDD Loop

**Announce:** "Using idd:loop to orchestrate a full IDD cycle."

## What This Skill Does

Meta-skill that chains all five IDD phases sequentially: intent → generate → evaluate → decide → learn. Handles branching on REDIRECT (back to generate) and RETHINK (back to intent). Tracks convergence across loops.

## Procedure

### Step 1: Intent Phase

Invoke `idd:intent` to create or select an intent document.

If an existing approved intent is provided as argument, skip creation and use it directly.

### Step 2: Generate Phase

Invoke `idd:generate` with the approved intent.

The user (with AI assistance) implements the intent.

### Step 3: Evaluate Phase

When implementation is complete, invoke `idd:evaluate` to assess the output.

### Step 4: Decide Phase

Invoke `idd:decide` to make a decision.

### Step 5: Handle Decision Outcome

- **ACCEPT** → Continue to Step 6 (Learn)
- **REDIRECT** → Return to Step 2 (Generate) with the redirect feedback. Increment loop counter.
- **RETHINK** → Return to Step 1 (Intent) for revision. Increment loop counter.
- **PARK** → End the loop. Optionally invoke `idd:learn` for any learnings despite parking.

### Step 6: Learn Phase

Invoke `idd:learn` to capture learnings and update shared context.

### Step 7: Report

Summarize the completed loop:
- Intent title
- Number of loops to convergence
- Decision outcome
- Learnings captured

## Convergence Tracking

Track how many times the loop cycles for a given intent. High loop counts (3+) suggest the intent needs decomposition or the constraints are too vague.

## Superpowers Orchestration

When superpowers is available, each phase delegates to the appropriate superpowers skill:
- Generate → `superpowers:writing-plans` + `superpowers:test-driven-development`
- Evaluate → `superpowers:requesting-code-review`
- Decide (ACCEPT) → `superpowers:finishing-a-development-branch`

IDD provides the methodology; superpowers provides the execution discipline.
