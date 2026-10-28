# `typst/packages` PR Structure

This note records the release-oriented directory layout and checklist to submit this template to Typst Universe.

## Target path in `typst/packages`

```text
packages/
  preview/
    simply-ysu-touying/
      0.2.0/
```

## Files to submit

```text
packages/
  preview/
    simply-ysu-touying/
      0.2.0/
        README.md
        LICENSE
        LICENSE-MIT-0.txt
        typst.toml
        lib.typ
        thumbnail.png
        template/
          main.typ
          main.pdf
        themes/
          ysu-beamer.typ
          components.typ
          tokens.typ
          assets/
            ysu-seal.png
            ysu-seal-white.png
            ysu-watermark.png
            ysu-wordmark-only.png
            ysu-wordmark-only-white.png
```

## Repository-side notes not included in the package body

```text
README.zh.md
ASSETS.md
docs/
examples/
```

These files remain useful during submission review, but they stay outside the published package body.
The `exclude` section in `typst.toml` should continue to keep them out of the packaged release.

## Local preview testing

Mirror the `preview/simply-ysu-touying/0.2.0/` layout under a local package root, then run `typst init` and `typst compile` against it. From the repository root (bash):

```bash
root=.tmp/pkg
dst=$root/preview/simply-ysu-touying/0.2.0
rm -rf "$root" && mkdir -p "$dst"
cp -r README.md LICENSE LICENSE-MIT-0.txt typst.toml lib.typ thumbnail.png themes template "$dst"/
typst init --package-path "$root" @preview/simply-ysu-touying:0.2.0 .tmp/pkg-test
typst compile --package-path "$root" .tmp/pkg-test/main.typ
```

The same steps in PowerShell:

```powershell
$root = ".tmp/pkg"
$dst = "$root/preview/simply-ysu-touying/0.2.0"
Remove-Item -Recurse -Force $root -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force $dst | Out-Null
Copy-Item README.md, LICENSE, LICENSE-MIT-0.txt, typst.toml, lib.typ, thumbnail.png $dst
Copy-Item -Recurse themes, template $dst
typst init --package-path $root @preview/simply-ysu-touying:0.2.0 .tmp/pkg-test
typst compile --package-path $root .tmp/pkg-test/main.typ
```

## Submission notes

- Keep the submitted package minimal and release-focused.
- If any published file changes after submission, bump the package version before sending a new PR.
- Use the confirmed package name `simply-ysu-touying` consistently in release artifacts and submission notes.
- `lib.typ` remains the package entrypoint.
- `template/main.typ` is used by `typst init`.
- `thumbnail.png` is the package preview image and must not be referenced by package files.
- The package keeps only the `themes/assets/ysu-*` files; the detailed provenance, transformations, and reuse boundary are documented in repository-side `ASSETS.md`.
- In the Typst Universe PR, include a short reviewer note that covers:
  - `LICENSE` preserves the upstream QuadnucYard notice and the current Geekyhang notice for the MIT-licensed source files in this adapted repository;
  - `template/main.typ` starter content is additionally available under MIT-0 via `LICENSE-MIT-0.txt`;
  - `themes/assets/ysu-*` come from public Yanshan University visual materials, were converted into theme-ready PNG derivatives, and are outside the SPDX software-license scope; and
  - README screenshots use raw GitHub URLs pinned to a commit, not `main`. Links to files kept out of the package (`README.zh.md`, `ASSETS.md`) must be commit permalinks too; relative links fail the package check.
- 0.2.0 is a breaking release relative to 0.1.x; the README section "Migrating from 0.1.x" lists the changes.
- If you cannot justify redistribution of the branded assets to reviewers, stop and replace/remove those assets before submission.
