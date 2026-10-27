# Implement：主题核心

## 前置

- 读 `.trellis/spec/theme/index.md` 及其两篇、`.trellis/spec/package/assets-and-licensing.md`。
- 读父任务 `research/latex-visual-spec.md`，对照 `thesis/slides/deck/preview/page-001/002/003/006/007/010/021/047/077/088.png`。
- 读 touying 0.6.3 `src/configs.typ`（config-page/config-info/config-store）与 `themes/university.typ` 作为结构参考（本机缓存 `%LOCALAPPDATA%/typst/packages/preview/touying/0.6.3/`）。

## 步骤

1. [x] 新建 `themes/tokens.typ`：颜色、渐变、`_cm`/`_pt` 换算、字体回退链常量。
2. [x] 重写 `themes/ysu-beamer.typ` 骨架：`ysu-theme`（config-page/common/methods/colors/store/info）、`slide` 包装器（`sub`/`takeaway` 参数、`align`、预留 `after` 钩子供备注使用）、页眉、页脚。先用一张内容页跑通编译。
3. [x] 结构页：`title-slide` → `outline-slide` → `chapter-opener` + `new-section-slide` → `ending-slide`，每完成一个就渲染 PNG 与原稿对应页比对。
4. [x] 新建 `themes/components.typ`：按 visual-spec §5 表顺序实现组件；每个组件在临时测试页编译通过。
5. [x] 移除 `cuti` 导入；检查粗体渲染（Source Han Sans / YaHei 回退）。
6. [x] 改写 `examples/beamer-ysu.typ`（design §7），重编 `examples/beamer-ysu.pdf`。
7. [x] 迁移 `template/main.typ` 到新 API（保留 MIT-0 头注释；import 版本暂不动，由 release 子任务统一）。用本地相对导入临时验证可编译后恢复包导入。
8. [x] 4:3 编译检查。
9. [x] 更新 `.trellis/spec/theme/theme-architecture.md` 与 `typography-and-style.md` 草稿（release 子任务终审）。

## 验证命令

```bash
typst compile --root . examples/beamer-ysu.typ
typst compile --root . --format png --ppi 72 examples/beamer-ysu.typ ".tmp/ysu-core/page-{0p}.png"
```

（`.tmp/` 已在根 `.gitignore` 中。）

## 复核门

- 结构页 5 张与原稿目视比对通过后，才开始组件库。
- 组件库完成后跑一次 trellis-check。

## 回滚点

- 步骤 2 前的 `themes/ysu-beamer.typ` 即 0.2.0 版本；本子任务单独提交，可整体 revert。

## 执行记录与偏差（2026-10-27）

- 步骤 1：未建 `_cm`/`_pt` 换算——页面直接设为 16cm×9cm（4:3 为 12cm×9cm），原稿坐标即字面 cm/pt，无需换算。
- 步骤 2：`slide` 未预留 `after` 钩子。备注页的追加方式由 speaker-notes 子任务的 spike（方案 A/B/C）决定，届时在该任务内改 `slide`，避免先写一个可能用不上的扩展点。
- 步骤 5：`cuti` 已移除，CJK 字体链为思源黑体/Noto Sans SC/微软雅黑，均有真粗体，无需伪粗。README / AGENTS.md 中的 cuti 描述由 release 子任务同步。
- 本机未装 Source Sans 3，编译有 `unknown font family: source sans 3` 警告（回退 Arial，非错误）；release 子任务在 README 中说明。
- trellis-check：补 `3.4 标签与图标` 演示页，覆盖 `tag`/`tab-pill`/`edge-label`/`icon-disc`/`tblock`/`eq-number`/`logo`；修正 `icon-disc` 行内基线（原 `baseline: 0.3*size` 使圆标低于文字约半个直径）。
- 已知内容问题：4:3 窄栏中公式 (4-2) 与编号贴近，属示例内容排布，不改组件。
