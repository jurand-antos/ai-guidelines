# Project Context

## What This Project Is

A collection of reusable, composable AI agent instructions organized by roles. These instructions are designed to be installed or copied into target projects to configure AI coding assistants (Claude Code, Codex, Junie, and others).

## Target Roles

Instructions are organized by these roles:

- **designer** — gathers requirements, creates PRDs, designs solutions
- **manager** — manages tasks, commits, project coordination
- **tester** — writes and runs tests, validates implementations
- **debugger** — diagnoses issues, accesses environments, analyzes logs
- **coder** — implements features, follows coding standards

## Key Challenge

Each role has multiple possible workflows depending on the target project:

- Manager might use Jira, local filesystem, or hybrid task management
- Manager might follow conventional commits or a custom commit format
- Coder might work with PHP, TypeScript, or other tech stacks
- Debugger might have access to different environments and tools

This means instructions must be **atomic** (self-contained units) and **composable** (combinable into project-specific configurations).

## Product Location

The product uses a category-based layout. Each top-level directory is a self-contained instruction pack:

```
<category>/       # Each top-level dir is a self-contained instruction pack
  roles/          # Role-specific procedures  (it-support specific)
  flows/          # Multi-role workflows       (it-support specific)
  meta/           # Setup, discovery, audit    (it-support specific)
  prd/            # Templates                  (it-support specific)
```

Currently the only category is `it-support/`. Future categories (e.g., storytelling, tts-prompts) may have completely different internal structures.

## Target Project Structure

When installed in a target project, the instruction set produces:

```
.ai/
  guidelines.md          # Main entry point
  project/
    context.md           # Project-specific context
    tech-spec.md         # Technology stack details
    environment.md       # Available environments, tools, access
  roles/                 # Selected role instructions
  flows/                 # Selected workflow definitions
  prd/                   # Project requirement documents
  meta/                  # Configuration and customization
```

## Working Notes

- Distribution: `bin/install.sh <category> <target>` copies a category into a target directory
