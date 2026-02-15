# AI Agent Guidelines — Reusable Instructions for AI-Assisted Development

**Production-ready, portable, composable instructions for AI coding agents.**

This repository contains a complete set of role-based instructions, workflow patterns, and templates for organizing AI-agent-assisted software development. Copy these files into your project's `.ai/` directory to give your AI agent structured guidance on how to work with your codebase.

---

## What Is This?

AI coding agents (Claude Code, Codex CLI, Junie, etc.) work better with clear, structured instructions. This repository provides:

- **Role-based instructions** — specialized procedures for Designer, Coder, E2E Tester, Debugger, Manager roles
- **Workflow patterns** — end-to-end flows for common scenarios (new feature, task continuation, bugfix)
- **Templates** — ready-to-use templates for requirements, task tracking, project configuration
- **Meta tools** — automated discovery, audit, and initialization procedures for new projects

All instructions are **project-agnostic** and **framework-agnostic** — you customize them through configuration files, not by editing the instruction files themselves.

---

## How It Works

### Architecture

Every AI coding tool has its own entry-point file (e.g., `CLAUDE.md` for Claude Code). This repo uses a **single redirect pattern** — all entry points contain just one line:

```
Read and follow all instructions from `.ai/guidelines.md` before starting any task.
```

The `.ai/guidelines.md` file is the real entry point. It reads project context, selects the right role for the task, and dispatches to the appropriate procedures:

```
Agent entry point (CLAUDE.md / AGENTS.md / .junie/guidelines.md)
    ↓
.ai/guidelines.md  (role selection, project context)
    ↓
.ai/roles/          (role-specific procedures)
.ai/flows/          (multi-role workflows)
.ai/project/        (project-specific config — tech stack, environments)
.ai/prd/            (task tracking — requirements, plans, reports)
```

### Portable vs Project-Specific

The `.ai/` directory has two kinds of content:

| Type | Directories | What it is | How it's maintained |
|------|------------|------------|---------------------|
| **Portable** | `roles/`, `flows/`, `meta/` | Role procedures, workflows, meta tools | Copied as-is from this repo, never edited per-project |
| **Project-specific** | `project/`, `prd/` | Tech stack, environments, task tracking | Generated during setup, unique to each project |

This means upgrading is simple: replace `roles/`, `flows/`, `meta/` with the latest version from this repo. Your `project/` and `prd/` files stay untouched.

---

## Setup

### Recommended: Install Script (Semi-Automatic)

The repo includes an install script that copies all portable files into your project, then prints a prompt you paste into your AI agent to complete the setup.

```bash
# 1. Clone the repo (if you haven't already)
git clone git@github.com:arclivia/ai-guidelines.git

# 2. Run the install script, pointing it at your project
./ai-guidelines/install.sh /path/to/your-project

# 3. Paste the printed prompt into your AI agent
```

