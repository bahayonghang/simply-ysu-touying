# YSU 答辩主题 1.0.0：复刻预答辩 Beamer

## Goal

现有 `ysu-theme`（浅蓝 `#2B69C1`、楷体、顶部导航胶囊）视觉偏朴素。用户的 LaTeX 预答辩稿（`thesis/slides/deck`，88 页）已经形成一套成熟的现代藏青答辩版式，但 XeLaTeX + TikZ 每次重编很慢。本任务把这套版式移植为 Typst/Touying 主题，替换现有 `ysu-theme`，同时学习 `deck-notes` 的独立备注页写法与 FerroStage 兼容契约，并在 `examples/beamer-thesis/` 用 Typst 全量复刻 88 页预答辩稿作为验证。完成后发布 `simply-ysu-touying` 1.0.0。

## 用户决策（2026-10-27）

- **D1 主题架构**：直接替换旧主题。`themes/ysu-beamer.typ` 整体重写为新版式，沿用 `ysu-theme`、`title-slide`、`outline-slide`、`new-section-slide`、`ending-slide`、`slide`、`tblock` 等公开 API 名；旧外观不再提供。1.0.0 允许破坏性变更。
- **D2 复刻范围**：88 页全量，按章节分批子任务交付，每批独立验证。
- **D3 图标**：主题所有图标参数接收任意 `content`；包内不引入图标依赖或图标素材。示例可自行选择图标来源。
- **D4 Notes**：学习 `deck-notes` 的 `\note` 写法与独立备注页功能（见 `research/notes-contract.md`）。
- **D5 版本**：版本号升级为 `1.0.0`。

## Requirements

### R1 主题（替换 `ysu-theme`）
- 色彩、字体、字号、渐变令牌与原稿一致（`research/latex-visual-spec.md` §2–§3）。
- 结构页：内容页页眉（面包屑 + 校徽 + 结论句主标题 + 红短线）、页脚（作者·阶段、章节短标签导航、渐变页码）、封面、总目录、章节扉页、致谢（含三贡献回顾版）均可由公开 API 生成，几何与原稿目视一致。
- 组件库覆盖 visual-spec §5 表中的通用组件。
- 元数据通过 `config-info` 传入（含 `stage`、`supervisor`、`subject`、`school` 等扩展键），章节信息由一级标题驱动。
- 保留 Touying 能力：`composer` 多栏、`#pause`、`config-*` 覆盖、4:3 比例可用（4:3 只要求不崩溃、不溢出，不要求精确对齐原稿）。
- 品牌素材只用 `themes/assets/` 现有位图组合，不新增位图。

### R2 演讲备注
- 提供 `#note[...]` 写法，内容可含段落、加粗、行内公式。
- 默认关闭；开启后每个内容页后紧跟一张独立备注页，页标签 `N` / `notes:N`，尺寸 16cm × 13.5cm，深色纸面配色与 18pt 排版同原稿。
- 开启备注不改变内容页的页码与总页数显示。
- 与 touying `speaker-note` / pdfpc 导出兼容。
- 可用 `typst query` 导出逐页口播，并由示例脚本生成与原稿 `speech.md` 同结构的打印稿。

### R3 示例 `examples/beamer-thesis/`
- 88 页逐页复刻原稿，页序、帧标题、结论句、正文文字、数字、公式、表体、图片与原稿一致；88 条口播全部搬入。
- 图片沿用论文的相对路径结构（`fig/...`、`slides/assets/...`），由同步脚本从论文目录复制到示例目录；该目录已被 `examples/.gitignore` 忽略，论文内容不进入仓库。
- 单页专用版式在示例内用主题组件拼装，不污染主题公开 API。
- 不合适之处可优化（例如 LaTeX 为规避 TeX 限制写的硬编码偏移），但需在子任务中记录偏离点。

### R4 发布 1.0.0
- `typst.toml`、`template/main.typ`（当前误为 `0.1.0`）、`README.md`、`README.zh.md`、`docs/typst-packages-pr-structure.md`、`AGENTS.md` 中的版本号统一为 `1.0.0`。
- 模板、`examples/beamer-ysu.typ`、`thumbnail.png`、`template/main.pdf`、`examples/beamer-ysu.pdf` 改用新主题重新生成。
- `.trellis/spec/theme/*`、`.trellis/spec/package/*` 同步新架构与新色彩规范。

## 子任务映射

| 子任务 | 交付 | 依赖 |
|---|---|---|
| `10-27-theme-core` | R1 全部；迁移 `beamer-ysu.typ` 与模板到新 API | 无 |
| `10-27-speaker-notes` | R2 全部 | theme-core 的 `slide` 包装器 |
| `10-27-thesis-front-ch1-ch2` | 示例工程骨架、素材同步脚本、P01–P18（封面、总目录、第 1 章 9 帧、第 2 章 7 帧）+ 口播 | theme-core、speaker-notes |
| `10-27-thesis-ch3-ch4` | P19–P51（第 3 章 19 帧、第 4 章 14 帧）+ 口播 | thesis-front-ch1-ch2 的骨架 |
| `10-27-thesis-ch5-ch7-back` | P52–P88（第 5 章 21、第 6 章 11、第 7 章 4、致谢 1）+ 口播；88 页全量对照 | thesis-ch3-ch4 |
| `10-27-release-1-0-0` | R4 全部 | 以上全部 |

页号以 `research/frame-inventory.md` 为准（front 2 + ch1 9 + ch2 7 + ch3 19 + ch4 14 + ch5 21 + ch6 11 + ch7 4 + back 1 = 88）。

## Acceptance Criteria（跨子任务）

- [ ] `typst compile --root . examples/beamer-ysu.typ` 与 `typst compile template/main.typ`（经本地包路径）通过，无警告级字体缺失之外的错误。
- [ ] `typst compile --root . examples/beamer-thesis/main.typ` 生成 88 页；开启备注后生成 176 页，页标签为 `1, notes:1, …, 88, notes:88`。
- [ ] 88 页与 `thesis/slides/deck/preview/page-NNN.png` 逐页目视对照，结构页与关键组件页无明显偏差；偏差清单记录在各复刻子任务。
- [ ] 全量编译耗时记录在案，并显著短于原稿 XeLaTeX 编译（原稿耗时以用户实测为准）。
- [ ] 包体仍只含 `lib.typ`、`themes/`、`template/`、`typst.toml`、`thumbnail.png`、`README.md`、`LICENSE`、`LICENSE-MIT-0.txt`；`thumbnail.png` 不被引用；无新增品牌位图。
- [ ] 版本号检查命令（`.trellis/spec/package/verification-and-release.md` §2）全部输出 `1.0.0`。
- [ ] 本地 Universe 模拟（`typst init --package-path …`）成功。

## Out of Scope

- 原稿的 PDF 页面切换动画（`\transfade` 等）：Typst 不支持写 `/Trans`，不复刻。
- 原稿 `build_deck.py` / `defense_assets inject` / `notes-sync` 的生成流水线：Typst 版本直接手写源文件，不复刻生成器。
- PDF 书签大纲的三级结构（原稿用 `\bookmark` 手写）：Typst 由标题自动生成，接受差异。
- 把论文图片、口播文字提交进本仓库。
