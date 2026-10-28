# Package & Distribution Guidelines

> Packaging, asset boundaries, licensing rules, and quality verification standards for `simply-ysu-touying`.

---

## Overview

The `package` layer governs repository packaging, Typst Universe metadata, licensing boundaries, brand asset usage, and release verification.

Because `simply-ysu-touying` is published on Typst Universe as `@preview/simply-ysu-touying`, packaging rules must comply with official Typst package requirements, keep archive sizes minimal, maintain strict license boundaries, and ensure flawless out-of-the-box rendering.

---

## Guidelines Index

| Guide | Description | Status |
|-------|-------------|--------|
| [Packaging Guidelines](./packaging-guidelines.md) | `typst.toml` manifest specification, exclusion rules, template layout, and thumbnail rules | Active |
| [Assets and Licensing](./assets-and-licensing.md) | Visual identity assets, conversion provenance, and SPDX `MIT AND MIT-0` legal boundaries | Active |
| [Verification and Release](./verification-and-release.md) | Compilation checks, version synchronization checklist, Universe submission workflow | Active |

---

## Key Files

- `typst.toml`: Typst package manifest containing metadata, compiler minimum version (`0.15.1`), template configuration, and exclude filters.
- `template/main.typ`: Entrypoint for `typst init` starter presentation, licensed under MIT-0.
- `thumbnail.png`: Typst Universe catalog preview image (must not be referenced in package code).
- `ASSETS.md`: Single source of truth for university visual asset provenance, transformations, and review context.
- `LICENSE` & `LICENSE-MIT-0.txt`: Software license texts.
- `docs/typst-packages-pr-structure.md`: Release packaging and PR directory mapping.
