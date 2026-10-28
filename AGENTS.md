<!-- TRELLIS:START -->
# Trellis Instructions

These instructions are for AI assistants working in this project.

This project is managed by Trellis. The working knowledge you need lives under `.trellis/`:

- `.trellis/workflow.md` — development phases, when to create tasks, skill routing
- `.trellis/spec/` — package- and layer-scoped coding guidelines (read before writing code in a given layer)
- `.trellis/workspace/` — per-developer journals and session traces
- `.trellis/tasks/` — active and archived tasks (PRDs, research, jsonl context)

If a Trellis command is available on your platform (e.g. `/trellis:finish-work`, `/trellis:continue`), prefer it over manual steps. Not every platform exposes every command.

If you're using Codex or another agent-capable tool, additional project-scoped helpers may live in:
- `.agents/skills/` — reusable Trellis skills
- `.codex/agents/` — optional custom subagents

Managed by Trellis. Edits outside this block are preserved; edits inside may be overwritten by a future `trellis update`.

<!-- TRELLIS:END -->

# simply-ysu-touying 项目指南 (AI Agent Context)

本项目为燕山大学（Yanshan University, YSU）专属的 Typst 幻灯片主题包，基于 [Touying](https://touying-typ.github.io/touying/zh/) 构建，面向中文学术汇报场景（课程展示、组会汇报、开题/中期/毕业答辩、学术研讨等）设计。0.2.0 版按博士学位论文答辩稿（LaTeX/Beamer）的版式重写。

- **Typst Universe 包名**：`simply-ysu-touying`
- **代码仓库**：`touying-theme-ysu`
- **当前版本**：`0.2.0`（参见 `typst.toml`）
- **核心定位**：提供开箱即用、视觉规范且符合中文学术习惯的答辩式幻灯片模板、组件库与演讲备注。

---

## 1. 技术栈与环境规范

- **排版引擎**：Typst `0.15.0` 及以上（`typst.toml` 的 `compiler` 为 `0.15.0`，与 Touying 0.8.0 和 Universe 包检查器一致；0.15.1 只有缺陷修复，没有新语法）
- **核心依赖包**：`@preview/touying:0.8.0`（唯一依赖；0.2.0 起不再使用 `cuti`，粗体用字体的真实字重）
- **字体规范**（`themes/tokens.typ`）：
  - 西文/数字：`Arial`（投影用无衬线；不把未安装的 `Source Sans 3` 放进默认列表）
  - 中文：`Source Han Sans` → `Noto Sans SC` → `Microsoft YaHei`（思源黑体优先；不用宋体，不用无真粗的黑体 SimHei）
  - 中文排版：`set text(lang: "zh", region: "cn")`，段落不两端对齐（`justify: false`）
  - 主题正文的文字边界为 `top-edge: "cap-height"`、`bottom-edge: "baseline"`；含分式的行内公式需包一层 `text(top-edge: "bounds", bottom-edge: "bounds", ...)`
- **色彩令牌**（`themes/tokens.typ`）：
  - `ysu-navy` `#1F296A`（主色）、`ysu-red` `#B42318`（强调与关键结论）
  - `ysu-ink` `#1B1E2B`（正文）、`ysu-muted` `#5A6072`（次要文字）
  - `ysu-tint` `#F2F4F9`（卡片底）、`ysu-line` `#D9DCE5`（细线）、`ysu-base` `#A9B1C9`
  - `ysu-night` `#0E1433` / `ysu-night-dot`（扉页、截图窗框）
  - 派生：`mix()`、`ysu-kicker`、`ysu-faint`；渐变 `grad-head`、`grad-bar`、`grad-key`、`grad-page`、`grad-diag`、`grad-opener`

---

## 2. 仓库架构与文件职责

```text
touying-theme-ysu/
├── typst.toml                 # Typst Universe 包元数据与 template 配置（发布时生效）
├── lib.typ                    # 包入口：重新导出 touying 与 themes/ysu-beamer.typ
├── thumbnail.png              # Typst Universe 展示预览图（禁止在包内排版代码中引用）
├── LICENSE                    # MIT 许可证（保留 QuadnucYard 与 Geekyhang 版权）
├── LICENSE-MIT-0.txt          # MIT No Attribution 许可证（template/main.typ 起始内容）
├── ASSETS.md                  # 品牌视觉资源的唯一权威说明（来源、转换记录与授权边界）
├── README.md / README.zh.md   # 英/中文用户使用文档
├── themes/
│   ├── ysu-beamer.typ         # 主题核心：ysu-theme、页眉页脚、结构页、页面标记、演讲备注
│   ├── components.typ         # 组件库（hl/key、卡片、分组框、结论条、KPI、图表公式、截图窗框等）
│   ├── tokens.typ             # 颜色、渐变、字体栈与校标函数 seal/wordmark/logo
│   └── assets/                # 燕大品牌视觉位图（严控体积与清单）
│       ├── ysu-seal.png / ysu-seal-white.png
│       ├── ysu-wordmark-only.png / ysu-wordmark-only-white.png
│       └── ysu-watermark.png
├── template/
│   ├── main.typ               # typst init 初始化生成的演示模板文件
│   └── main.pdf               # 模板预编译样例
├── examples/
│   ├── beamer-ysu.typ         # 全部组件的通用演示，也是回归基准
│   ├── beamer-ysu.pdf         # 示例编译导出的 PDF
│   ├── check-page-labels.py   # 备注版 PDF 页标签检查
│   └── beamer-thesis/         # 博士答辩稿复刻（被 examples/.gitignore 忽略，不入库）
└── docs/                      # 提交 PR 指引与截图（排除在发布包外）
    ├── typst-packages-pr-structure.md # Typst Universe 提交流程、目录结构与本地模拟脚本
    └── screenshots/           # README 使用的外部截图（cover / opener / content / minimal-example）
```

---

## 3. 常用开发与验证命令

在修改主题逻辑或示例后，必须执行以下验证命令确保编译通过：

```bash
# 1. 编译仓库完整特性示例（必须加 --root . 以正确解析绝对/相对路径资源）
typst compile --root . examples/beamer-ysu.typ
typst compile --root . --input ratio=4-3 examples/beamer-ysu.typ

# 2. 备注版与页标签检查
typst compile --root . --input notes=on examples/beamer-ysu.typ .tmp/notes.pdf
python -I examples/check-page-labels.py .tmp/notes.pdf --expect-notes

# 3. 模拟 Typst Universe 本地包验证（完整脚本见 docs/typst-packages-pr-structure.md）
typst init --package-path <local-package-root> @preview/simply-ysu-touying:0.2.0 my-slides
typst compile --package-path <local-package-root> my-slides/main.typ
```

---

## 4. 主题核心 API 与排版规范

### 4.1 主题初始化 (`ysu-theme`)

```typ
#import "@preview/simply-ysu-touying:0.2.0": *

#show: ysu-theme.with(
  aspect-ratio: "16-9",          // 16cm×9cm；"4-3" 为 12cm×9cm
  align: horizon,                // 正文竖直对齐
  nav-labels: ("背景", "方法", "总结"),  // 页脚章节导航短名（默认取一级标题）
  notes: sys.inputs.at("notes", default: "off") == "on",  // 备注页
  config-info(
    title: [报告标题],
    author: [报告人姓名],
    supervisor: [导师#h(1em)教授],
    subject: [学科专业],
    school: [学院名称],
    date: datetime.today(),
    stage: [学术汇报],
    stage-en: [Academic Presentation],
  ),
)
```

### 4.2 结构页、页面标记与组件

- `#title-slide(research-line: ..., note: ...)`：封面，左白右深，阶段标签与研究主线。
- `#outline-slide(groups: ..., note: ...)`：目录，一级标题自动成行，核心章节可分组高亮。
- `= 一级标题` + `#chapter-opener(question:, keywords:, icon:, outline:, bridge:)`：章节扉页。
- `== 二级标题`：内容页；`#sub[...]` 设面包屑小节，`#takeaway[...]` 设页眉结论句。
- `#slide(composer: (1fr, 1fr))[...][...]`：自由内容页，支持 `#pause`。
- `#ending-slide(recap: ((title:, chapter:, icon:, body:, tags:), ...), note: ...)`：致谢页（回顾卡）。
- `#note[...]`：演讲备注；`notes: true` 时每页后插入备注页，页标签 `N` / `notes:N`；`typst query ... "<ysu-note>"` 导出口播。
- 组件（`themes/components.typ`）：`hl`、`key`、`tag`、`pill`、`tab-pill`、`edge-label`、`icon-disc`、`conclude`、`base-bar`、`section-bar`、`title-box`（`tblock` 为别名）、`group-box`、`sub-box`、`dash-box`、`label-row`、`block-arrow`、`red-frame`、`card`、`side-card`、`paper-box`、`points`、`kpi`、`figure-box`、`fig-caption`、`eq-block`、`eq-number`、`reading-card`、`screen-frame`、`result-table`。

---

## 5. 开发约束与注意事项 (Critical Rules for AI Agents)

1. **资源与许可边界 (Inviolable)**:
   - `themes/assets/` 下的 `ysu-*` 图像素材来自燕山大学公开视觉规范（VIS），**不受** `typst.toml` 中 `MIT AND MIT-0` 许可证授权。详见 `ASSETS.md`。
   - 严禁随意引入未经审核的外部图片或随意更改现有校徽/水印尺寸与位置。
   - `template/main.typ` 中的基础样例内容采用 `MIT-0` 授权（见 `LICENSE-MIT-0.txt`）。
2. **包发布边界 (`typst.toml` Exclude)**:
   - `typst.toml` 中的 `exclude = ["docs", "examples", "ASSETS.md", "README.zh.md", ".*"]` 必须严格维护。
   - 提交到 Typst Universe 的包体必须极致精简，仅包含 `lib.typ`、`themes/`、`template/main.typ`、`typst.toml`、`thumbnail.png`、`README.md`、`LICENSE` 及 `LICENSE-MIT-0.txt`。
   - `thumbnail.png` 必须保持无包内引用（Typst Universe 官方打包规范要求）。
   - `examples/beamer-thesis/`（答辩稿复刻，含论文图片）不入库、不发布。
3. **版本号同步一致性**:
   - 当发布新版本时，须同步核对并更新：`typst.toml` 的 `version`、`template/main.typ` 中的包引用版本、`README.md` / `README.zh.md` 中的命令示例、`docs/typst-packages-pr-structure.md` 以及本文件。
   - 当前版本为 `0.2.0`。0.x 阶段的破坏性改动升次版本；到达 `1.0.0` 后，公开 API（`ysu-theme` 参数、结构页函数、组件名）按 semver 管理，破坏性改动升主版本。
4. **编译与样式安全性**:
   - 涉及 `themes/*.typ` 的改动，必须使用 `typst compile --root . examples/beamer-ysu.typ`（16:9 与 4:3）进行端到端回归验证，确认未破坏分页、页眉页脚、章节导航、目录抓取与备注页。
   - 函数参数不要取名 `center`、`top`、`left` 等对齐常量或 `v` 等内置函数名；若无法避免，在函数体内用 `std.center` 等访问内置值。
