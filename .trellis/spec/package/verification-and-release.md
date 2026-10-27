# Verification and Release Guidelines

> Quality verification commands, version synchronization rules, and Typst Universe release procedures.

---

## 1. Quality Gates & Verification Commands

All changes to `themes/ysu-beamer.typ` or template files must pass these compilation checks before committing or releasing:

### 1.1 Full Features Example Compilation

```bash
typst compile --root . examples/beamer-ysu.typ
```

**Why `--root .` is mandatory**:
`examples/beamer-ysu.typ` imports `/themes/ysu-beamer.typ` using a root-absolute path (`/themes/...`). Running `typst compile` without `--root .` will fail with an unresolved file import error.

### 1.2 Template Compilation

```bash
typst compile template/main.typ
```

Verifies syntax, styling, and package compatibility for the starter template.

---

## 2. Version Synchronization Checklist (Critical)

Typst packages do not use dynamic version resolution. A version bump requires strict, synchronized updates across **all** of the following locations:

| File | Exact Location | What to Verify |
|---|---|---|
| `typst.toml` | `[package] version` | Must match new version (e.g. `"0.2.0"`) |
| `template/main.typ` | `#import "@preview/simply-ysu-touying:..."` | Package import version must match `typst.toml` version |
| `README.md` | Quick start code block and `typst init` command | Version in `@preview/simply-ysu-touying:<ver>` |
| `README.zh.md` | 快速开始代码块与 `typst init` 命令行 | Version in `@preview/simply-ysu-touying:<ver>` |
| `docs/typst-packages-pr-structure.md` | Directory paths and command snippets | Target path `packages/preview/simply-ysu-touying/<ver>/` |

**Pre-commit version check**:
```bash
grep -n "simply-ysu-touying:" typst.toml template/main.typ README.md README.zh.md docs/typst-packages-pr-structure.md
```

All occurrences must match the exact target version.

---

## 3. Local Universe Simulation

Before submitting a PR to `typst/packages`, simulate package installation locally to ensure `typst init` and compilation work without registry access:

1. Create a temporary local package root directory:
   ```bash
   mkdir -p /tmp/typst-packages/preview/simply-ysu-touying/0.2.0
   ```
2. Copy release files into the destination:
   - `README.md`, `LICENSE`, `LICENSE-MIT-0.txt`
   - `typst.toml`, `lib.typ`, `thumbnail.png`
   - `template/` (containing `main.typ`)
   - `themes/` (containing `ysu-beamer.typ` and `assets/`)
3. Test package initialization and document compilation:
   ```bash
   typst init --package-path /tmp/typst-packages @preview/simply-ysu-touying:0.2.0 test-presentation
   typst compile --package-path /tmp/typst-packages test-presentation/main.typ
   ```
4. Verify `test-presentation/main.pdf` renders without missing fonts or broken asset links.

---

## 4. Release Checklist for Typst Universe PR

When preparing a PR against `github.com/typst/packages`:

- [ ] `typst.toml` version matches all docs and templates.
- [ ] `thumbnail.png` has no references inside any package code.
- [ ] No extraneous files (such as `docs/`, `examples/`, `ASSETS.md`, `README.zh.md`, or hidden files) are bundled.
- [ ] PR description mentions asset provenance from `vis.ysu.edu.cn` and non-SPDX trademark boundary per `ASSETS.md`.
- [ ] Both `LICENSE` (MIT) and `LICENSE-MIT-0.txt` (MIT-0) are preserved.
