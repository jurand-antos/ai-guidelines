# Product Structure Reference

## Repository Layout

The repository uses a category-based layout. Each top-level directory is a self-contained instruction pack.

```
# Categories (each is a self-contained instruction pack)
<category>/
  ...                        # Internal structure varies per category

# Example: it-support category
it-support/
  roles/
    designer/
      designer.md
      create-requirements.md
      create-implementation-plan.md
      design-principles.md
    manager/
      conventional-commits.md
      custom-commits.md
      ...
    coder/
      coding-standards.md
      code-quality.md
      testing-rules.md
      ...
    e2e-tester/
      e2e-tester.md
      e2e-methodology.md
      ...
    debugger/
      debugger.md
      ...
  flows/
    design-to-code.md
    bugfix.md
    task-continuation.md
    ...
  meta/
    init.md
    discovery.md
    audit.md
    ...
  prd/
    requirements-template.md
    task-index-template.md
    ...

# Tooling
bin/
  install.sh                 # Category installer
```

Each category defines its own internal structure. The `it-support` example above uses roles/flows/meta/prd, but future categories may organize differently.

## Naming Conventions

- Use lowercase kebab-case for file names: `conventional-commits.md`
- Role directories match role names exactly: `designer/`, `manager/`, etc.
- Flow files describe the pipeline: `design-to-code.md`
- Category directories use lowercase kebab-case: `it-support/`

## Instruction File Template

Each instruction file should follow this structure:

```markdown
# Title

## Purpose

One-line description of what this instruction covers.

## Prerequisites

- Required config values, artifacts, or tools

## Instructions

The actual instructions for the AI agent.

## Artifacts

Files or outputs this instruction produces.
```
