# IDD Plugin

A [Claude Code](https://docs.anthropic.com/en/docs/claude-code) plugin that implements the [Intent-Driven Development](https://mattiasthalen.github.io/intent-driven-development/) framework as interactive skills.

## What is IDD?

Intent-Driven Development is a post-Scrum operating system for AI-native teams. Instead of sprints and story points, IDD uses a continuous loop:

**Intent → Generate → Evaluate → Decide → Learn**

The goal is not to write more code faster. The goal is to converge on the right thing faster.

## Installation

Add this plugin to your Claude Code configuration:

```bash
claude plugin add mattiasthalen/idd-plugin
```

Then initialize IDD in your project:

```
/init
```

## Skills

| Skill | Trigger | Description |
|-------|---------|-------------|
| `idd:init` | Adopting IDD | Scaffolds `.idd/` directory, configures intent tracking |
| `idd:intent` | Starting new work | Guides creation of intent documents |
| `idd:generate` | Intent approved | Sets up generation context and constraints |
| `idd:evaluate` | Code produced | Structured evaluation against 6 dimensions |
| `idd:decide` | Evaluation complete | Records decision: ACCEPT, REDIRECT, RETHINK, or PARK |
| `idd:learn` | After a decision | Captures learnings, updates principles and conventions |
| `idd:loop` | Full cycle | Orchestrates all 5 phases with branching |

## Commands

| Command | Description |
|---------|-------------|
| `/intent` | Create a new intent document |
| `/decide` | Make a decision on the current evaluation |
| `/loop` | Run a full IDD cycle |

## Superpowers Integration

Works standalone, enhances if [superpowers](https://github.com/anthropics/claude-code-plugins) is installed:

- **Generate** → delegates to `superpowers:writing-plans` + `superpowers:test-driven-development`
- **Evaluate** → delegates to `superpowers:requesting-code-review`
- **Decide (ACCEPT)** → delegates to `superpowers:finishing-a-development-branch`

## Intent Tracking

**GitHub mode** (default when `gh` CLI is available): Intents are GitHub Issues with labels for status tracking.

**Local mode** (fallback): Intents are markdown files in `.idd/intent-queue/`.

## License

MIT
