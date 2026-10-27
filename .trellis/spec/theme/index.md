# Theme Development Guidelines

> Guidelines and standards for Touying presentation theme implementation in `simply-ysu-touying`.

---

## Overview

The `theme` layer owns the visual and structural presentation logic for Yanshan University slides. It integrates directly with `@preview/touying:0.6.3` and `@preview/cuti:0.4.0` to deliver custom slide layouts, contextual navigation, Chinese typography rules, color palettes, and reusable slide components.

All core theme code lives in `themes/ysu-beamer.typ` and is exported through `lib.typ`.

---

## Guidelines Index

| Guide | Description | Status |
|-------|-------------|--------|
| [Theme Architecture](./theme-architecture.md) | Touying integration, slide wrappers, navigation bar, headers, footers, and state management | Active |
| [Typography and Style](./typography-and-style.md) | Font cascading, Chinese fake bold (`cuti`), YSU blue color tokens, card blocks (`#tblock`), and visual elements | Active |

---

## Key Source Files

- `themes/ysu-beamer.typ`: Primary theme implementation containing `ysu-theme`, slide functions (`slide`, `title-slide`, `outline-slide`, `new-section-slide`, `ending-slide`), and component `#tblock`.
- `lib.typ`: Package entrypoint re-exporting Touying core symbols and `themes/ysu-beamer.typ`.
- `examples/beamer-ysu.typ`: Comprehensive reference presentation demonstrating multi-column layouts, animations, tables, and math equations.

---

## Core Principles

1. **Touying Paradigm Compliance**: Always use `touying-slide-wrapper`, `touying-slide`, and `touying-fn-wrapper` for slide definitions and theme components.
2. **Context-Aware Dynamic Header/Navigation**: Use Typst `context` and `utils.current-heading` to dynamically determine the current section and slide title.
3. **Academic Presentation Polish**: Maintain consistent spacing, high contrast, clean font hierarchies, and graceful degradation for different aspect ratios ("16-9" and "4-3").
