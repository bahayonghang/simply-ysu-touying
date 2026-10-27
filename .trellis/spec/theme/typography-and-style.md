# Typography and Style

> Design system, color specifications, and Chinese academic typography conventions for `themes/ysu-beamer.typ`.

---

## 1. Typography Standards

Academic presentations require sharp contrast, legible font hierarchy, and proper Chinese punctuation and justification.

### 1.1 Font Cascade & Sizing

The document baseline is set in `ysu-theme`'s `init` method:

```typ
set text(
  size: 22pt,
  font: (
    "Times New Roman",
    "KaiTi",
    "STKaiti",
    "LXGW WenKai",
    "Microsoft YaHei",
    "Arial",
  ),
)
```

- **English & Numbers**: Prefers `Times New Roman` for academic formality, falling back to `Arial` if specified.
- **Chinese**: Falls back through Kaiti variants (`KaiTi`, `STKaiti`, `LXGW WenKai`) for clear academic reading, with `Microsoft YaHei` as sans-serif fallback.

### 1.2 Chinese Typesetting Rules

1. **Language tagging**: `set text(lang: "zh")` ensures correct quotation marks (`“”`), full-width punctuation, and hyphenation rules.
2. **Paragraph justification**: `set par(justify: true)` aligns Chinese character grids across presentation lines.
3. **Paragraph spacing**: `set block(spacing: 0.8em)` creates clean rhythmic vertical flow.

### 1.3 Chinese Fake Bold (`cuti`)

Traditional Chinese fonts such as KaiTi typically only include a regular weight (400). Standard `weight: "bold"` or `*粗体*` fails to render visibly on many systems without a bold font cut.

The theme integrates `@preview/cuti:0.4.0`:

```typ
#import "@preview/cuti:0.4.0": show-cn-fakebold
...
show: show-cn-fakebold
show strong: it => text(weight: "bold", it)
```

**Rule**: All new text components or slides must inherit this show rule. Never override `show strong` with pure color highlighting alone without preserving bold weight.

---

## 2. Heading & Caption Styling

- **Level 1 (`= 标题`)**: Generates a full section divider page (`new-section-slide`).
- **Level 2 (`== 标题`)**: Represents slide titles in content pages; captured in header pills.
- **Level 3 (`=== 标题`)**: Styled with `self.colors.primary` for subsection emphasis.
- **Level 4 (`==== 标题`)**: Styled with `self.colors.primary-dark` for sub-clause emphasis.
- **Figure Caption**: `show figure.caption: set text(size: 0.62em)`.
- **Table Caption**: Placed on top: `show figure.where(kind: table): set figure.caption(position: top)`.
- **Footnote**: Set to `size: 0.6em`.

---

## 3. Yanshan University Blue Color System

The color palette is registered via `config-colors(...)` in `themes/ysu-beamer.typ` and accessed through `self.colors.<token>`.

### 3.1 Primary Brand Palette (YSU Blue)

| Token | Hex Value | Semantic Usage |
|---|---|---|
| `primary` | `#2B69C1` | University blue: active borders, section pills, alert text, gradients |
| `primary-light` | `#78A4E7` | Light border strokes for cards and active outline cards |
| `primary-lighter` | `#DCE8FA` | Light blue background for active outline items and progress bar inactive fill |
| `primary-lightest` | `#F6F9FF` | Ultra-light tinted background for `#tblock` body and title metadata boxes |
| `primary-dark` | `#1F4F94` | Dark blue for `#tblock` headers, top nav bar, and footer author cell |
| `primary-darker` | `#163A70` | Deep blue for main titles and high-contrast section headers |
| `primary-darkest` | `#102744` | Darkest blue for title-slide title and section title text |

### 3.2 Secondary & Tertiary Accents

| Token | Hex Value | Semantic Usage |
|---|---|---|
| `secondary` | `#173A72` | Deep navy: slide number footer background, progress bar fill |
| `secondary-light` | `#4F78B9` | Medium accent blue |
| `secondary-lighter` | `#DFE9FA` | Pale secondary wash |
| `tertiary` | `#4D88D6` | Vibrant cyan-blue for decorative divider gradients |

### 3.3 Neutrals

| Token | Hex Value | Semantic Usage |
|---|---|---|
| `neutral-lightest` | `#FFFFFF` | Slide background, pure white text in dark headers/pills |
| `neutral-lighter` | `#E8EDF6` | Light gray-blue border/separator tone |
| `neutral-light` | `#A3AEC2` | Subdued borders and secondary hints |
| `neutral-dark` | `#344760` | Body text secondary tone |
| `neutral-darker` | `#22344B` | High-contrast body text |
| `neutral-darkest` | `#162234` | Primary high-contrast body text for cards and metadata boxes |

---

## 4. UI Elements & Accents

### 4.1 Card Blocks (`#tblock`)

The signature card component consists of 3 vertical layers:
1. **Title Header**: `fill: self.colors.primary-dark`, top radius `7pt`, bold white text.
2. **Gradient Divider**: 4pt height `gradient.linear(self.colors.primary-dark, self.colors.primary-lighter, angle: 90deg)`.
3. **Content Body**: `fill: self.colors.primary-lightest`, stroke `0.8pt` with `self.colors.primary-light`, bottom radius `7pt`.

### 4.2 List Markers

List markers use a custom radial gradient bullet:

```typ
set list(marker: box(
  width: 0.55em,
  place(
    dy: 0.08em,
    circle(
      fill: gradient.radial(self.colors.primary-lightest, self.colors.primary),
      radius: 0.16em,
    ),
  ),
))
```

### 4.3 Divider Lines

Section headers and outline banners use a consistent 3pt to 4pt horizontal gradient line:

```typ
rect(
  width: 100%,
  height: 4pt,
  fill: gradient.linear(self.colors.primary, self.colors.tertiary),
)
```

### 4.4 Watermark (`ysu-watermark.png`)

- Displayed on content slides (if `watermark: true`) and section/ending slides.
- Placed at right-bottom corner with offset `(dx: -0.8em, dy: -0.8em)` (or `-0.9em`).
- Default width: `32%` (content), `28%` (section slide), `26%` (ending slide).
- Must always remain low-contrast to avoid hindering foreground slide text readability.

---

## 5. Anti-patterns & Style Violations

- **Direct Hardcoded Hex Colors**: Avoid hardcoding `#2B69C1` inside slide layouts or components. Always reference `self.colors.primary` so custom palette overrides work cleanly.
- **Arbitrary Font Declarations**: Do not set one-off fonts like `font: "SimSun"` in individual slides without adding fallbacks; this breaks cross-platform rendering (Windows/Linux/macOS).
- **Overriding Cuti Without Testing**: Never disable or omit `show-cn-fakebold` in custom slide settings, as KaiTi bold headings will silently turn into thin text on standard Linux/Typst environments.
- **Ignoring Low-Contrast Ratios**: Watermarks and decorative elements must not obstruct text reading; text inside `tblock` must use `neutral-darkest` or `neutral-darker` over `primary-lightest`.
