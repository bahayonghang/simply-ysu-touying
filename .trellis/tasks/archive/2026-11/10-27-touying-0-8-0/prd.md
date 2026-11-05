# 升级 Touying 到 0.8.0

## Goal

让 `simply-ysu-touying` 0.2.0 在 Touying 0.8.0 上编译，并且现有答辩幻灯片不用改写法。封面、目录、扉页、内容页、致谢、组件和备注页保持现在的行为。

## Background

仓库把依赖写死为 `@preview/touying:0.6.3`（`lib.typ`、`themes/ysu-beamer.typ`、`examples/beamer-ysu.typ`，以及 README、`AGENTS.md`、`.trellis/spec/theme/index.md`、`.trellis/spec/package/packaging-guidelines.md`）。`themes/tokens.typ` 和 `themes/components.typ` 不导入 Touying。Typst Universe 上的最新版是 0.8.0，要求 Typst 0.15；本包编译器基线是 0.15.1。

主题直接调用的接口都在 `themes/ysu-beamer.typ`：`speaker-note`（约第 133 行）、`touying-slide`、`touying-slide-wrapper`、`utils.current-heading`、`utils.merge-dicts`、`utils.slide-counter`、`utils.last-slide-number`、`utils.display-info-date`、`config-store`、`config-page`、`config-common`、`config-methods`、`config-colors`、`touying-slides`，以及 `self.store`、`self.slide-level`、`self.info`。扉页把标题后的正文交给 `new-section-slide`（第 658 行 `slide-body + body`）。

0.8.0 的差异和必须钉住的默认值见 `research/touying-0.8-migration.md`。

包版本已经按用户要求从尚未发布的 `1.0.0` 改回 `0.2.0`。Universe 上已发布的是 `0.1.0`。迁移说明相对 `0.1.x`。

## Requirements

1. 产品代码、示例、用户文档和现行规范里的 Touying 依赖改为 `@preview/touying:0.8.0`。`.trellis/tasks/archive/` 里的历史记录保持原样。
2. 公开 API 保持现在的名字和参数：`ysu-theme` 的 `aspect-ratio`、`align`、`nav-labels`、`nav-full-labels`、`font`、`notes`，以及 `title-slide`、`outline-slide`、`chapter-opener`、`ending-slide`、`slide`、`sub`、`takeaway`、`note` 和 `themes/components.typ` 的组件名。
3. 为通过 0.8.0 所必需的内部改动只放在 `themes/ysu-beamer.typ`（符号若不再从包根导出，才改 `lib.typ` 的重导出）。必须显式设置 `receive-body-for-new-section-slide-fn: true`，让扉页继续收到一级标题之后的正文。不额外改 `breakable`：仓库示例在该项保持 0.8.0 默认值时，PDF 已与 0.6.3 逐字节相同。版式、页眉页脚、章节导航、备注页尺寸和页标签契约不变。
4. 包版本保持 `0.2.0`，版本引用与 `typst.toml` 一致。本任务不发布到 Typst Universe。若迁移迫使公开 API 发生破坏性变化，停下来改计划，不在本任务里把包版本升到 `1.0.0`。
5. 本机 `examples/beamer-thesis/` 纳入验收：投屏版和备注版都要编译通过，页标签检查通过。该目录继续不入库。不跑 `sync`，不改章节内容。

## Acceptance Criteria

- [x] 现行产品代码、README、`AGENTS.md` 和 `.trellis/spec` 中不再出现 `@preview/touying:0.6.3` 或“依赖 0.6.3”的现行说明。归档任务除外。
- [x] `typst compile --root . examples/beamer-ysu.typ` 成功（21 页）。
- [x] `typst compile --root . --input ratio=4-3 examples/beamer-ysu.typ` 成功（21 页）。
- [x] `typst compile --root . --input notes=on examples/beamer-ysu.typ .tmp/notes.pdf` 成功，且 `python -I examples/check-page-labels.py .tmp/notes.pdf --expect-notes` 通过（19 帧、19 张备注页）。
- [x] `just --justfile examples/beamer-thesis/justfile build` 成功（88 页，`icons=on`）。
- [x] `just --justfile examples/beamer-thesis/justfile notes` 成功（88 帧、88 张备注页，页标签检查通过）。
- [x] 上述示例和答辩稿不需要改主题 API 写法。允许改动仅限 Touying 导入版本行。
- [x] `typst.toml` 的 `version` 为 `0.2.0`，且 `typst.toml`、`template/main.typ`、`README.md`、`README.zh.md`、`docs/typst-packages-pr-structure.md`、`AGENTS.md` 里的 `simply-ysu-touying:` 引用都是 `0.2.0`。
- [x] `examples/beamer-thesis/` 没有被加入 git。

## Out of Scope

- 启用或演示 article mode、`touying-render`、`animate`。
- 改颜色、字体、几何或组件外观。
- 把包版本升到 `1.0.0`，或提交 Typst Universe。
- 把 `examples/beamer-thesis/` 入库，或运行它的 `sync` / `speech` / `pages`。
