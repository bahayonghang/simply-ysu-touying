# Theme Architecture

> Architectural patterns and implementation conventions for the YSU defense theme (`themes/tokens.typ`, `themes/components.typ`, `themes/ysu-beamer.typ`).
>
> Status: 1.0.0 draft — written with the `10-27-theme-core` task; the release task (`10-27-release-1-0-0`) does the final review.

---

## 1. Module Split & Re-exports

The theme is three modules with one-way imports:

```text
tokens.typ      colors, gradients, fonts, brand marks (no touying import)
   ↑
components.typ  content components (hl, title-box, conclude, ...); imports tokens only
   ↑
ysu-beamer.typ  ysu-theme, slide wrappers, header/footer, page markers;
                imports touying, tokens, components with `*`
```

`lib.typ` re-exports touying and `themes/ysu-beamer.typ`, so every public symbol of all three modules reaches users through `#import "@preview/simply-ysu-touying:<ver>": *`.

Rules:

- Tokens and components never import `ysu-beamer.typ` (no cycles).
- Components are plain functions over content and tokens. They do **not** need `self` or `touying-fn-wrapper`; read tokens directly (`ysu-navy`, `grad-head`).
- Private helpers start with `_` (`_at`, `_on-page`, `_header`, `_equal-row`).
- Brand images are loaded only through `seal()`, `wordmark()`, `logo()` in `tokens.typ` (paths resolve relative to that file). `thumbnail.png` is never referenced.

---

## 2. Page Geometry

The page is a **literal 16cm × 9cm** (12cm × 9cm for `aspect-ratio: "4-3"`), not `presentation-16-9`. The LaTeX deck uses the same size, so its TikZ coordinates map 1:1 to `cm` and its font sizes to `pt`.

| Item | Value |
|---|---|
| Margins | `top: 1.75cm, bottom: 0.8cm, x: 1cm` |
| Header kicker / headline / rule | y = 0.33cm / 0.60cm / 1.30cm + (lines − 1)·17pt |
| Footer rule | H − 0.45cm |
| Headline width | `self.store.headline-width` = page width − 2.4cm |

Structure pages (cover, TOC, opener, thanks) use `margin: 0pt` (`_plain-page`) and draw everything with `place` through `_at(x, y, anchor: "nw"|"n"|…|"se", body)`, which measures `body` and anchors it like a TikZ node. `_base(body)` makes "sw"/"se" read as TikZ "base west"/"base east".

Hard-coded `cm` is correct here because the page size is fixed. When a layout depends on width, branch on `page.width` (16:9 vs 4:3) inside `context`, as `title-slide` and `new-section-slide` do.

---

## 3. Theme Initialization (`ysu-theme`)

```typ
#show: ysu-theme.with(
  aspect-ratio: "16-9",            // or "4-3"
  align: horizon,                  // default vertical alignment of content slides
  nav-labels: auto,                // short footer labels, one per chapter
  nav-full-labels: auto,           // long labels where room allows
  font: (latin: font-latin, cjk: font-cjk),
  config-info(
    title:, short-title:, author:, supervisor:, subject:, school:,
    date:, stage:, stage-en:,
  ),
)
```

Pipeline into `touying-slides`:

1. `config-page` — width/height above, white fill, header/footer `none` (both are drawn in the `background`, see §5).
2. `config-common` — `slide-fn: slide`, `new-section-slide-fn: new-section-slide`, `show-strong-with-alert: false`.
3. `config-methods(init:)` — text 10pt ink, fonts, `lang: "zh"`, list markers, `show strong`, `show raw`, captions (see typography spec). `alert` = red bold.
4. `config-colors` — maps tokens onto touying's names (`primary: ysu-navy`, `secondary: ysu-red`, …) for third-party touying components.
5. `config-store` — `align`, `nav-labels`, `nav-full-labels`, `headline-width`, `slide-title`.

