# IDD Plugin Design Spec

**Date:** 2026-03-27
**Status:** Approved

## Overview

A Claude Code plugin that implements the Intent-Driven Development framework as interactive skills. Provides the five core loop phases as skills, plus an init skill for project adoption and a loop skill for full-cycle orchestration.

## Identity

- **Plugin name:** `idd`
- **Repo:** `mattiasthalen/idd-plugin`
- **Install:** Users add `mattiasthalen/idd-plugin` as a Claude Code plugin
- **Skill namespace:** `idd:` (e.g., `idd:intent`, `idd:evaluate`)
- **Companion site:** https://mattiasthalen.github.io/intent-driven-development/

## Target Audience

Small teams (2-10) adopting IDD for AI-native development. The plugin is the practical companion to the IDD manifesto — it encodes the methodology so the framework enforces itself.

## Superpowers Relationship

Soft dependency. Works standalone, enhances if superpowers is present.

- Each skill detects superpowers at runtime
- If available: IDD provides methodology, superpowers provides execution (TDD, code review, plans, etc.)
- If not: falls back to built-in guidance (checklists, prompts, templates)
- No import/require — just checks if superpowers skills are invocable

## Plugin Structure

```
idd-plugin/
├── .claude-plugin/
│   └── plugin.json
├── hooks/
│   ├── hooks.json
│   ├── run-hook.cmd
│   └── session-start
├── skills/
│   ├── init/
│   │   └── SKILL.md
│   ├── intent/
│   │   ├── SKILL.md
│   │   └── template.md
│   ├── generate/
│   │   └── SKILL.md
│   ├── evaluate/
│   │   ├── SKILL.md
│   │   └── checklist.md
│   ├── decide/
│   │   └── SKILL.md
│   ├── learn/
│   │   └── SKILL.md
│   └── loop/
│       └── SKILL.md
├── commands/
│   ├── intent.md
│   ├── decide.md
│   └── loop.md
├── docs/
│   └── superpowers/
│       ├── specs/
│       └── plans/
├── README.md
└── LICENSE
```

## Skills

### idd:init

- **Trigger:** Adopting IDD on a new or existing project
- **What it does:**
  - Scaffolds `.idd/` directory structure
  - Creates empty intent queue, decision log, principles file
  - Scans existing project state (CLAUDE.md, existing plans/specs)
  - Converts existing artifacts into intent documents where possible
  - Seeds design principles from existing CLAUDE.md patterns
  - Adds IDD conventions to CLAUDE.md
  - Detects superpowers and configures integration
- **Artifacts:** Creates `.idd/intent-queue/`, `.idd/decision-log.md`, `.idd/principles.md`

### idd:intent

- **Trigger:** Starting new work, before implementation
- **What it does:**
  - Guides creation of intent document from template
  - Validates required sections (desired outcome, context, constraints, acceptance criteria, non-goals, open questions)
  - GitHub mode: creates a GitHub Issue with `intent` label, intent body as issue body
  - Local mode: creates markdown file in `.idd/intent-queue/` with sequential ID
- **Artifacts:** GitHub Issue or local intent doc
- **Superpowers:** Feeds into `superpowers:brainstorming` if available
- **Template:** `template.md` contains the Intent Document Template from the manifesto

### idd:generate

- **Trigger:** Intent approved, ready to build
- **What it does:**
  - Reads the intent document for full context
  - Sets up generation constraints from acceptance criteria and non-goals
  - Provides context to AI (intent doc, codebase context, prior attempts)
  - Guides requesting multiple options when approach is ambiguous
- **Artifacts:** None
- **Superpowers:** Invokes `superpowers:writing-plans` + `superpowers:test-driven-development` if available, falls back to generation guidance

### idd:evaluate

- **Trigger:** Code produced, needs review
- **What it does:**
  - Structured evaluation against 6 dimensions from the manifesto:
    1. Correctness — meets acceptance criteria?
    2. Taste — feels right for users?
    3. Simplicity — simplest solution that works?
    4. Coherence — fits existing patterns?
    5. Sustainability — maintainable in 6 months?
    6. Community fit — contributors will understand?
  - References the intent document's acceptance criteria
  - Produces evaluation summary
