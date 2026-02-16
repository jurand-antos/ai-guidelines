# it-support

Role-based instructions for AI coding agents — covers design, implementation, testing, debugging, and task management.

## What's Inside

| Directory | Purpose |
|-----------|---------|
| `roles/` | Role-specific procedures — one subdirectory per role |
| `flows/` | Multi-role workflows for end-to-end scenarios |
| `meta/` | Setup, discovery, and audit tools |
| `prd/` | Task tracking templates |

## Roles

- **designer/** — requirements gathering, implementation plans, design principles
- **coder/** — coding standards, code quality rules, testing rules
- **e2e-tester/** — E2E test methodology, selector strategy, quality standards
- **debugger/** — systematic 6-phase investigation process
- **manager/** — task lifecycle, commits (conventional or custom), PRs, ticket updates

## Flows

- `design-to-code.md` — new feature: requirements → design → code → commit
- `task-continuation.md` — continue existing task from where it left off
- `bugfix.md` — bug investigation → fix → commit

## Install

```bash
bin/install.sh it-support ./.ai
```

Or manually:

```bash
mkdir -p .ai
cp -r it-support/roles/ .ai/roles/
cp -r it-support/flows/ .ai/flows/
cp -r it-support/meta/  .ai/meta/
cp -r it-support/prd/   .ai/prd/
```

## After Install

The `meta/` directory includes tools for project setup:

1. **`meta/init.md`** — initialize `.ai/` in a new project (auto-detect tech stack, generate project files)
2. **`meta/discovery.md`** — detect available MCP tools and adapt workflows
3. **`meta/audit.md`** — audit existing `.ai/` setup for gaps

Start by telling your AI agent:

```
Read `.ai/meta/init.md` and run discovery + project file generation for this project.
```

## Structure

```
it-support/
├── roles/
│   ├── designer/
│   │   ├── designer.md
│   │   ├── create-requirements.md
│   │   ├── create-implementation-plan.md
│   │   └── design-principles.md
│   ├── coder/
│   │   ├── coder.md
│   │   ├── coding-standards.md
│   │   ├── code-quality.md
│   │   └── testing-rules.md
│   ├── e2e-tester/
│   │   ├── e2e-tester.md
│   │   ├── e2e-methodology.md
│   │   ├── selector-strategy.md
│   │   └── test-quality.md
│   ├── debugger/
│   │   └── debugger.md
│   └── manager/
│       ├── manager.md
│       ├── create-task.md
│       ├── create-task-from-ticket.md
│       ├── close-task.md
│       ├── conventional-commits.md
│       ├── custom-commits.md
│       ├── pr-description.md
│       └── update-ticket.md
├── flows/
│   ├── design-to-code.md
│   ├── task-continuation.md
│   └── bugfix.md
├── meta/
│   ├── init.md
│   ├── discovery.md
│   ├── audit.md
│   ├── meta.md
│   ├── guidelines-example-shopware.md
│   └── templates/
│       ├── context.md
│       ├── tech-spec.md
│       └── environments.md
└── prd/
    ├── requirements-template.md
    └── task-index-template.md
```
