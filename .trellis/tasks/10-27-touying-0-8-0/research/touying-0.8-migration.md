# Research: Touying 0.6.3 → 0.8.0 theme migration

- **Query**: What must this Touying 0.6.3 theme change to compile and keep its current behavior on Touying 0.8.0?
- **Scope**: mixed (theme call sites in this repo; Touying 0.6.3 and 0.8.0 package source; changelog and theme-author migration guide)
- **Date**: 2026-10-27

## Findings

### Required changes

Two edits keep the current deck. Nothing else the theme calls has to be renamed or moved.

1. **Import pin.** Replace `@preview/touying:0.6.3` with `@preview/touying:0.8.0` in both files that import it:
   - `lib.typ` line 1 (star re-export)
   - `themes/ysu-beamer.typ` line 7 (the theme’s own import)
   `themes/tokens.typ` and `themes/components.typ` do not import Touying. The theme file’s import is what the compiler uses for the symbols below. `lib.typ` must move with it; leaving `lib.typ` on 0.6.3 would load a second Touying into the published package.

2. **Section-slide body.** In `ysu-theme`’s `config-common` (`themes/ysu-beamer.typ` lines 772–778), set `receive-body-for-new-section-slide-fn: true`.

   Touying 0.7.3 changed the default from `true` to `false`. 0.8.0 keeps `false` (`src/configs.typ` line 776). This theme’s `new-section-slide` draws `<ysu-opener>` from the content written after `= 标题` (`chapter-opener`, and any `#note` in that span). That content is the slide `body` only while the flag is `true`, which was the 0.6.3 default (`src/configs.typ` line 131 and `default-config` line 702).

   With the 0.8.0 default left unset, an import-only build of `examples/beamer-ysu.typ` still compiles, but the five chapter openers split off the section slides: 21 pages become 26. Level-1 headings and `<ysu-opener>` land on different pages (0.6.3: both on pages 3, 9, 11, 16, 19; 0.8.0 default: headings on 3, 10, 13, 19, 23 and openers on 4, 11, 14, 20, 24). The splitter emits the section slide immediately with `body: none`, then the following markup is flushed later through `slide-fn` (`slide`), not `new-section-slide`, because `current-headings` was cleared. The opener drawing, which reads `_on-page(<ysu-opener>)` inside `new-section-slide`, no longer sees the marker.

   The other three flags (`receive-body-for-new-subsection-slide-fn` and the subsubsection variants) do not affect this theme. It never sets `new-subsection-slide-fn` / `new-subsubsection-slide-fn` / `new-subsubsubsection-slide-fn`, and those default to `none`. Only the level-1 flag is required.

   Quoted migration note (Touying 0.8.0 package `changelog.md`, section v0.7.3; also [changelog.md on tag 0.8.0](https://github.com/touying-typ/touying/blob/0.8.0/changelog.md), pull [#354](https://github.com/touying-typ/touying/pull/354)):

   > `#speaker-note[]` now always attaches to the **slide above it**… `receive-body-for-new-section-slide-fn` and its variants are now **defaulted to `false`** (previously `true`).
   >
   > If you relied on content after `= Section` headings being absorbed into the section slide body, explicitly set `receive-body-for-new-section-slide-fn: true` in your `config-common(...)`.

No public theme parameter, structure-page function, or component name has to change. `config-info` still accepts the extra keys this deck uses (`supervisor`, `subject`, `school`, `stage`, `stage-en`) through `..args.named()` merged into `info` (0.8.0 `src/configs.typ` lines 507–524). 0.7.1 added first-class `contact` and `extra`; that does not remove the open named-argument sink.

### Evidence (temp copies only; the repo theme was not edited)

Package downloaded by compiling `#import "@preview/touying:0.8.0": *`. Installed at `%LOCALAPPDATA%/typst/packages/preview/touying/0.8.0/` (`typst.toml` `version = "0.8.0"`, `compiler = "0.15.0"`). GitHub release [0.8.0](https://github.com/touying-typ/touying/releases/tag/0.8.0) is commit `2600b40` (17 Sep 2026). The changelog heading inside that package still says “v0.8.0 (unreleased)”; the package version and the GitHub release are 0.8.0. Typst compiler used for the probes was the one on `PATH` (project baseline is 0.15.1).

A temp copy of `themes/` plus `examples/beamer-ysu.typ` was compiled with `--root` pointed at the copy.

| Build | Result |
|---|---|
| Repo sources, Touying 0.6.3, 16:9 | exit 0, 21 pages |
| Copy, import 0.8.0 only | exit 0, 26 pages; opener metadata not on the section-slide page; pdfpc `Note` count still 6 |
| Copy, import 0.8.0 **and** `receive-body-for-new-section-slide-fn: true` | exit 0, 21 pages; opener pages 3, 9, 11, 16, 19 |
| Same flag, `--input ratio=4-3` | exit 0 |
| Same flag, `--input notes=on` | exit 0; `python -I examples/check-page-labels.py … --expect-notes` exit 0 |

Byte compare after the flag, against the 0.6.3 compiles of the same example: `ysu-063.pdf` ≡ `ysu-080-fixed.pdf` (307208 bytes), 4:3 pair ≡ (308114 bytes), notes pair ≡ (327961 bytes). Notes labels on both: `1, notes:1, …, 6, 6, 6, notes:6, …, 19, notes:19` (19 frames, 19 notes pages). The three shared `6` labels are the `#pause` subslides in `examples/beamer-ysu.typ`. No compiler diagnostics were printed for these compiles.

That identity covers the paths the example actually exercises: cover, outline, five openers, content pages, `composer: (1fr, 1fr)`, `#pause`, footer counter, `config-info` extra fields, ending, 4:3, and `notes: true`. It does not by itself cover a deck that enables `show-notes-on-second-screen`, `show-only-notes`, handout mode, or article mode.

### Symbol map (what this theme calls)

“Root” means a name bound by `#import "@preview/touying:0.8.0": *`, which is `lib.typ` → `src/exports.typ`. 0.6.3’s `src/core.typ` was split (0.8.0 `changelog.md` Miscellaneous: parser, animation, slides, blocks, waypoints, article, tree, subslides, entrypoint, bundle). The changelog says the public API is unaffected except where a breaking note says otherwise. Direct imports of `touying/src/core.typ` would break; this theme does not do that.

| Symbol | Theme site | 0.8.0 status |
|---|---|---|
| `speaker-note` | `note` at `themes/ysu-beamer.typ:133`, called as `speaker-note(body)` | Still a root export. Defined in `src/core/blocks.typ:56`. Same parameters `(mode: "typ", setting: it => it, subslide: auto, note)`. Still emits `metadata((kind: "touying-speaker-note", …))`. In-body handling in `src/core/parser.typ:2968` matches 0.6.3 `src/core.typ:2149`: the mark is turned into `utils.speaker-note(...)`, which still calls `pdfpc.speaker-note` when `enable-pdfpc` is true (default). Not renamed. |
| `touying-slide` | `_emit` at line 209 | Still a root export, from `src/core/slides.typ:1629`. Same parameters `(self:, config:, repeat:, setting:, composer:, ..bodies)`. Still returns the sum of every subslide (`result.sum()` at line 2166), so one `_notes-tail` after the call still follows the whole frame. |
| `touying-slide-wrapper` | `slide` 340, `title-slide` 386, `outline-slide` 463, `new-section-slide` 542, `ending-slide` 671 | Still a root export, from `src/core/animation.typ:64`. The marker is now `block[#metadata(...) <touying-temporary-mark>]` instead of a bare content sequence, so a user label can sit on the call. `src/core/slides.typ:256` `_unwrap-slide-wrapper` strips that block before the callback runs. The callback’s return value is still what gets pushed onto the document (`call-slide-fn-and-reset` → `output-slides.sum()`). |
| `utils.current-heading` | line 231, `level: 2, depth: self.slide-level` | Still `utils.current-heading` (`src/utils.typ:382`). Same parameters, including the spelling `hierachical`. 0.8.0 scopes the `heading` query with `bundle.within-current-document` so a bundle export does not see another document’s headings. A normal single-PDF compile is unchanged (the identical example PDF). |
| `utils.merge-dicts` | lines 342 and 378 | Still `utils.merge-dicts` (`src/utils.typ:81`). Same positional-only rule. Dictionary merge of a `margin` key now goes through `add-page-margin-dicts` (0.7.0 page-margin precedence). This theme’s structure pages replace `margin` with the length `0pt`, which still replaces the dictionary rather than merging it. Content slides do not re-merge `margin`. Identical PDFs. |
| `utils.slide-counter` | lines 289–290, `.at(location)` and `.get()` | Still `counter("touying-slide-counter")` (`src/utils.typ:96`). Still stepped in the page preamble on subslide 1 (`src/core/slides.typ:1776`). |
| `utils.last-slide-number` | line 292 | Still `context last-slide-counter.final().first()` (`src/utils.typ:98`). The notes `page()` is not a Touying slide, so it does not step this counter. Identical footer in the example PDF. |
| `utils.display-info-date` | lines 418 and 727 | Still `utils.display-info-date(self)` (`src/utils.typ:669`). Same body: `datetime` is displayed with `self.datetime-format` (default `auto`), anything else is returned as-is. |
| `config-store` | lines 344 and 829 | Still a root export. Still returns `(store: args.named())` (`src/configs.typ:40`). `self.store.align`, `nav-labels`, `nav-full-labels`, `headline-width`, `notes`, `slide-title` are unchanged. |
| `config-page` | lines 345, 381, 760 | Still a root export (`src/configs.typ:660`). Still `(page: …)` plus `..args`, so `width`, `height`, `header-ascent`, `footer-descent`, `background` still pass through. Keys the theme sets (`width`, `height`, `fill`, `header`, `footer`, `header-ascent`, `footer-descent`, `margin`, `numbering`, `background`) are still accepted. `self.page.width` (line 181) is that dictionary. |
| `config-common` keys the theme sets | lines 772–778 | All five still exist on `config-common` (`src/configs.typ:245`): `slide-fn`, `new-section-slide-fn`, `show-strong-with-alert`, `zero-margin-header`, `zero-margin-footer`. Defaults that matter: `show-strong-with-alert: true` (theme sets `false`), `zero-margin-header/footer: true` (theme sets `false`), `slide-level: 2` (theme does not set it; `==` is still the content slide). New keys `notes-fn`, `breakable`, `clip`, `detect-overflow`, `article-mode`, `export-mode`, `article-theme`, `footnote-style` are optional. `detect-overflow` default changed from the older `true` to `auto` (0.8.0 changelog); with `breakable: true` that does not change this example’s PDF. |
| `config-methods` `init`, `alert` | lines 779–817 | Still `config-methods` (`src/configs.typ:414`). `init: (self: none, body) => {…}` and `alert: (self: none, it) => {…}` are still the documented parameters. **Removed from this function:** the `show-only-notes` *renderer* that 0.6.3 accepted as `config-methods(show-only-notes: …)`. This theme does not pass it. The boolean `config-common(show-only-notes: true)` is a different option and still defaults to `false`. |
| `config-colors` keys | lines 818–828 | Still `config-colors` (`src/configs.typ:549`). Every key the theme sets is still a named parameter: `primary`, `primary-dark`, `primary-light`, `primary-lighter`, `primary-lightest`, `secondary`, `neutral-darkest`, `neutral-dark`, `neutral-lightest`. |
| `touying-slides` | line 759 | Still a root export. Moved from `src/slides.typ` to `src/entrypoint.typ:94`. Still `#show: touying-slides.with(config-…, ..args)`. |
| `self.store` | lines 80–82, 180, 218, 228–229, 253, 341, 346 | Still the `store` dictionary from `config-store`. |
| `self.slide-level` | line 231 | Still a top-level field, default `2`. |
| `self.info` | lines 318, 388, 721 | Still the `info` dictionary from `config-info`. `.author`, `.date`, `.title`, and `.at("stage", default:)` behave as before. |
| `self.page` | line 181 `self.page.width` | Still the `page` dictionary from `config-page`. |
| `measure` (not a Touying call in 0.6.3) | `themes/ysu-beamer.typ` calls `measure(...)` in `_at`, `_headline-lines`, `_page-pill`, `title-slide`, `new-section-slide` | **New root export.** `src/exports.typ:22` imports `measure` from `src/core/parser.typ:3928`. A star import in `ysu-beamer.typ` therefore binds Touying’s `measure` instead of `std.measure`. Signature is `(body, subslide: auto, base: auto, ..args)` and it returns a `(width, height)` dictionary, forwarding `width`/`height` to `std.measure`. Default `subslide: auto` measures the last subslide. This theme measures content with no animation marks, inside `context`. The 16:9, 4:3, and notes PDFs were byte-identical to 0.6.3, so those calls did not change layout. `themes/components.typ` does not import Touying, so its `measure` stays `std.measure`. No edit is required for the current deck. |
| `config-info` | not called inside the theme; example and template pass it into `ysu-theme` | Still a root export. Extra named keys still merge into `info` (see above). |
| `pause` | example only (`examples/beamer-ysu.typ`), re-exported through `lib.typ` | Still a root export (`jump(1, relative: true)`). The 0.8.0 pause break is: a `#pause` after `uncover` / `only` / `alternatives` no longer skips the subslides those wrappers reserved (0.8.0 changelog, first breaking entry). This theme and `examples/beamer-ysu.typ` do not use those wrappers. The notes PDF’s `6, 6, 6` subslide labels match 0.6.3. |

`utils` names that **moved and are not called** by this theme (0.8.0 `src/utils.typ` around lines 3303–3368): `is-sequence`, `is-styled`, `is-space`, `is-math-symbol`, `is-metadata`, `is-kind`, `is-heading`, `trim`, `sequence-to-array`, `positional-fields` panic and name `tree`; `check-visible`, `last-required-subslide`, `resolve-waypoints` panic and name `subslides` or `waypoints`; `label-it`, `call-with-fields`, `reconstruct`, `reconstruct-table-like`, `reconstruct-styled`, `reconstruct-heading` forward with a deprecation warning. `utils.handout-only` is removed; the root `#handout-only[..]` remains. `utils.semi-transparent-cover` still runs and warns. None of these appear in `themes/`.

### Custom notes: `page()` after `touying-slide`, plus `speaker-note`

**0.8.0 does not break this pattern.**

What the theme does (`themes/ysu-beamer.typ`):

- `note` (line 132) calls `speaker-note(body)` and also writes `[#metadata(body) <ysu-note-body>]`. Callers put `#note` **inside** the slide body (or pass `note:` into cover, outline, and ending, which the wrapper puts in that body). Opener notes sit in the section body after `= 标题` (`.trellis/spec/theme/theme-architecture.md` section 5a).
- `_emit` (line 208) calls `touying-slide(self: self, ..args)` and then `_notes-tail`.
- `_notes-tail` (line 178), when `self.store.notes` is true, appends a top-level `page(width: self.page.width, height: width * 13.5/16, numbering: "notes:1", …)` and runs `counter(page).update(n => n - 1)`.

Why that still works:

- The `block` added around `touying-slide-wrapper` wraps only the **marker** that stores the callback. It does not wrap the callback’s return value. The notes `page()` is produced when the callback runs, and that return value is concatenated into `output-slides` at document level (`src/core/slides.typ` `output-slides.sum()`), the same place 0.6.3 put it. The notes-on example PDF is byte-identical, including the `N` / `notes:N` label contract.
- In-body `#speaker-note` is still parsed as a `touying-speaker-note` mark and still writes pdfpc metadata. The 0.7.3 rule “always attach to the slide above it” is the **document-splitter** path for a `speaker-note` that is a sibling immediately after a slide wrapper (`src/core/slides.typ:548–582`, `attached-speaker-notes`). This theme’s `speaker-note` is inside the body, so it takes the parser path, not that sibling path. pdfpc `Note` count stayed 6 on the import-only build, and the notes PDF matched after the section-body flag.
- `notes-fn` is not involved. It runs only for `show-only-notes: true` or `show-notes-on-second-screen` (`src/core/slides.typ:1494` and `:1537`, and `utils.speaker-note` at `src/utils.typ:2952`). Both default off. The theme’s notes page is its own `page()`, not Touying’s panel.

The section-body flag **does** affect opener notes, because those notes are in the body after `=`. Without `receive-body-for-new-section-slide-fn: true` they are not on the opener slide. That is the same flag as the layout break, not a separate notes-page break.

### 0.8.0 theme-author guide, item by item

Source: package `changelog.md` lines 451–475, “Theme Migration Guide”; same text at [github.com/touying-typ/touying blob/0.8.0/changelog.md](https://github.com/touying-typ/touying/blob/0.8.0/changelog.md). User-facing notes write-up: [docs/en/tutorials/build-your-own-theme.md](https://github.com/touying-typ/touying/blob/main/docs/en/tutorials/build-your-own-theme.md) section “Customizing the Notes”. Speaker-note panel change: changelog breaking entry “the speaker-note panel is customizable through `config-common(notes-fn: ..)`” and migration steps 3–4 (package `changelog.md` lines 56–64 and 135–136).

| Guide item | Applies to this theme? |
|---|---|
| 1. Pass alignment as `touying-slide(setting: …)`, do not wrap the positional body in `align` | Already how `slide` works (`setting: new-setting` at line 368). `new-setting` is applied after parsing. No change required for the current slides. |
| 2. Register `config-common(notes-fn: …)` on `touying-notes`; delete `config-methods(show-only-notes: renderer)` | This theme never set that renderer. Ordinary slides do not call `notes-fn`. Registering one would style the second-screen / only-notes panel, which this theme does not turn on. Not required to keep the current `page()` notes. |
| 3. Put a hidden heading on special slides so `utils.display-current-heading` can see the title | This theme does not call `display-current-heading`. Content-slide titles come from `==` headings via `utils.current-heading`, or from `self.store.slide-title`. Cover, outline, and ending pass their own titles. No change required for the current header. |
| 4. Prefer `touying-fn-wrapper-raw` for helpers that need `self` | `themes/components.typ` does not take `self` and does not import Touying. Not required. |
| 5. Do not paint the notes half with `config-page(background:)` | That confinement runs only when `show-notes-on-second-screen` is `top`/`bottom`/`left`/`right` (`src/core/slides.typ:1408` and the breaking note for issue #219). This theme leaves that option at `none` and draws the slide chrome in `background` on the slide page. The notes page sets `background: none` on its own `page()`. No change required unless someone later enables the second screen. |

Quoted guide item 2:

> **Register a `notes-fn`.** Replace any `config-methods(show-only-notes: ..)` renderer override with `config-common(notes-fn: ..)` built on `touying-notes`; roughly ten lines of colours per theme. The `config-common(show-only-notes: ..)` flag is a separate option and is unchanged.

`config-common(show-only-notes:)` is a bool (default `false`). `notes-fn` defaults to `touying-notes` (`src/configs.typ:790–791`). `touying-notes` is a new root export (`src/core/slides.typ:2248`).

### Optional 0.8.0 features (out of scope)

These are new. The current slides do not call them, and turning them on changes the product. Not required to compile or to match the 0.6.3 PDF.

- **Article mode.** `config-common(export-mode: "article")` or `--input export-mode=article`. `src/entrypoint.typ:139` then replaces `slide-fn` with an article slide and replaces `methods.init` with the identity, so this theme’s type and page setup would not run. `themes.article` is the bundled article theme.
- **`touying-render`.** New root export from `src/core/animation.typ`. Renders one piece of content at chosen animation stages. No call site in this repo.
- **`animate`.** New root export (`animate`, `animate-hidden`, `animate-removed`, `swap`). No call site in this repo.
- **pdfpc as a bundle asset** (`pdfpc.bundle-assets()`, Typst `--features bundle`). The existing `typst query` / `<pdfpc>` path still works (`enable-pdfpc` default `true`). The identical notes PDF includes the same pdfpc metadata.
- **`notes-fn` / `touying-notes`.** Only for the built-in notes panel. See the guide table above.
- **`touying-recall` `subslide:` → `subslides:`**, bibliography boolean, `semi-transparent-cover` deprecation, negative subslide indexes, reducer-binding shape. No call sites in `themes/`.

### Files found

| Path | Role |
|---|---|
| `lib.typ` | Star-imports `@preview/touying:0.6.3` and the theme |
| `themes/ysu-beamer.typ` | Every Touying call listed above; own pin at line 7 |
| `themes/tokens.typ`, `themes/components.typ` | No Touying import |
| `examples/beamer-ysu.typ` | Regression deck; its own `@preview/touying:0.6.3` import at line 1; `#pause` and `config-info` |
| `examples/check-page-labels.py` | `N` / `notes:N` contract used to check the notes PDF |
| `.trellis/spec/theme/theme-architecture.md` | Section 5a is the notes contract (`speaker-note` plus `_notes-tail`’s `page()`); section 4.2 says `new-section-slide` reads `<ysu-opener>` placed after `= 标题` |
| `.trellis/spec/theme/index.md` | Records the 0.6.3 pin (line 9) |
| `.trellis/spec/package/packaging-guidelines.md` | Records the 0.6.3 pin (line 102) |
| `%LOCALAPPDATA%/typst/packages/preview/touying/0.6.3/` | Baseline exports, `receive-body` default `true` |
| `%LOCALAPPDATA%/typst/packages/preview/touying/0.8.0/` | 0.8.0 source and `changelog.md` actually compiled against |
| `%LOCALAPPDATA%/typst/packages/preview/touying/0.8.0/src/exports.typ` | Root export list |
| `%LOCALAPPDATA%/typst/packages/preview/touying/0.8.0/src/configs.typ` | `config-*` signatures and `default-config` |
| `%LOCALAPPDATA%/typst/packages/preview/touying/0.8.0/src/core/slides.typ` | Splitter, `touying-slide`, `touying-notes`, notes panel |
| `%LOCALAPPDATA%/typst/packages/preview/touying/0.8.0/src/core/animation.typ` | `touying-slide-wrapper` block wrapper |
| `%LOCALAPPDATA%/typst/packages/preview/touying/0.8.0/src/core/blocks.typ` | Root `speaker-note` |
| `%LOCALAPPDATA%/typst/packages/preview/touying/0.8.0/src/core/parser.typ` | In-body speaker-note handling; exported `measure` |
| `%LOCALAPPDATA%/typst/packages/preview/touying/0.8.0/changelog.md` | 0.8.0 breaking notes, migration guide, and the 0.7.3 section-body note |

### External references

- [Touying 0.8.0 release](https://github.com/touying-typ/touying/releases/tag/0.8.0) — release notes; tag `0.8.0`, commit `2600b40`. Requires Typst 0.15.
- [changelog.md at tag 0.8.0](https://github.com/touying-typ/touying/blob/0.8.0/changelog.md) — theme migration guide and the 0.7.3 `receive-body` / `speaker-note` note. The copy inside the installed 0.8.0 package matches this text (heading still says “unreleased”).
- [Build your own theme](https://github.com/touying-typ/touying/blob/main/docs/en/tutorials/build-your-own-theme.md) — “Customizing the Notes”: `notes-fn` built on `touying-notes`. Fetched from `main`, which is at package version 0.8.0 (`typst.toml` on `main`).
- [PR #354](https://github.com/touying-typ/touying/pull/354) — `speaker-note` attaches to the previous slide; `receive-body-for-new-*-slide-fn` default becomes `false`.
- [Issue #353](https://github.com/touying-typ/touying/issues/353) — speaker-note panel becomes `notes-fn`.

### Related specs

- `.trellis/spec/theme/theme-architecture.md` — opener reads `<ysu-opener>` after `= 标题`; notes are `speaker-note` plus a following `page()`.
- `.trellis/spec/theme/index.md` — layer still documented against `@preview/touying:0.6.3`.
- `.trellis/spec/package/packaging-guidelines.md` — package dependency still documented as `@preview/touying:0.6.3`.
- `.trellis/spec/theme/typography-and-style.md` — `config-colors` mirrors tokens; theme code reads tokens directly. Color keys did not move.

## Caveats / Not Found

- The published docs changelog at `docs/en/changelog.md` on `main` (fetched 2026-10-27) stops at v0.7.4. The 0.8.0 theme guide is in the repository root `changelog.md` and in the installed package, not in that docs page.
- Byte-identical PDFs mean the example’s rendered output matches. They do not prove an unused option (`show-notes-on-second-screen`, article mode, handout, `uncover`/`only`) is unchanged. Those options are unused by this theme.
- `measure` is shadowed in any file that star-imports Touying 0.8.0, including a user file that star-imports `lib.typ` once `lib.typ` re-exports 0.8.0. For this theme’s measured content the sizes matched `std.measure`. A measured fragment that itself contains `#pause` would be measured at the last subslide, which `std.measure` does not do. This deck does not do that.
- `examples/beamer-thesis/` was not compiled in this probe. The task PRD now requires `just build` and `just notes` for that deck. Those compiles are still outstanding; this file only proves `examples/beamer-ysu.typ`.
- No Touying symbol that `themes/ysu-beamer.typ` calls was removed, renamed, or moved off the package root.
