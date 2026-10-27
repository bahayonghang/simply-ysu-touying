# Implement：YSU 答辩主题 1.0.0（父任务）

父任务本身不直接改代码；它负责子任务顺序、跨子任务门禁与最终集成复核。

## 执行顺序

1. `10-27-theme-core` — 主题重写、组件库、`beamer-ysu.typ` 与模板迁移。
2. `10-27-speaker-notes` — 先 spike（notes-contract §4.1），再实现。依赖 1 的 `slide` 包装器。
3. `10-27-thesis-front-ch1-ch2` — 示例骨架 + P01–P18。依赖 1、2。
4. `10-27-thesis-ch3-ch4` — P19–P51。依赖 3 的骨架与 `lib/layouts.typ`。
5. `10-27-thesis-ch5-ch7-back` — P52–P88 + 全量对照。依赖 4。
6. `10-27-release-1-0-0` — 版本同步、文档、缩略图、Universe 模拟。依赖 1–5。

复刻子任务中若发现需要主题新增/修改通用组件：回到 theme-core 的约定（在主题中实现并补 `beamer-ysu.typ` 演示），并在当前子任务记录“上提”的组件名。

## 跨子任务门禁

| 门禁 | 时机 | 命令 / 方法 |
|---|---|---|
| G1 回归编译 | 每个子任务结束 | `typst compile --root . examples/beamer-ysu.typ` |
| G2 复刻编译 | 3–5 每批结束 | `typst compile --root . examples/beamer-thesis/main.typ`，页数 = 已完成帧数 |
| G3 备注编译 | 2 之后每批 | `typst compile --root . --input notes=on examples/beamer-thesis/main.typ <out>`；页标签检查脚本输出 `N, notes:N` 成对 |
| G4 目视对照 | 3–5 每批 | 渲染 PNG（`typst compile --format png --ppi 72 … "out/page-{0p}.png"`）与 `thesis/slides/deck/preview/page-NNN.png` 并排比对，偏差写入子任务 `research/visual-diff.md` |
| G5 包边界 | 6 | `typst.toml` exclude 不变；无新增 `themes/assets/*`；`grep -rn thumbnail themes lib.typ template` 为空 |
| G6 版本 | 6 | `grep -n "simply-ysu-touying:" typst.toml template/main.typ README.md README.zh.md docs/typst-packages-pr-structure.md AGENTS.md` 全为 1.0.0 |

## 最终集成复核（父任务收尾）

- [ ] 六个子任务均已归档或状态 completed。
- [ ] PRD 跨子任务验收项逐条勾选，附命令输出摘要。
- [ ] 记录 88 页全量编译耗时（冷编译、增量编译各一次）。
- [ ] `.trellis/spec/theme/*`、`.trellis/spec/package/*`、`AGENTS.md` 已反映新主题（由 release 子任务执行，父任务核对）。

## 回滚点

- theme-core 提交前：保留 0.2.0 主题。
- release 提交前：版本号未改，可只回滚 release 提交。
