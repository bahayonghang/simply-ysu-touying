# Typography and Style

> Design tokens, typography and component conventions of the YSU defense theme. Source of truth: `themes/tokens.typ` and `themes/components.typ`.
>
> Status: 0.2.0 draft — the release task does the final review.

---

## 1. Color Tokens (`tokens.typ`)

Values follow the LaTeX defense deck (`ysu-defense-modern.sty`, theme v3).

| Token | Hex | Usage |
|---|---|---|
| `ysu-navy` | `#1F296A` | Brand color: headline, rules, title bars, `strong`, list markers |
| `ysu-red` | `#B42318` | Single accent: short header rule, `key`, problem labels, `alert` |
| `ysu-ink` | `#1B1E2B` | Body text |
| `ysu-muted` | `#5A6072` | Captions, footer, secondary text |
| `ysu-tint` | `#F2F4F9` | Box grounds |
| `ysu-line` | `#D9DCE5` | Hairlines and box borders |
| `ysu-base` | `#A9B1C9` | Base bar, inactive progress |
| `ysu-night` | `#0E1433` | Dark structure pages, screen frames |
| `ysu-night-dot` | `#3A4370` | Screen-frame dots |
| `ysu-kicker` / `ysu-faint` | white 78% / 55% over navy | Secondary text on navy |

`mix(c, p, base: white)` is xcolor's `c!p!base`. Derive tints with it instead of new hex literals.

Gradients: `grad-head` (title bars), `grad-bar` (conclude bar), `grad-key`, `grad-page` (page pill), `grad-diag` (cover / thanks), `grad-opener` (radial, chapter opener). A radial gradient's last stop must be `100%`.

`config-colors` mirrors the tokens onto touying's names (`primary`, `secondary`, `neutral-*`), but theme code reads the tokens directly.

---

## 2. Fonts

```typ
#let font-latin = ("Arial",)
#let font-cjk = ("Source Han Sans", "Noto Sans SC", "Microsoft YaHei")
```

- Slides stay sans-serif. YSU 学位论文撰写规范（2024）§3.1（正文宋体、标题黑体、西文与阿拉伯数字 Times New Roman）约束纸本学位论文，不直接套到投影片。
- CJK order: Source Han Sans（思源黑体；Typst 族名不带 SC），then the same design as Noto Sans SC, then Microsoft YaHei. All three have real bold. Do not append SimHei or KaiTi.
- Latin is Arial, the face already paired with 黑体 on Windows academic machines. Do not put an uninstalled family such as Source Sans 3 in the default list: Typst warns for every unknown family even when a later face is used. Users who install Source Sans 3 may pass it as the first `font.latin` entry.
- Latin faces are added with `covers: "latin-in-cjk"` (`_font-stack`), so CJK punctuation falls through to the CJK face.
- Users override with `ysu-theme(font: (latin: …, cjk: …))`.
- `heavy = 900` for the cover title and opener number (Source Han Sans Heavy). Faces without 900 fall back to bold.
- `show raw` uses `"DejaVu Sans Mono"` (bundled with Typst) plus the CJK stack.

**No fake bold.** `cuti` was removed in 0.2.0: the CJK stack is sans-serif with real bold weights. Do not reintroduce KaiTi-style fonts that need fake bold.

## 3. Sizes & Rhythm

| Element | Size |
|---|---|
| Base text | 10pt, `leading: 0.75em`, `par.spacing: 0.9em` |
| Lists at full frame width | 12pt, item gap 0.9em (via `layout`; lists inside columns keep 10pt) |
| Headline | 14pt bold navy |
| Kicker / breadcrumb | 6.5pt |
| Captions / equation numbers | 8pt muted |
| Footnotes | 7pt |

List markers: navy squares (0.36em level 1, 0.26em level 2). Enum numbers are bold navy two-digit (`01`).

---

## 4. Emphasis

| Function | Meaning | Rendering |
|---|---|---|
| `*text*` / `hl[...]` | Key term | navy bold (`hl` = `box(strong(...))`, no line breaks) |
| `key[...]` | The page's single key conclusion | red bold |
| `alert[...]` | touying alert | red bold |

On dark grounds (opener, cover right panel, conclude bar) components set `show strong: set text(fill: white)`, so `hl` stays readable without a separate API. Use at most one `key` per page.

---

## 5. Component Catalogue (`components.typ`)

| Group | Components |
|---|---|
| Labels | `tag(kind: "navy"\|"red"\|"line")`, `pill`, `tab-pill`, `edge-label(red:)`, `icon-disc` |
| Bars | `conclude(label:, red-label:, pill:, bleed:)`, `base-bar`, `section-bar(icon:)` — full-bleed via `outset: (x: 1cm)` |
| Boxes | `title-box(icon:, title:, aside:, width:, height:, body-size:)`, `group-box(label:, red:)`, `sub-box`, `dash-box`, `label-row(label:, dashed:)`, `red-frame(label:, center:)`, `card(accent:)`, `side-card(label:)`, `paper-box` |
| Flow | `block-arrow(dir: "right"\|"down")` |
| Numbers | `points(start:, rule:)`, `kpi(label:, value:, basis:, key:)` |
| Figures / math / tables | `fig-caption`, `figure-box(caption:)`, `eq-number`, `eq-block(number:, note:)`, `reading-card`, `screen-frame(title:)`, `result-table(header:, rows:, mark:)` |
| Compatibility | `tblock(title:)` → alias of `title-box` (0.x API) |

Conventions:

- Radii are small (≤ 0.2cm); borders are `0.5–0.6pt + ysu-line`; title bars use `grad-head`.
- Red marks a *problem* or the single *key* point; navy marks structure. Never use red for decoration.
- `result-table` marks the proposed method's rows with `mark: (index, …)` (tint ground, bold).
- Equal-height left label + right body rows go through `_equal-row`.

---

## 6. Brand Marks & Watermark

- `seal(white:)`, `wordmark(white:)`, `logo(white:, height:)` are the only entry points to `themes/assets/`.
- Content headers show a 0.42cm seal at the top right. Structure pages show the white seal as a 9%-opacity watermark via `_seal-panel`.
- `ysu-watermark.png` is no longer drawn on content pages (the defense layout has no corner watermark); it stays in `assets/` as an approved asset.
- Do not resize or recolor the marks beyond what `ASSETS.md` allows; do not add bitmaps.

---

## 7. Anti-patterns

- Hex literals in slides or components — use tokens or `mix()`.
- One-off `font:` without fallbacks — use `font-cjk` / `font-latin`.
- More than one `key` per page, or red used as decoration.
- `hl` inside a dark box without the white `strong` rule — navy on night is unreadable.
- Overflowing structure-page text at 4:3 — always compile with `--input ratio=4-3` after layout changes.
