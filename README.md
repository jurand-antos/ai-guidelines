# AI Guidelines — Multi-Category AI Prompt & Instruction Repository

A collection of reusable, portable instruction packs for AI agents. Each top-level directory is a self-contained **category** — a complete set of prompts and procedures for a specific domain.

## Categories

| Category | Description | Docs |
|----------|-------------|------|
| `it-support/` | Role-based instructions for AI coding agents | [docs/it-support.md](docs/it-support.md) |

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

The script copies the category's subdirectories directly into the target. Running it again upgrades the files while preserving your `prd/prd.md`.

## Repository Structure

```
ai-guidelines/
├── it-support/          # Category: AI coding agent instructions
├── docs/                # Category documentation
├── bin/
│   └── install.sh       # Category installer
├── CHANGELOG.md
└── README.md
```

## License

MIT License — see LICENSE file for details.