The script will:
- Create `.ai/` directory structure with portable files (`roles/`, `flows/`, `meta/`, `prd/`)
- Create `.ai/guidelines.md` from the example template (won't overwrite if it already exists)
- Create agent entry points (`CLAUDE.md`, `AGENTS.md`, `.junie/guidelines.md`)
- Add `.gitignore` rules for task tracking files

The AI agent will then:
- **Run discovery** — auto-detect your tech stack, frameworks, QA tools from project files
- **Ask you** only what can't be auto-detected (project key, environments, access details)
- **Generate project-specific files** (`project/context.md`, `project/tech-spec.md`, `project/environments.md`)

Running the script again is safe — it upgrades portable files while preserving your project-specific configuration.

### Manual Setup

If you prefer to set it up yourself:

```bash
# 1. Create the .ai directory in your project root
mkdir -p .ai

# 2. Copy portable files from this repo
cp -r roles/ your-project/.ai/roles/
cp -r flows/ your-project/.ai/flows/
cp -r meta/  your-project/.ai/meta/
cp -r prd/   your-project/.ai/prd/

# 3. Create the entry point — use the example as a starting point
cp meta/guidelines-example-shopware.md your-project/.ai/guidelines.md
# Then customize guidelines.md for your project

# 4. Create project-specific files from templates
mkdir -p your-project/.ai/project/
cp meta/templates/context.md      your-project/.ai/project/context.md
cp meta/templates/tech-spec.md    your-project/.ai/project/tech-spec.md
cp meta/templates/environments.md your-project/.ai/project/environments.md
# Then fill in the placeholders

# 5. Create agent entry point(s)
# For Claude Code:
echo 'Read and follow all instructions from `.ai/guidelines.md` before starting any task.' > your-project/CLAUDE.md
# For Codex CLI:
echo 'Read and follow all instructions from `.ai/guidelines.md` before starting any task.' > your-project/AGENTS.md
# For Junie:
mkdir -p your-project/.junie
echo 'Read and follow all instructions from `.ai/guidelines.md` before starting any task.' > your-project/.junie/guidelines.md

# 6. Add .gitignore rules
echo '.ai/prd/*'        >> your-project/.gitignore
echo '!.ai/prd/prd.md'  >> your-project/.gitignore
```

### After Setup

Start working by telling your AI agent what to do. The agent reads `.ai/guidelines.md`, selects the appropriate role, and follows the procedures:

```
"Help me implement a new feature: {description}"         → flows/design-to-code.md
"Continue working on task PROJ-11"                        → flows/task-continuation.md
"Investigate this bug: {description}"                     → flows/bugfix.md
"Create E2E tests for the checkout flow"                  → roles/e2e-tester/e2e-tester.md
```

---

## Repository Structure

```
ai-guidelines/
├── meta/                               # Setup, discovery, audit tools
│   ├── meta.md                         # Index of meta tools
│   ├── init.md                         # Initialize .ai/ in a new project
│   ├── audit.md                        # Audit existing .ai/ for gaps
│   ├── discovery.md                    # Auto-detect tech stack, ask remaining questions
│   ├── guidelines-example-shopware.md  # Example guidelines.md for Shopware e-commerce
│   └── templates/                      # Project configuration templates
│       ├── context.md                  #   → project identity, workflow tools
│       ├── tech-spec.md                #   → technology stack, QA tools
│       └── environments.md             #   → environment access, logs, services
├── roles/                              # Role-based procedures (portable)
│   ├── designer/                       # Requirements and design
│   │   ├── designer.md                 #   Role entry point
│   │   ├── create-requirements.md      #   Requirements gathering procedure
│   │   ├── create-implementation-plan.md  # Implementation plan creation
│   │   └── design-principles.md        #   Design principles reference
│   ├── coder/                          # Implementation
│   │   ├── coder.md                    #   Role entry point
│   │   ├── coding-standards.md         #   Coding standards
│   │   ├── code-quality.md             #   Code quality rules
│   │   └── testing-rules.md            #   Testing rules
│   ├── e2e-tester/                     # E2E testing
│   │   ├── e2e-tester.md              #   Role entry point (2-session workflow)
│   │   ├── e2e-methodology.md          #   Testing methodology
│   │   ├── selector-strategy.md        #   Language-independent selectors
│   │   └── test-quality.md             #   Quality standards
│   ├── debugger/                       # Investigation and diagnosis
│   │   └── debugger.md                 #   6-phase debugging process
│   └── manager/                        # Task and workflow management
│       ├── manager.md                  #   Role entry point
│       ├── create-task.md              #   Create task from scratch
│       ├── create-task-from-ticket.md  #   Create task from issue tracker ticket
│       ├── close-task.md               #   Close completed task
│       ├── conventional-commits.md     #   Conventional commit format
│       ├── custom-commits.md           #   Ticket-prefixed commit format
│       ├── pr-description.md           #   Pull request description
│       └── update-ticket.md            #   Update issue tracker ticket
├── flows/                              # End-to-end workflows (portable)
│   ├── design-to-code.md              #   New feature: requirements → design → code
│   ├── task-continuation.md            #   Continue existing task
│   └── bugfix.md                       #   Bug investigation and fix
└── prd/                                # Task tracking templates
    ├── task-index-template.md          #   Template for prd/prd.md
    └── requirements-template.md        #   Template for task requirements (4 variations)
```

---

## Roles

### Designer — Requirements and Design

Creates requirements documents and implementation plans. Handles the "what" and "how" before coding begins.

- Requirements gathering with 4 template variations (feature, bugfix, refactoring, base)
- Implementation plans with file-by-file breakdown, step sequence, and risks
- Design principles reference for architectural decisions

### Coder — Implementation

Implements features and fixes following project standards. The "build" role.

- Coding standards, code quality rules, testing rules
- References `project/tech-spec.md` for framework-specific guidance

### E2E Tester — End-to-End Testing

Creates E2E tests using a 2-session workflow (planning → execution).

**Cardinal Rule:** No selector or assertion may depend on translated UI text.

- `data-testid` first — add to templates before writing tests
- MCP Playwright mandatory — analyze real pages, don't guess selectors
- Quality gates — tests verify business outcomes, not just element visibility

### Debugger — Investigation and Diagnosis

Systematic 6-phase debugging: reproduce → evidence → hypotheses → test → root cause → solution.

Creates `investigation-report.md` as a handoff artifact.

### Manager — Task and Workflow Management

Handles task lifecycle: creation, commits, PRs, ticket updates, task closure.

- Two commit formats: Conventional Commits or ticket-prefixed custom format
- PR description generation
- Issue tracker integration (Jira, GitHub Issues, etc.)

---

## Workflows

### New Feature → `flows/design-to-code.md`

```
User request → Manager (create task) → Designer (requirements → approval)
→ Designer (implementation plan → approval) → Coder (implement)
→ Manager (commit, PR, close)
```

### Bug Investigation → `flows/bugfix.md`

```
Bug report → Debugger (6-phase investigation → report → approval)
→ Coder (implement fix) → Manager (commit, close)
```

### Task Continuation → `flows/task-continuation.md`

```
"Continue task X" → Read existing requirements/plan → Coder (implement)
→ Manager (commit/close)
```

---

## Human-in-the-Loop (HITL)

Critical decision points require user approval before proceeding:

- **Requirements approval** — before creating implementation plan
- **Implementation plan approval** — before coding
- **Investigation report approval** — before fixing bugs
- **Commit message review** — before pushing

---

## MCP Tool Integration

Instructions are designed to work with **MCP (Model Context Protocol)** tools when available:

- **MCP Playwright** — for E2E test page analysis (`browser_snapshot`, `browser_navigate`)
- **MCP Jira** — for ticket fetching and updates
- **MCP Confluence** — for documentation access

The `meta/discovery.md` procedure detects available MCP tools and adapts workflows accordingly. If MCP is not available, workflows fall back to manual processes.

---

## Customization

### For Your Project

After setup, customize only the project-specific files:

1. `project/context.md` — project identity, workflow tools, commit format, task management
2. `project/tech-spec.md` — technology stack, frameworks, QA tools
3. `project/environments.md` — environment access, logs, services

### For Your Organization

You can extend the portable files for organization-wide standards:

- Add design principles to `roles/designer/design-principles.md`
- Add coding standards to `roles/coder/coding-standards.md`
- Create custom flow files for organization-specific workflows
- Add templates in `meta/templates/`

**Keep portability:** reference `project/context.md` and `project/tech-spec.md` instead of hardcoding project or framework names.

---

## Quick Reference

| I want to... | Read |
|---|---|
| Set up a new project (automated) | `meta/init.md` |
| Set up a new project (manual) | See "Manual Setup" above |
| Audit an existing setup | `meta/audit.md` |
| Detect available MCP tools | `meta/discovery.md` |
| Start a new feature | `flows/design-to-code.md` |
| Continue existing work | `flows/task-continuation.md` |
| Investigate a bug | `flows/bugfix.md` |
| Create E2E tests | `roles/e2e-tester/e2e-tester.md` |
| Write code | `roles/coder/coder.md` |
| Create requirements | `roles/designer/create-requirements.md` |
| Debug an issue | `roles/debugger/debugger.md` |
| See a full example entry point | `meta/guidelines-example-shopware.md` |

---

## Contributing

This repository was created by extracting and generalizing patterns from real production projects. Contributions that improve portability, add new roles or workflows, or fix errors are welcome.

---

## License

MIT License — see LICENSE file for details.