- **Artifacts:** None (judgment phase)
- **Superpowers:** Invokes `superpowers:requesting-code-review` if available, falls back to checklist
- **Supporting file:** `checklist.md` contains the evaluation dimensions

### idd:decide

- **Trigger:** Evaluation complete
- **What it does:**
  - Prompts for decision: ACCEPT, REDIRECT, RETHINK, or PARK
  - Requires one-line rationale
  - Logs decision with timestamp, intent ID, and rationale
  - On ACCEPT: adds `accept` label, closes issue, prompts to move to learn phase
  - On REDIRECT: adds `redirect` label, increments `loops:N` label, adds comment, keeps open
  - On RETHINK: adds `rethink` label, adds comment, keeps open for revised intent
  - On PARK: adds `park` label, closes issue
  - GitHub mode: logs as issue comment, updates labels
  - Local mode: appends to `.idd/decision-log.md`
- **Artifacts:** GitHub Issue comment or local decision log entry
- **Superpowers:** Invokes `superpowers:finishing-a-development-branch` on ACCEPT if available

### idd:learn

- **Trigger:** After a decision is made
- **What it does:**
  - Prompts to update CLAUDE.md with new patterns/conventions
  - Prompts to capture taste decisions as design principles
  - Prompts to add regression tests from failures
  - Prompts to refine intent template if gaps appeared
  - Updates `.idd/principles.md` with new entries
- **Artifacts:** Updates `.idd/principles.md`, CLAUDE.md
- **Superpowers:** None — IDD-native

### idd:loop

- **Trigger:** Orchestrate a full IDD cycle
- **What it does:**
  - Meta-skill that chains all 5 phases sequentially
  - Walks user through: intent → generate → evaluate → decide → learn
  - Handles branching (REDIRECT loops back to generate, RETHINK loops back to intent)
  - Tracks convergence (counts loops per intent)
- **Artifacts:** All of the above
- **Superpowers:** Orchestrates superpowers skills through IDD phases

## Intent Tracking: GitHub-Native (with local fallback)

When `gh` CLI is available and the project is a GitHub repo, intents are tracked as GitHub Issues — no local markdown files to sync.

### GitHub Mode (primary)

- **Intents = GitHub Issues** with `intent` label
- **Intent Queue = open issues** filtered by `intent` label
- **Decision outcome = labels** — `accept`, `redirect`, `rethink`, `park`
- **Decision rationale = issue comments** — logged as a comment when decision is made
- **Convergence tracking = labels** — `loops:1`, `loops:2`, etc.
- **Archive = closed issues** — DONE or PARKED intents are closed

Skills use `gh issue create`, `gh issue view`, `gh issue comment`, `gh issue close`, `gh issue edit`, etc.

### Local Fallback (no GitHub)

When `gh` is not available or the project isn't on GitHub:

```
.idd/
├── intent-queue/
│   ├── INTENT-001-feature-name.md
│   └── INTENT-002-another-feature.md
├── archive/                  ← Completed or parked intents
└── decision-log.md           ← Chronological decisions with rationale
```

### Intent Document Statuses

DRAFT → APPROVED → IN-LOOP → DONE | PARKED

## Local Artifacts (always present)

```
.idd/
├── principles.md             ← Accumulated taste decisions (AI-readable)
└── config.yml                ← Plugin settings (labels, milestone naming, etc.)
```

## Hooks

### SessionStart

- Check context freshness: warn if CLAUDE.md hasn't been updated in 7+ days
- Show active intent count (from GitHub Issues or local queue)
- Inject IDD context into session

## Commands (Shortcuts)

- `/intent` → invokes `idd:intent`
- `/decide` → invokes `idd:decide`
- `/loop` → invokes `idd:loop`

## Key Design Decisions

1. **Soft superpowers dependency** — works standalone, enhances if present
2. **GitHub-native intent tracking** — intents are GitHub Issues when `gh` is available, local markdown fallback otherwise
3. **Labels for everything** — decision outcomes, convergence tracking, intent identification
4. **Decision log as issue comments** — decisions live alongside the intent they belong to
5. **`.idd/` directory** — minimal local state: principles and config only (in GitHub mode)
6. **No enforcement of principles** — guidance only, teams own their taste
7. **Soft `gh` dependency** — works without GitHub, richer with it
