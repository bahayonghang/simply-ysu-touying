# 发布 1.0.0：版本同步与文档

父任务：`10-27-ysu-defense-1-0`（PRD R4、design §7）。依赖其余五个子任务完成。

## Goal

把包版本升到 `1.0.0`，同步全部版本引用与文档，重生成展示产物，并通过本地 Universe 模拟。

## 现状（2026-10-27 grep）

`typst.toml` 为 `0.2.0`，但 `template/main.typ`、`README.md`、`README.zh.md`、`docs/typst-packages-pr-structure.md` 仍写 `0.1.0`，`AGENTS.md` 写 `0.2.0`——已有不一致，本次一并修正。

## Requirements

1. 版本 `1.0.0`：`typst.toml`、`template/main.typ`、`README.md`、`README.zh.md`（安装命令与代码块）、`docs/typst-packages-pr-structure.md`（目录与命令）、`AGENTS.md`（当前版本、命令、API 示例）。
2. `typst.toml`：`description` 视需要更新为体现答辩版式；依赖变化（去掉 cuti）不需要在 toml 声明，但 README 依赖说明要改。
3. README（中英）：新主题截图（`docs/screenshots/` 重新截取）、新 API 快速上手、组件一览、演讲备注用法（来自 speaker-notes `research/usage.md`）、推荐字体、**从 0.2.x 迁移**小节（删除的参数、配色/字体变化、cuti 移除）。
4. 重生成：`thumbnail.png`（新主题封面，尺寸与 Universe 要求一致）、`template/main.pdf`、`examples/beamer-ysu.pdf`。
5. 规范：`.trellis/spec/theme/theme-architecture.md`、`typography-and-style.md`、`.trellis/spec/package/*` 与 `AGENTS.md` §1–§5 反映新架构（文件拆分、令牌、去 cuti、notes、examples/beamer-thesis 不入库）。
6. 本地 Universe 模拟按 `verification-and-release.md` §3，版本目录 `1.0.0`。

## Acceptance Criteria

- [ ] `grep -rn "simply-ysu-touying:" typst.toml template/main.typ README.md README.zh.md docs/typst-packages-pr-structure.md AGENTS.md` 全为 `1.0.0`，且全仓无残留 `0.1.0`/`0.2.0` 版本引用（`.trellis/` 历史记录除外）。
- [ ] `typst init --package-path <tmp> @preview/simply-ysu-touying:1.0.0 test` 与随后的 `typst compile --package-path <tmp> test/main.typ` 成功。
- [ ] `typst compile --root . examples/beamer-ysu.typ` 成功；`thumbnail.png` 无代码引用。
- [ ] 打包清单仅含 PRD R4 列出的文件；`themes/assets/` 未新增文件。
- [ ] Typst 0.14 基线编译（若本机可获得 0.14，否则记录未验证）。

## Out of Scope

- 实际向 `typst/packages` 提交 PR、推送标签或 GitHub Release（需用户另行确认）。
