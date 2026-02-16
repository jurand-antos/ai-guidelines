# AI Guidelines — Multi-Category AI Prompt & Instruction Repository

A collection of reusable, portable instruction packs for AI agents. Each top-level directory is a self-contained **category** — a complete set of prompts and procedures for a specific domain.

## Categories

| Category | Description |
|----------|-------------|
| `it-support/` | Role-based instructions for AI coding agents — covers design, implementation, testing, debugging, and task management |

## Quick Start

```bash
git clone {REPO_URL} && ./ai-guidelines/bin/install.sh it-support ./.ai
```

## Install

The install script copies a category's contents into your target directory:

```bash
bin/install.sh <category> <target>
```

**Arguments:**
- `category` — name of the category directory (e.g., `it-support`)
- `target` — destination directory (created if it doesn't exist)

**Examples:**
```bash
bin/install.sh it-support ./.ai              # conventional .ai/ dir
bin/install.sh it-support ./prompts          # custom directory name
bin/install.sh it-support ../my-project/.ai  # relative path to another project
```

The script copies the category's subdirectories (e.g., `roles/`, `flows/`, `meta/`, `prd/`) directly into the target. Running it again upgrades the files while preserving your `prd/prd.md`.

## Repository Structure

```
ai-guidelines/
├── it-support/                         # Category: AI coding agent instructions
│   ├── roles/                          #   Role-specific procedures
│   │   ├── designer/                   #     Requirements and design
│   │   ├── coder/                      #     Implementation
│   │   ├── e2e-tester/                 #     End-to-end testing
│   │   ├── debugger/                   #     Investigation and diagnosis
│   │   └── manager/                    #     Task and workflow management
│   ├── flows/                          #   Multi-role workflows
│   ├── meta/                           #   Setup, discovery, audit tools
│   └── prd/                            #   Task tracking templates
├── bin/
│   └── install.sh                      # Category installer
└── README.md
```

## Manual Setup

If you prefer to set things up yourself:

```bash
# 1. Copy the category contents into your target directory
mkdir -p .ai
cp -r it-support/roles/ .ai/roles/
cp -r it-support/flows/ .ai/flows/
cp -r it-support/meta/  .ai/meta/
cp -r it-support/prd/   .ai/prd/

# 2. Set up your agent entry point and project-specific files
#    (varies by category — see the category's own docs for details)
```

## License

MIT License — see LICENSE file for details.
