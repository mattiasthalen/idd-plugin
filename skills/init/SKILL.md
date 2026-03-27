---
name: init
description: >-
  Use when adopting IDD on a new or existing project.
  Trigger: "init idd", "set up idd", "adopt idd", "initialize idd", "start using idd".
---

# IDD Init

**Announce:** "Using idd:init to set up Intent-Driven Development for this project."

## What This Skill Does

Bootstraps a project for IDD by scaffolding the `.idd/` directory, seeding design principles, and configuring intent tracking mode (GitHub Issues or local markdown).

## Procedure

### Step 1: Detect Environment

Check for GitHub CLI and remote:

```bash
gh auth status 2>/dev/null && gh repo view --json name 2>/dev/null
```

- If both succeed → **GitHub mode** (intents tracked as GitHub Issues)
- Otherwise → **Local mode** (intents tracked as markdown files in `.idd/intent-queue/`)

Report the detected mode to the user.

### Step 2: Scaffold `.idd/` Directory

**Always create:**

```
.idd/
├── principles.md        ← Accumulated taste decisions
└── config.yml           ← Plugin settings
```

**Local mode only — also create:**

```
.idd/
├── intent-queue/        ← Active intent documents
├── archive/             ← Completed/parked intents
└── decision-log.md      ← Chronological decisions
```

**config.yml contents:**

```yaml
# IDD Configuration
mode: github  # or "local"
labels:
  intent: intent
  accept: accept
  redirect: redirect
  rethink: rethink
  park: park
```

**principles.md contents:**

```markdown
# Design Principles

> Accumulated taste decisions for this project. Updated during the Learn phase.
> AI agents read this file for project context.

<!-- Add principles as they emerge from IDD loops -->
```

**decision-log.md contents (local mode only):**

```markdown
# Decision Log

> Chronological record of IDD decisions.

| Date | Intent | Decision | Rationale |
|------|--------|----------|-----------|
```

### Step 3: Scan Existing Project State

- Read `CLAUDE.md` if it exists — extract any patterns or conventions that could seed `principles.md`
- Check for existing `docs/` directories, plans, or specs
- Report findings to the user

### Step 4: Update CLAUDE.md

Append IDD conventions to `CLAUDE.md` (create if missing):

```markdown
# IDD

This project uses Intent-Driven Development.

- Intent documents define WHAT to build, not HOW
- All work starts with an intent (use `idd:intent` or `/intent`)
- Evaluate outputs against the 6 dimensions: correctness, taste, simplicity, coherence, sustainability, community fit
- Design principles are in `.idd/principles.md`
- Run a full IDD loop with `idd:loop` or `/loop`
```

### Step 5: Detect Superpowers

Check if superpowers skills are available. If present, inform the user that IDD skills will delegate to superpowers for execution (TDD, code review, plans).

### Step 6: Ensure `.idd/` is Tracked

```bash
git add .idd/
```

Remind the user to commit the scaffolded files.

### Step 7: Report

Summarize what was created and the detected mode. Suggest running `idd:intent` or `/intent` to create the first intent.
