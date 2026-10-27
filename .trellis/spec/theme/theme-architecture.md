# Theme Architecture

> Architectural patterns and implementation conventions for `themes/ysu-beamer.typ`.

---

## 1. Package Entrypoint & Re-exports

The public API is consolidated in `lib.typ`:

```typ
// lib.typ
#import "@preview/touying:0.6.3": *
#import "themes/ysu-beamer.typ": *
```

Any symbol added to `themes/ysu-beamer.typ` that should be accessible to end users is automatically exposed through `lib.typ`. Internal helper functions must be prefixed with an underscore (e.g. `_wordmark`, `_emblem`, `_watermark`, `_nav-bar`, `_tblock`).

---

## 2. Theme Initialization Pipeline (`ysu-theme`)

The theme is activated via a show rule in consumer documents:

```typ
#show: ysu-theme.with(
  aspect-ratio: "16-9",          // "16-9" (default) or "4-3"
  align: top,                    // slide content vertical alignment
  progress-bar: true,            // toggle top progress bar
  watermark: true,               // toggle bottom-right watermark
  config-info(...),
)
```

Inside `themes/ysu-beamer.typ`, `ysu-theme` delegates to `touying-slides.with(...)` through configured pipelines:

1. **`config-page`**: Sets presentation paper size (`"presentation-" + aspect-ratio`), white background, page margins (`(top: 4.2em, bottom: 0.8em, x: 2.2em)`), and optional right-bottom background watermark.
2. **`config-common`**: Registers default `slide-fn: slide`, `new-section-slide-fn: new-section-slide.with(numbered: false)`, and disables `show-strong-with-alert`.
3. **`config-methods`**: Configures document-level init show rules (fonts, line spacing, list bullets, caption styling, Chinese language tags, and fake bold) and `alert: utils.alert-with-primary-color`.
4. **`config-colors`**: Registers the complete YSU blue palette.
5. **`config-store`**: Stores theme configuration options (`align`, `progress-bar`, `footer-columns`, `footer-a` through `footer-d`) accessible via `self.store`.

---

## 3. Slide Wrappers & Function Contracts

All slide generators in `themes/ysu-beamer.typ` must follow Touying's wrapper conventions.

### 3.1 Content Slide (`slide`)

Standard content slides support arbitrary multi-column layouts via `composer` and sequential unveiling via `#pause`:

```typ
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  align: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let slide-align = if align == auto { self.store.align } else { align }
  let header(self) = { ... }
  let footer(self) = { ... }
  let self = utils.merge-dicts(
    self,
    config-page(header: header, footer: footer),
  )
  let new-setting = body => {
    show: std.align.with(slide-align)
    show: setting
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})
```

### 3.2 Title Slide (`title-slide`)

- Freezes slide counter: `config-common(freeze-slide-counter: true)`
- Suppresses header/footer: `config-page(header: none, footer: none, background: none)`
- Automatically handles single author string vs array of authors, laying out authors in up to 3 columns.
- Displays university wordmark, seal emblem, title, subtitle, metadata box, and optional `extra` content.

### 3.3 Outline Slide (`outline-slide`)

- Uses `query(selector(heading.where(level: 1)))` within a `context` block to dynamically enumerate sections.
- Compares `current.location().page() == section.location().page()` to highlight the currently active section.
- Encloses section links in rounded capsules with `link(section.location(), section.body)`.

### 3.4 Section Transition Slide (`new-section-slide`)

- Invoked automatically whenever a Level 1 heading (`= Section Name`) appears.
- Renders school wordmark and emblem, a linear gradient accent divider, and the heading text via `utils.display-current-heading(level: level, numbered: numbered, style: auto)`.
- Includes subdued watermark at bottom right.

### 3.5 Ending Slide (`ending-slide`)

- Freezes slide counter and suppresses headers/footers.
- Centers emblem, wordmark, primary blue button-like title (default: `[谢谢！]`), and optional speaker contact or Q&A body.

---

## 4. Components & Helpers (`#tblock`)

Reusable theme blocks that need access to theme colors or Touying state must use `touying-fn-wrapper`:

```typ
#let _tblock(self: none, title: none, it) = {
  grid(
    columns: 1,
    row-gutter: 0pt,
    block(
      fill: self.colors.primary-dark,
      width: 100%,
      radius: (top: 7pt),
      inset: (top: 0.4em, bottom: 0.3em, x: 0.55em),
      text(fill: self.colors.neutral-lightest, weight: "bold", title),
    ),
    rect(
      fill: gradient.linear(self.colors.primary-dark, self.colors.primary-lighter, angle: 90deg),
      width: 100%,
      height: 4pt,
    ),
    block(
      fill: self.colors.primary-lightest,
      width: 100%,
      radius: (bottom: 7pt),
      stroke: (paint: self.colors.primary-light, thickness: 0.8pt),
      inset: (top: 0.45em, bottom: 0.55em, x: 0.6em),
      it,
    ),
  )
}

#let tblock(title: none, it) = touying-fn-wrapper(_tblock.with(title: title, it))
```

---

## 5. Navigation & Header / Footer Architecture

### 5.1 Dynamic Header

The top header is constructed as a 3-row `grid`:
1. **Dark Blue Top Bar**: Contains `_nav-bar(self: self)`, the white wordmark, and the white emblem.
2. **Progress Bar**: Rendered with `components.progress-bar(height: 2pt, self.colors.secondary, self.colors.primary-lighter)` when `self.store.progress-bar` is enabled.
3. **Current Title Pill**: Displays the current Level 2 heading (falling back to Level 1) inside a bottom-rounded gradient block (`self.colors.primary` to `self.colors.primary-dark`).

### 5.2 Header Navigation Pills (`_nav-bar`)

Inside `_nav-bar`, Level 1 headings are queried in a `context` block. The active section is given a translucent white background pill (`white.transparentize(84%)`), while inactive sections remain transparent with dimmed text (`white.transparentize(35%)`).

### 5.3 Modular 4-Column Footer

The footer divides the bottom margin into 4 configurable cells:
- `footer-a` (default: author name) on `primary-dark`
- `footer-b` (default: presentation date via `utils.display-info-date(self)`) on `primary-dark`
- `footer-c` (default: short-title or title) on `primary`
- `footer-d` (default: page counter `current / last`) on `secondary`

Column widths default to `(20%, 18%, 1fr, 5em)` and can be overridden via `footer-columns` in `ysu-theme`.

---

## 6. Anti-patterns & Forbidden Practices

| Anti-pattern | Why Forbidden | Proper Pattern |
|---|---|---|
| Directly writing `#page(...)` inside slide content | Bypasses Touying page counter, header/footer configuration, and animations | Use `touying-slide(...)` or `slide(...)` |
| Calling `query(...)` or `utils.current-heading` without `context` | Fails compilation in modern Typst (0.11+) | Always wrap heading inspection inside `context { ... }` |
| Mutating `self` by direct reassignment without `utils.merge-dicts` | Corrupts nested Touying configuration states | Use `utils.merge-dicts(self, config-page(...))` |
| Hardcoding dimensions like `width: 841.89pt` | Breaks presentation scaling when aspect ratio changes between `16-9` and `4-3` | Use relative units (`100%`, `1fr`, `em`) and `aspect-ratio` parameter |
| Exporting helper functions without `_` prefix | Pollutes the package namespace when users `#import ...: *` | Prefix private helpers with `_` (e.g. `_header-title`) |
