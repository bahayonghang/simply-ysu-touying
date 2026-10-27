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

本项目为燕山大学（Yanshan University, YSU）专属的 Typst 幻灯片主题包，基于 [Touying](https://touying-typ.github.io/touying/zh/) 构建，面向中文学术汇报场景（课程展示、组会汇报、开题/中期/毕业答辩、学术研讨等）设计。

- **Typst Universe 包名**：`simply-ysu-touying`
- **代码仓库**：`touying-theme-ysu`
- **当前版本**：`0.2.0`（参见 `typst.toml`）
- **核心定位**：提供开箱即用、视觉规范且符合中文学术习惯的幻灯片模板与主题组件。

---

## 1. 技术栈与环境规范

- **排版引擎**：Typst `0.14.x` / `0.15.x`（`typst.toml` 编译器基线为 `0.14.0`）
- **核心依赖包**：
  - `@preview/touying:0.6.3`：Typst 现代演示文稿框架
  - `@preview/cuti:0.4.0`：中文排版支持库（主要使用 `show-cn-fakebold` 实现伪粗体渲染）
- **字体规范**：
  - 西文/数字：`Times New Roman`, `Arial`
  - 中文字体：`KaiTi`（楷体）, `STKaiti`, `LXGW WenKai`, `Microsoft YaHei`（微软雅黑）
  - 中文排版：`set text(lang: "zh")`，段落两端对齐 `justify: true`
- **色彩规范 (燕大蓝主题色系)**：
  - `primary`: `#2B69C1`（主色调，用于导航、高亮、装饰条）
  - `primary-dark`: `#1F4F94`（深蓝，用于卡片标题栏、四级标题）
  - `primary-darker` / `primary-darkest`: `#163A70` / `#102744`（幻灯片大标题、深底文字）
  - `primary-light`: `#78A4E7`（边框与次要轮廓）
  - `primary-lighter`: `#DCE8FA`（卡片装饰渐变、当前章节高亮背景）
  - `primary-lightest`: `#F6F9FF`（卡片内容区背景、列表项渐变）
  - 辅助色：`secondary` (`#173A72`), `tertiary` (`#4D88D6`), `neutral-*`（文本与白底调和）

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
│   ├── ysu-beamer.typ         # 主题核心实现（定义 ysu-theme、幻灯片包装器、导航栏与页脚）
│   └── assets/                # 运行时必需的燕大品牌视觉位图（严控体积与清单）
│       ├── ysu-seal.png               # 校徽（浅色背景）
│       ├── ysu-seal-white.png         # 校徽（深色背景/反白）
│       ├── ysu-wordmark-only.png      # 纯校名中英文（浅色背景）
│       ├── ysu-wordmark-only-white.png# 纯校名中英文（深色背景/反白）
│       └── ysu-watermark.png          # 页面右下角低对比度背景水印
├── template/
│   ├── main.typ               # typst init 初始化生成的演示模板文件
│   └── main.pdf               # 模板预编译样例
├── examples/
│   ├── beamer-ysu.typ         # 仓库内置完整特性示例（多栏、表格、暂停动画、图表等）
│   └── beamer-ysu.pdf         # 示例编译导出的完整 PDF
└── docs/                      # 提交 PR 指引与截图（排除在发布包外）
    ├── typst-packages-pr-structure.md # Typst Universe 提交流程与目录结构
    └── screenshots/           # README 使用的外部截图
```

---

## 3. 常用开发与验证命令

在修改主题逻辑或示例后，必须执行以下验证命令确保编译通过：

```bash
# 1. 编译仓库完整特性示例（必须加 --root . 以正确解析绝对/相对路径资源）
typst compile --root . examples/beamer-ysu.typ

# 2. 编译模板入口文件验证语法与导入
typst compile template/main.typ

# 3. 模拟 Typst Universe 本地包验证（测试 typst init 流程）
# 参考 docs/typst-packages-pr-structure.md 中的步骤进行本地联调：
typst init --package-path <local-package-root> @preview/simply-ysu-touying:0.2.0 my-slides
typst compile --package-path <local-package-root> my-slides/main.typ
```

---

## 4. 主题核心 API 与排版规范

### 4.1 主题初始化 (`ysu-theme`)

```typ
#import "@preview/simply-ysu-touying:0.2.0": *

#show: ysu-theme.with(
  aspect-ratio: "16-9",          // 幻灯片比例（默认 16:9，支持 "4-3"）
  watermark: true,               // 是否开启右下角燕大水印
  progress-bar: true,            // 是否启用顶部进度条
  config-info(
    title: [报告标题],
    short-title: [页脚短标题],     // 若不填则自动使用 title
    subtitle: [副标题],
    author: [报告人姓名],
    institution: [燕山大学\ 学院/系所名称],
    date: datetime.today(),
  ),
)
```

### 4.2 常用幻灯片组件

- `#title-slide(extra: [...])`：封面页。自动排版顶部校标/校名、主标题、副标题、作者信息卡片及附加说明。
- `#outline-slide(title: [目录])`：目录页。自动检索正文中的一级标题（`= 标题`）并生成导航卡片，当前章节高亮。
- `= 一级标题`：自动生成分节过渡页（`new-section-slide`），并在后续页面顶部导航栏中常驻展示。
- `== 二级标题`：普通内容页。顶部呈现所属一级导航胶囊和当前二级标题。
- `#slide(composer: (1fr, 1fr))[...][...]`：自由内容页。支持 Touying 的 `composer` 参数进行多栏排版；支持 `#pause` 分步呈现。
- `#tblock(title: [...])[...]`：燕大蓝主题特色卡片/信息块。顶部带深蓝标头、渐变装饰条和浅蓝底色。
- `#ending-slide[致谢内容]`：封底/致谢页。带校徽、居中醒目感谢标语及附加信息。

---

## 5. 开发约束与注意事项 (Critical Rules for AI Agents)

1. **资源与许可边界 (Inviolable)**:
   - `themes/assets/` 下的 `ysu-*` 图像素材来自燕山大学公开视觉规范（VIS），**不受** `typst.toml` 中 `MIT AND MIT-0` 许可证授权。详见 `ASSETS.md`。
   - 严禁随意引入未经审核的外部图片或随意更改现有校徽/水印尺寸与位置。
   - `template/main.typ` 中的基础样例内容采用 `MIT-0` 授权（见 `LICENSE-MIT-0.txt`）。
2. **包发布边界 (`typst.toml` Exclude)**:
   - `typst.toml` 中的 `exclude = ["docs", "examples", "ASSETS.md", "README.zh.md", ".*"]` 必须严格维护。
   - 提交到 Typst Universe 的包体必须极致精简，仅包含 `lib.typ`、`themes/`、`template/`、`typst.toml`、`thumbnail.png`、`README.md`、`LICENSE` 及 `LICENSE-MIT-0.txt`。
   - `thumbnail.png` 必须保持无包内引用（Typst Universe 官方打包规范要求）。
3. **版本号同步一致性**:
   - 当发布新版本时，须同步核对并更新：`typst.toml` 的 `version`、`template/main.typ` 中的包引用版本、`README.md` / `README.zh.md` 中的命令示例、以及 `docs/typst-packages-pr-structure.md`。
4. **编译与样式安全性**:
   - 涉及 `themes/ysu-beamer.typ` 的改动，必须使用 `typst compile --root . examples/beamer-ysu.typ` 进行端到端回归验证，确认未破坏分页、页眉页脚计算、目录抓取及中文假粗体。