`supervisor`, `subject`, `school`, `stage`, `stage-en` are extra `config-info` keys read from `self.info`; all are optional.

---

## 4. Slide Wrappers

### 4.1 Content slide (`slide`)

```typ
#let slide(config: (:), repeat: auto, setting: body => body, composer: auto,
           align: auto, title: auto, sub: none, takeaway: none, ..bodies)
```

- `== 二级标题` creates one automatically; `#slide(...)` is for `composer` columns or explicit `title`/`sub`/`takeaway`.
- Header and footer go into `config-page(background: …)`.
- `new-setting` inserts the `<ysu-page>` marker, any `sub`/`takeaway` arguments as markers, `v((lines − 1) * 17pt)` for multi-line headlines, then alignment.
- `#pause` / `#meanwhile` work as in touying; subslides share one page number.

### 4.2 Structure slides

| Function | Trigger | Notes |
|---|---|---|
| `title-slide(research-line: ((no:, icon:, label:), …))` | explicit | Left white / right night panel; 2×2 info grid at 16:9, stacked column at 4:3. Freezes the counter. |
| `outline-slide(title:, groups: ((from:, to:, tags:, icons:),))` | explicit | One row per level-1 heading; `groups` highlight a chapter range; groups beyond the chapter count are dropped. |
| `new-section-slide` | `= 标题` | Radial night ground, seal panel, big chapter number, question, keywords, outline from level-2 headings, bridge line, progress segments. Reads `<ysu-opener>`. |
| `ending-slide(title:, kicker:, recap: (…), ..bodies)` | explicit | Recap cards (`title`, `chapter`, `icon`, `body`, `tags`) or, without recap, centered seal + wordmark. |

Icons are **any content** the caller passes (`text(font: …, "◉")`, an image, a symbol). The package ships no icon dependency.

---

## 5. Page Markers & Header / Footer

Per-page data is passed as `metadata` with a label and read back by page:

| Marker | Set by | Read by |
|---|---|---|
| `<ysu-sub>` | `#sub[...]` | header breadcrumb |
| `<ysu-takeaway>` | `#takeaway[...]` | header headline |
| `<ysu-opener>` | `#chapter-opener(question:, keywords:, keyword-icons:, icon:, outline:, bridge:)` placed right after `= 标题` | `new-section-slide` |
| `<ysu-page>` | `slide` body | footer page pill |

`_on-page(label)` queries the label and keeps the last match on `here().page()`.

Header (`_header-parts`): with a takeaway, kicker = `title / sub` and headline = takeaway; otherwise kicker = sub and headline = title. Then the seal at the right, the rule, and the red 0.9cm × 3pt short rule.

Footer: rule, "author · stage", chapter navigation (`_nav-bar`, current chapter highlighted), page pill (`_page-pill`, `grad-page` parallelogram).

**Page counter gotcha:** the page `background` is evaluated before touying steps `slide-counter`, so reading the counter there lags by one. The pill reads `utils.slide-counter.at(mark.location())` at the `<ysu-page>` marker inside the body instead.

---

## 6. Anti-patterns

| Anti-pattern | Why | Instead |
|---|---|---|
| `#page(...)` inside slide content | Breaks the counter, background and markers | `slide(...)` or a structure-slide function |
| Reading `slide-counter` in header/background | Off by one (see §5) | Query the `<ysu-page>` marker |
| `query`/`here()` without `context` | Compile error | Wrap in `context` |
| Mutating `self` by reassignment | Corrupts nested config | `utils.merge-dicts(self, config-page(...))` |
| Positioning structure pages with flow `v()`/`h()` | Drifts from the deck geometry, overlaps at 4:3 | `_at(x, y, anchor:)` with `margin: 0pt` |
| Components importing `ysu-beamer.typ` or needing `self` | Import cycle, unnecessary coupling | Read tokens directly |
| Image with `opacity` | Typst images have none | `_seal-panel` overlay trick |
| Unprefixed helpers | Pollute `*` imports | `_name` |
