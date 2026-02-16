# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.2] - 2026-02-16

### Changed
- Refined `it-support/roles/manager/update-ticket.md` comment templates, action marks, and scenario phrasing for clearer ticket updates

## [0.1.1] - 2026-02-16

### Changed
- Moved category-specific documentation from README.md to `docs/it-support.md`
- Slimmed down README.md to repo-level content only with link to category docs

## [0.1.0] - 2026-02-16

### Added
- Multi-category repo structure — each top-level directory is a self-contained instruction pack
- Category-based install script: `bin/install.sh <category> <target>`
- Release flow for conventional commits, changelog, and version tagging (`.ai/release.md`)
- CHANGELOG.md following Keep a Changelog convention
- Dev tooling: `bin/setup-ai` for local symlink setup

### Changed
- Moved all product files into `it-support/` category directory
- Rewritten README for multi-category structure
- Updated `.ai/guidelines.md` with category awareness
- Updated `.ai/project/context.md` and `.ai/meta/structure.md` for category-based layout
- Install script no longer creates agent entry points (CLAUDE.md, AGENTS.md, .junie/) or modifies .gitignore

### Removed
- Root-level agent entry point files (CLAUDE.md, AGENTS.md, .junie/guidelines.md) — replaced with symlinks for dev use only
