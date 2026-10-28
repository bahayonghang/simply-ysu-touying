# Theme Development Guidelines

> Guidelines and standards for Touying presentation theme implementation in `simply-ysu-touying`.

---

## Overview

The `theme` layer owns the visual and structural presentation logic for Yanshan University slides. It builds on `@preview/touying:0.8.0` (no other dependency since 0.2.0) to deliver the navy defense layout: structure pages, contextual header/footer, Chinese typography, design tokens, and a component library.

Theme code is split into `themes/tokens.typ`, `themes/components.typ` and `themes/ysu-beamer.typ`, all exported through `lib.typ`.

---

## Guidelines Index

| Guide | Description | Status |
|-------|-------------|--------|
| [Theme Architecture](./theme-architecture.md) | Module split, 16cm×9cm geometry, slide wrappers, page markers, header/footer | Active |
| [Typography and Style](./typography-and-style.md) | Color/gradient tokens, fonts, sizes, emphasis, component catalogue, brand marks | Active |

---

## Key Source Files

- `themes/tokens.typ`: Colors, gradients, fonts, brand marks (`seal`, `wordmark`, `logo`).
- `themes/components.typ`: Content components (`hl`, `key`, `title-box`, `group-box`, `conclude`, `points`, `kpi`, `result-table`, ...).
- `themes/ysu-beamer.typ`: `ysu-theme`, slide functions (`slide`, `title-slide`, `outline-slide`, `new-section-slide`, `ending-slide`), page markers (`sub`, `takeaway`, `chapter-opener`).
- `lib.typ`: Package entrypoint re-exporting Touying core symbols and `themes/ysu-beamer.typ`.
- `examples/beamer-ysu.typ`: Comprehensive reference presentation demonstrating every structure page and component; compile at 16:9 and with `--input ratio=4-3`.

---

## Core Principles

1. **Touying Paradigm Compliance**: Slide functions use `touying-slide-wrapper` / `touying-slide`; components are plain functions over tokens.
2. **Context-Aware Header/Navigation**: Per-page data travels as labelled `metadata` markers read with `context` (see Theme Architecture §5).
3. **Academic Presentation Polish**: Maintain consistent spacing, high contrast, clean font hierarchies, and graceful degradation for different aspect ratios ("16-9" and "4-3").
