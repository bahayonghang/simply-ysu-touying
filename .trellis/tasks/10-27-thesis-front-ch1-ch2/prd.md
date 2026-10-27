# 复刻一：工程骨架、封面目录与第 1-2 章

父任务：`10-27-ysu-defense-1-0`（design §6 示例结构；逐帧清单 `research/frame-inventory.md` P01–P18）。依赖 theme-core、speaker-notes。

## Goal

搭建 `examples/beamer-thesis/` 复刻工程（入口、分章文件、示例局部版式库、图标表、素材同步、口播导出），并逐页复刻原稿 P01–P18 与对应口播。后两个复刻子任务沿用本任务定下的工程约定。

## 范围（18 帧）

| 页 | 帧 id | 原稿版式 |
|---|---|---|
| P01 | cover | 封面 |
| P02 | toc | 总目录（第 3–5 章高亮分组） |
| P03 | c1-toc | 第 1 章扉页 |
| P04 | c1-background-1 | 级联行：数据图 + 研究聚焦链 |
| P05 | c1-plant | 产线照片页（主图 + 三缩略图 + 侧栏目标） |
| P06 | c1-background-2 | 工艺示意图 + 三难点卡 + 结论条 |
| P07–P09 | c1-status-* | 研究现状演进栏（4 阶段 × 优势/局限 + 局限/趋势条） |
| P10 | c1-challenges | 问题图（三问题 + 草图 + 研究内容 + 基底条 + 研究目的红框） |
| P11 | c1-organization | 技术路线（横幅 + 两侧框 + 三列 + 连接） |
| P12 | c2-toc | 第 2 章扉页 |
| P13–P18 | c2-* | 图文页、变量表、流程页、公式+图详解页 |

## Requirements

1. 工程结构按父 design §6；`main.typ` 中元数据与原稿 `defense.tex` 完全一致（题名含断行、作者、导师、专业、学院、日期 2026/10/23、阶段预答辩、7 章章名）。
2. 素材：`sync-assets.py` 从论文根复制本批及后续引用到的图片，优先 `slides/deck/.build-img/` 降采样副本，否则取 `fig/` 或 `slides/assets/` 原件；保持相对路径；报告缺失并非零退出。
3. 图标：`lib/icons.typ` 提供原稿 19 个语义名（visual-spec §7）；优先 `@preview/fontawesome`，字体不可用时给出无图标退化（扉页用章节号圆点、目录/卡片省略图标）。
4. 逐页复刻：文字、数字、标点与原稿 `.tex` 一致（`\ysuHL` → `hl`，`\ysuKey` → `key`，`\\` 断行保留）；版式与 `preview/page-NNN.png` 目视一致。
5. 单页专用版式写在 `lib/layouts.typ`，函数名去掉 `ysu` 前缀，参数与原宏一一对应，便于后续批次复用（演进栏、问题图、技术路线、产线页等）。
6. 口播：18 条 `#note` 内容与 `deck-notes/chapters/{front,chapter1,chapter2}.tex` 一致（`\%` → `%`，`$...$` 行内公式转 Typst 数学，`\textbf{}` → `*...*`）。
7. `export-speech.py`：调用 `typst query` 生成 `speech.md`，结构与原稿 `deck-notes/speech.md` 一致；对本批 18 页逐字比对通过（允许全角空格等空白差异）。
8. `README.md`（示例目录内）：同步、编译、备注版、导出命令。
9. 记录偏离点：任何“不合适可优化”的改动写入 `research/deviations.md`（页号、原稿做法、Typst 做法、原因）。

## Acceptance Criteria

- [ ] `python -I examples/beamer-thesis/sync-assets.py` 成功，无缺失。
- [ ] `typst compile --root . examples/beamer-thesis/main.typ` 生成 18 页（本批完成时）。
- [ ] 备注版 36 页，`examples/check-page-labels.py --expect-notes` 通过。
- [ ] P01–P18 目视对照记录写入 `research/visual-diff.md`，无未解释的明显偏差。
- [ ] `export-speech.py` 输出与原稿 `speech.md` 前 18 页一致。
- [ ] 本批编译耗时记录。
- [ ] `git status` 中 `examples/beamer-thesis/` 不出现（已被忽略）。
