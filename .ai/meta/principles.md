# Instruction Design Principles

## 1. Atomicity

Each instruction file should be self-contained and handle one responsibility. It should work independently without requiring other instruction files to function.

**Good:** `manager/conventional-commits.md` — instructions for conventional commits only
**Bad:** `manager/commits-and-tasks.md` — mixing two unrelated responsibilities

## 2. Composability

Instructions must combine cleanly. Avoid contradictions between atomic pieces. Use clear interfaces — if a flow requires output from one role as input to another, define the artifact format explicitly.

## 3. Parameterization

Where behavior varies by project, use explicit parameters rather than hardcoding. Define parameters in project config files (`context.md`, `tech-spec.md`, `environment.md`) and reference them from instructions.

Example: Instead of "use npm to run tests", write "use the project's test runner (defined in tech-spec.md) to run tests."

## 4. Clarity Over Cleverness

Write instructions as if for a capable but literal-minded agent:
- Be explicit about expected behavior
- Specify what NOT to do when common mistakes are likely
- Include concrete examples for ambiguous instructions

## 5. Format Conventions

- Use imperative mood: "Create a commit" not "You should create a commit"
- Use markdown headers for structure
- Use code blocks for command examples and file templates
- Keep individual files focused — prefer multiple small files over one large file
- Use bullet lists for rules, numbered lists for sequential steps

## 6. Testability

Instructions should produce observable, verifiable results. Define what "done" looks like.

Example: "After creating the implementation plan, verify it contains: task breakdown, dependency order, affected files list."

## 7. Context Boundaries

Instructions should clearly state:
- What inputs they expect (artifacts, config values)
- What outputs they produce (files, artifacts, state changes)
- What tools or access they require
