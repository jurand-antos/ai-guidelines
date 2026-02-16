# Release Flow

Procedure for committing changes and managing versions in this repo.

## When to Use

When the user asks to commit, release, or tag changes.

## Steps

### 1. Inspect changes

```bash
git status --porcelain
git diff --stat
```

Review every changed file to understand what was done.

### 2. Determine conventional commit type

Map the changes to **one primary** conventional commit type:

| Type | Meaning | Version bump |
|------|---------|-------------|
| `feat` | New feature or capability | minor (Y) |
| `fix` | Bug fix | patch (Z) |
| `docs` | Documentation only | patch (Z) |
| `refactor` | Code restructuring, no behavior change | patch (Z) |
| `chore` | Tooling, config, maintenance | patch (Z) |
| `style` | Formatting, whitespace | patch (Z) |
| `test` | Adding or fixing tests | patch (Z) |
| `build` | Build system, dependencies | patch (Z) |
| `ci` | CI/CD changes | patch (Z) |

**Breaking changes** (`!` suffix, e.g. `feat!:`) → major bump (X).

If changes span multiple types, pick the most significant one. Use scope when helpful: `feat(install):`, `docs(readme):`.

### 3. Determine next version

Get the latest version tag:

```bash
git tag --list 'v*' --sort=-version:refname | head -1
```

If no tags exist, the first version is `0.1.0`.

Calculate the next version from **X.Y.Z**:
- **Breaking change** → X+1.0.0
- **feat** → X.Y+1.0
- **Everything else** → X.Y.Z+1

### 4. Update CHANGELOG.md

Add a new entry **at the top** of the changelog (below the header), following [Keep a Changelog](https://keepachangelog.com/) format:

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- New features (maps to `feat`)

### Changed
- Changes to existing features (maps to `refactor`, `chore`, `style`, `build`, `ci`)

### Fixed
- Bug fixes (maps to `fix`)

### Removed
- Removed features or capabilities
```

Only include sections that apply. Each bullet should be a concise, human-readable description of the change.

### 5. Commit

Stage all changes **including CHANGELOG.md**, then commit:

```
<type>[!][optional scope]: <description>
```

The description should be lowercase, imperative, and concise. No period at the end.

### 6. Tag

```bash
git tag vX.Y.Z
```

The tag matches the version added to CHANGELOG.md, prefixed with `v`.

## Rules

- NEVER skip the CHANGELOG update
- NEVER commit without a tag when following this flow
- One version per commit — don't batch unrelated changes into one release
- The CHANGELOG is the source of truth for what changed and when
