# Assets and Licensing

> Guidelines for managing university brand assets, source provenance, and legal licensing boundaries.

---

## 1. Packaged Brand Assets

All runtime visual assets are placed in `themes/assets/`:

- `ysu-seal.png`: Packaged seal graphic for light backgrounds.
- `ysu-seal-white.png`: White monochrome seal variant for dark backgrounds.
- `ysu-wordmark-only.png`: Wordmark graphic for light backgrounds.
- `ysu-wordmark-only-white.png`: White monochrome wordmark variant for dark headers.
- `ysu-watermark.png`: Subdued, low-contrast watermark for slide backgrounds.

---

## 2. Source Provenance & Transformation

All brand assets originate from official, publicly accessible Yanshan University materials:

- Yanshan University VIS portal: <https://vis.ysu.edu.cn/>
- Visual Identity package: <https://vis.ysu.edu.cn/download/ysuvi.zip>
- Public university website: <https://www.ysu.edu.cn/>

### Transformations Applied for Package Runtime

The repository does not redistribute the full upstream VIS archive. Instead, it prepares only the minimal runtime assets:
1. Isolating the seal and wordmark into high-resolution transparent PNGs.
2. Generating white variants for high contrast on dark headers (`primary-dark`).
3. Generating a subdued watermark variant for non-intrusive background placement.
4. Cropping and optimizing PNG file sizes to prevent package bloat.

---

## 3. Legal Licensing Boundary (Inviolable)

`typst.toml` states `license = "MIT AND MIT-0"`. However, a strict legal boundary applies:

1. **Software License (MIT)**: Covers the Typst source code, functions, layouts, and documentation under `LICENSE` (QuadnucYard and Geekyhang copyright).
2. **Template Starter License (MIT-0)**: Covers the starter code in `template/main.typ` under `LICENSE-MIT-0.txt` so consumers can freely use slides without attribution requirements.
3. **Institutional Identity Assets (Excluded from MIT/MIT-0)**:
   - The files under `themes/assets/ysu-*` remain the intellectual property and visual marks of Yanshan University.
   - They are **not** relicensed under MIT or MIT-0.
   - Downstream use of university trademarks and marks is subject to university identity guidelines and applicable laws.

---

## 4. `ASSETS.md` Authority

- `ASSETS.md` at repository root is the **single source of truth** for asset provenance, transformation history, licensing boundaries, and reviewer notes.
- Whenever an asset is updated or replaced, `ASSETS.md` must be updated in tandem.
- `ASSETS.md` is excluded from the published package (`exclude = [...]` in `typst.toml`) because it is a repository-side review document.

---

## 5. Reviewer Context for Typst Universe

When submitting PRs to `typst/packages`:
- State why `themes/assets/ysu-*` are bundled (required for out-of-the-box template rendering).
- Reference the provenance from public university VIS downloads.
- Note that brand assets are outside the SPDX software license scope.
- If reviewers require strict redistribution permissions, follow the contingency plan: replace or remove the branded assets before resubmission.

---

## 6. Forbidden Operations

- **Never** add unapproved external images, fonts, or third-party assets to `themes/assets/`.
- **Never** replace clean PNG assets with bloated SVGs or uncompressed scans.
- **Never** remove the copyright attribution notices from `LICENSE` or `LICENSE-MIT-0.txt`.
