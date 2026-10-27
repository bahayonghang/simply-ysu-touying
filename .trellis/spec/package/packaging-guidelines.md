# Packaging Guidelines

> Package configuration, file exclusion, template architecture, and Typst Universe submission rules.

---

## 1. Package Manifest (`typst.toml`)

`typst.toml` is the root metadata file required by Typst Universe:

```toml
[package]
name = "simply-ysu-touying"
version = "0.2.0"
entrypoint = "lib.typ"
compiler = "0.14.0"
authors = ["Geekyhang <@bahayonghang>"]
license = "MIT AND MIT-0"
description = "Yanshan University slides with Touying."
repository = "https://github.com/bahayonghang/simply-ysu-touying"
keywords = [
  "slides",
  "presentation",
  "touying",
  "beamer",
  "ysu",
  "yanshan-university",
]
categories = ["presentation"]
exclude = ["docs", "examples", "ASSETS.md", "README.zh.md", ".*"]

[template]
path = "template"
entrypoint = "main.typ"
thumbnail = "thumbnail.png"
```

### Critical Manifest Rules

1. **`compiler` baseline**: Kept at `0.14.0` (or lowest verified Typst release support).
2. **`license` field**: Must be an exact valid SPDX license expression. The repo uses `"MIT AND MIT-0"`.
3. **`exclude` rule**:
   ```toml
   exclude = ["docs", "examples", "ASSETS.md", "README.zh.md", ".*"]
   ```
   Anything not strictly needed to compile the template and import the theme MUST be excluded to minimize the package tarball size and respect review constraints.
4. **`thumbnail` rule**:
   `thumbnail = "thumbnail.png"` points to the preview thumbnail for the package registry.
   **Crucial Rule**: `thumbnail.png` must NOT be referenced anywhere in `.typ` files. Referencing it will trigger an automated rejection during Typst Universe package review.

---

## 2. Template Structure (`template/`)

When a user initializes a presentation with `typst init @preview/simply-ysu-touying:0.2.0 my-slides`, Typst extracts `template/main.typ`.

### 2.1 File Contract

- `template/main.typ` must be a self-contained, minimal starter slide deck.
- The top of `template/main.typ` must carry the MIT-0 attribution-free notice:
  ```typ
  // The starter content in this template file is additionally available under
  // MIT No Attribution. See LICENSE-MIT-0.txt and README.md for details.
  ```
- The import must import the published package namespace:
  ```typ
  #import "@preview/simply-ysu-touying:0.2.0": *
  ```
- Do not import local relative paths like `"../lib.typ"` inside `template/main.typ`, because end users run `template/main.typ` in isolated user workspaces.

---

## 3. Package Bundle Shape

Only the following files belong in the distributed release package:

```text
simply-ysu-touying/
├── README.md
├── LICENSE
├── LICENSE-MIT-0.txt
├── typst.toml
├── lib.typ
├── thumbnail.png
├── template/
│   ├── main.typ
│   └── main.pdf (precompiled preview)
└── themes/
    ├── ysu-beamer.typ
    └── assets/
        ├── ysu-seal.png
        ├── ysu-seal-white.png
        ├── ysu-watermark.png
        ├── ysu-wordmark-only.png
        └── ysu-wordmark-only-white.png
```

All other files (`docs/`, `examples/`, `ASSETS.md`, `README.zh.md`, `.git*`, `.trellis*`) are repository-side maintenance files excluded via `exclude` in `typst.toml`.
