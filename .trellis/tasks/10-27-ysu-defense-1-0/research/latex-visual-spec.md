# LaTeX 预答辩稿视觉规范（复刻依据）

来源目录：`D:\Documents\LYH\200-Learning\00博士毕业\毕业论文\thesis\slides\deck`（下称“原稿”）。
只读分析。原稿 16:9，`ctexbeamer` 11pt，纸面 16cm × 9cm；下文几何单位均以此纸面为准，Typst 中按 `16cm × 9cm` 等比换算（touying `presentation-16-9` 为 841.89pt × 473.56pt，比例系数 ≈ 1.856）。

## 1. 文件分层

| 文件 | 作用 | 复刻关系 |
|---|---|---|
| `defense.tex` | 驱动：元数据（题名、作者、导师、专业、学院、日期、阶段）+ 7 章列表 + `\input` 9 个分章文件 | 对应 `examples/beamer-thesis/main.typ` |
| `beamerthemeYanshanDefense.sty` / `defense-layouts.sty` | 技能生成的基础层（旧版居中双线页眉、蓝椭圆目录） | 已被下一层全部覆盖，不复刻 |
| `ysu-defense-modern.sty`（7605 行） | 手写现代样式层：令牌、页眉页脚、封面、目录、章节扉页、致谢、约 30 类组件，以及大量“单页专用”版式宏 | 通用部分进入主题；单页专用版式在示例中用主题组件拼装 |
| `chapters/*.tex` | 88 帧正文（`% defense-frame: id=... layout=...` 注释标记帧 id） | 逐帧复刻，帧 id 保留为 Typst 注释/标签 |
| `../deck-notes/chapters/*.tex` | 同一 88 帧 + 每帧 `\note{...}` 口播 | 口播搬入 Typst `#note[...]` |
| `preview/page-NNN.png`、`contact-sheet.png` | 原稿逐页渲染图 | 目视对照基准 |

原稿不使用 overlay/`\pause`：一帧一页（`deck/AGENTS.md` 明确撤回了分步揭示，因为揭示页没有独立备注页会打断 FerroStage 版式）。

## 2. 色彩令牌（`ysu-defense-modern.sty` §Theme v2 tokens）

| 令牌 | 值 | 用途 |
|---|---|---|
| `ysuNavy` | `#1F296A` | 主色：标题、强调、条、圆点、卡片头 |
| `ysuRed` | `#B42318` | 红：标题短线、章节号装饰线、问题/局限标签、关键结论（每页 ≤ 3 组） |
| `ysuInk` | `#1B1E2B` | 正文 |
| `ysuMuted` | `#5A6072` | 次要文字、图注、面包屑、页脚 |
| `ysuTint` | `#F2F4F9` | 浅底（卡片体、基底条、分组背景） |
| `ysuLine` | `#D9DCE5` | 细线、子框边框 |
| `ysuBase` | `#A9B1C9` | 目录非重点章号、面包屑分隔符 |
| `ysuNight` | `#0E1433` | 深夜蓝（45° 渐变起点、扉页径向渐变外圈、截图窗框） |
| `ysuNightDot` | `#3A4370` | 截图窗框圆点 |
| `ysuKicker` | `white!78!ysuNavy` ≈ `#CDCFDD` | 深底上的小标签字 |
| `ysuFaint` | `white!55!ysuNavy` ≈ `#8E97C4` | 深底上的弱文字 |

混色写法 `ysuNavy!12` = 12% navy + 88% white，Typst 用 `navy.lighten(88%)` 或 `color.mix((navy, 12%), (white, 88%))`。

渐变（TikZ shading，均只用两色）：
- `grad head`：navy → navy!80!tint（标题框头，水平）
- `grad bar`：navy → navy!85!night（结论条，水平）
- `grad key`：navy → red
- `grad page`：navy → navy!70!white（页码平行四边形）
- `grad diag`：night（左下）→ navy（右上），45°（封面右栏、目录左栏、致谢顶栏）
- 扉页：径向，中心偏右下 navy，外圈 night

## 3. 字体与字号

- 中文：Source Han Sans SC（回退 Source Han Sans CN → FandolHei）；本机 Typst 可见族名为 `Source Han Sans`、`Noto Sans SC`、`Microsoft YaHei`。
- 西文：Source Sans 3（回退 TeX Gyre Heros），等宽 lining 数字；本机未安装 Source Sans 3，回退 Arial。
- 数学：serif 数学字体（Typst 默认 New Computer Modern Math 即可）。
- “heavy” 900 字重：封面题名、扉页章节号/章名；无 Heavy 字面时退为 bold。
- 字号（pt，16cm 纸面）：正文 `\small`≈10；页眉主标题 14/17 bold navy；面包屑 6.5 muted；页脚 5.5；扉页章节号 77；扉页章名 16；封面题名 15.5；目录行 9.5；卡片标题 10；全宽列表 `\large`、列内列表基础字号。
- 列表符号：navy 实心小方块（一级 0.36em，二级 0.26em）。

## 4. 结构页几何

### 4.1 内容页页眉（`frametitle[ysu]`）

- 左上（x=0.8cm, y=0.33cm）：面包屑 `帧标题 / 小节`，6.5pt muted，分隔符 ` / ` 为 ysuBase。
- 右上（右边距 0.8cm, y=0.33cm）：校徽 `ysu-seal.png`，高 0.42cm。
- 主标题（x=0.8cm, y 顶 0.60cm，宽 13.6cm）：14/17pt bold navy，可换行，每多一行下移 17pt。
- 主标题逻辑：有结论句（`\DefenseTakeaway`）时，面包屑 = 帧标题 + 小节，主标题 = 结论句；无结论句时，面包屑 = 小节，主标题 = 帧标题。
- 标题下线：全宽 0.4pt ysuLine 细线，左端叠 0.9cm × 3pt 红色短线（固定装饰，不计入红色预算）。
- 正文：默认垂直居中于页眉与页脚之间（`\beamer@centeredtrue`），`[t]` 帧顶对齐。

### 4.2 页脚（`footline[ysu]`，高 0.45cm）

- 顶部全宽 0.4pt ysuLine 细线。
- 左（x=0.8cm）：`作者 · 博士学位论文预答辩`，5.5pt muted。
- 中：7 章短标签导航（绪论 框架 感知 预测 优化 平台 结论），当前章 navy bold + 下划线 0.7pt，其他 muted，间距 0.275cm。
- 右：`页码 / 总页数` 白字 bold，底为 navy→navy!70!white 渐变的小平行四边形。
- `[plain]` 帧（封面、目录、扉页、致谢）无页脚。

### 4.3 封面（`defense@titlepage`）

- 左白栏 0–10.25cm：左上校标（彩色校徽+校名组合，高 0.75cm，x=0.8 y=0.7）；阶段标签“博士学位论文预答辩”为 navy 倒梯形标签（中心 x=5.125 y=2.75，10.5pt bold 白字）；题名 15.5/20 heavy navy 居中，宽 9.2cm，顶 y=3.3，保留 `\\` 断行；题名下 0.9cm × 0.05cm 红短线；“汇报人：XXX” navy 胶囊（tab pill，11.5pt bold，中心 y=6.2）；两行信息 12pt：导师/专业（y=7.25）、学院/日期（y=8.1），左列 x=0.8、右列 x=5.45。
- 右深栏 10.25cm–16cm：45° grad diag；白色校徽水印 opacity 0.09（中心 14.625, 1.75，宽 5.75cm，裁切在栏内）；`RESEARCH LINE` 小字（x=10.9 y=4.81）；四条细线间隔三行“03 [icon] 状态感知 / 04 联合预测 / 05 动态优化”（9.2pt bold 白字）；底部 `Yanshan University · Doctoral Pre-defense`。

### 4.4 总目录（`\DefenseTocFrame{0}`）

- 左栏 0–4.25cm：grad diag；“目 录” 21pt heavy 白（0.6, 0.8）；`CONTENTS` 字距小字；底部白色校标组合（宽 2.625cm, opacity 0.9）。
- 右侧 7 行：行距 0.8cm，第 3、6 行前各多 0.2cm；章号 12pt bold（x=5.85，两位数），章名 9.5pt（x=6.85）。
- 核心章（3–5）分组：ysuTint 圆角底（5.05–15.1cm）；行首 navy 圆点白图标（x=5.45）；章号红色；章名 bold；行末 navy 胶囊标签（状态感知/联合预测/动态优化，右对齐 14.8cm）；组内行间 ysuLine 细线。
- 非核心章：章号 ysuBase，章名常规；行间细线 `ysuLine!60`。

### 4.5 章节扉页（`\ysuChapterOpener` + `\DefenseTocFrame{k}`）

- 全页径向渐变（navy 中心 → night 边缘）；白色校徽水印（14.2, 6.6，宽 5.5cm，opacity 0.08）；右上白色校标组合（高 0.5cm）。
- 左：两位数章节号 77pt heavy 白（0.85, 1.0），基线下 0.25cm 处 1.2cm × 3pt 红线。
- 右块（x=5.25，宽 9.85cm，顶 1.05cm）：章名 16/21 heavy 白（超 17 字时按 10.5em 宽断行）；0.4pt 分隔线；同一行左“本 章 问 题”红色小标签、右三个白描边关键词胶囊（可带图标）；问题句 9.5/14 白，`\ysuHL` 白色 bold。
- “本 章 内 容”（y=4.8）：kicker 小字在左栏；右侧逐行“[图标圆点] 1.1 研究背景与意义”，行距 0.44cm。
- “承 接 · 输 出”（y=7.55）：输入/输出一句，kicker 色，`\ysuHL` 白 bold。
- 底部进度（y=8.025）：7 段，每段宽 1.94cm、间隔 0.1cm、高 0.05cm；当前章白色+bold 标签，已过章 white!55!navy，未到章 white!18!navy；标签 `01 绪论`、`03 状态感知` 等全称（`navfull`）。

### 4.6 致谢页（`\ysuThanksRecap` + `\ysuThanksTags` + `\DefenseThanksFrame`）

- 顶栏 0–2.65cm grad diag；白校徽水印；`THANK YOU` 字距小字；“敬请各位老师批评指正” 21pt heavy 白（字间 0.06em）；右侧白色校标。
- 三张标题框 T（x=0.9/5.8/10.7，宽 4.4cm，高 4.35cm，顶 y=3.05）：渐变头“[图标] 状态感知 … 第 3 章”，正文 10.5/17 贡献句，底部 navy!12 小标签行。
- 底行（y=8.3）：`答辩人 李永航  指导教师 郝晓辰 教授`（muted 标签 + ink bold 值），右侧日期。

## 5. 组件库（主题需提供的通用组件）

字母编号沿用原稿注释（parent design.md 的组件代号），便于对照。

| 代号 | LaTeX 宏 | 视觉 | 建议 Typst 名 |
|---|---|---|---|
| HL | `\ysuHL{}` | navy bold，不断行 | `hl[...]` |
| Key | `\ysuKey{}` | red bold（本页关键结论，≤1） | `key[...]` |
| C | `\ysuConclude[label=,redlabel=,pill=]{}` | 全宽结论条，navy→深 navy 渐变，出血到页边；白字，前置白箭头；可带白描边标签/红标签与右端胶囊 | `conclude(label:, red-label:, pill:)[...]` |
| T | `\ysuTitleBox[icon]{title}{body}` | 渐变头 0.6cm + 白色 10pt bold 标题（可选图标），ysuTint 体，navy!35 边，3pt 圆角 | `title-box(icon:, title:)[...]` |
| P | `\ysuGroupBox[*][label]{}` | navy!6 底、navy!45 0.8pt 边、6pt 圆角；边上 navy（或红）标签 | `group-box(label:, red: false)[...]` |
| — | `\ysuSubBox{}` / `\ysuDashBox{}` | 白底 ysuLine 边 / navy!55 虚线边 子框 | `sub-box[...]` / `dash-box[...]` |
| K | `\ysuLabelRow[dash]{label}{content}` | 左 1.3cm navy 标签块（两字一行）+ 右子框，等高 | `label-row(label:, dashed:)[...]` |
| W | `\ysuBlockArrow{}` / `\ysuBlockArrowV` | 空心粗箭头，ysuTint 填充 navy 边，箭身上 2–4 字 | `block-arrow[...]` |
| H | `\ysuRedFrame{label}{text}` | 白底红边框句，左侧红标签，navy 字；与 C 互斥 | `red-frame(label:)[...]` |
| J | `\ysuBaseBar{}` | 全宽 ysuTint 条，上下 1pt navy 线，11pt bold navy 居中，出血 | `base-bar[...]` |
| N | `\ysuSectionBar[icon]{name}` | navy 圆点白图标 + 11pt bold navy 名称 + 右侧细线 | `section-bar(icon:)[...]` |
| F | `\ysuTagRed` / `\ysuTagNavy` / tagline / pill | 红 10% 底红字 / navy 12% 底 navy 字 / 白描边 | `tag(kind: "red"\|"navy"\|"line")[...]`、`pill[...]` |
| D | 编号点 `\ysu@dmark` | `01 02 …` navy bold 等宽数字，每页重置，续行悬挂缩进 | `points(..items)` |
| E | KPI 卡 | 顶部 3pt navy 线、无框；muted 标签 + 大号 navy 数值 + 依据行 | `kpi(label:, value:, basis:)` |
| A | `ysu card top` | 白底 ysuLine 边卡片，顶部 2.5pt 色条 | `card(accent:)[...]` |
| B | 公式块 | ysuTint 底块承载公式 + 读法；公式编号 muted small | `eq-block(note:)[...]` |
| Card | `\DefenseCard{label}{text}` | 左 2.35cm navy 圆角标签 + 右 ysuSky 底卡片，左 2pt navy 竖条 | `side-card(label:)[...]` |
| Paper | `\DefensePaperBox{}` | 左 1.3cm navy“论文”标签 + 右浅底书目（截到 `DOI:` 前） | `paper-box[...]` |
| Fig | `\DefenseFigure[opt]{file}{caption}` | 居中图，高上限 0.66 文本高（竖图 0.67），muted footnotesize 图注 | `figure-box(img, caption:)` |
| Screen | `\ysuScreenNext` + 截图窗 | ysuNight 圆角窗框 + 三个 ysuNightDot 圆点 + 标题，内嵌现场截图 | `screen-frame(title:)[img]` |
| Table | 结果表样式（task 10-14） | navy 表头白字、三线、本文模型行 navy!8 着色（`\ysuTableMark`） | `result-table(...)` 或 show 规则 + `mark-row` |
| Notes | `\ysuReadingNote` 等 | 读图卡：ysuTint 底、标题 navy bold、正文 9pt | `reading-card(title:)[...]` |
| Icon disc | `\ysu@icondisc` | navy 圆 0.42cm 白图标 | `icon-disc(icon)` |

设计约束（原稿 `design.md §2–§3.4` 注释）：每页语义红 ≤ 3 组；框组 ≤ 3 组、≤ 2 层；C 与 H 互斥且每页 ≤ 1；渐变只用两色、水平或 45°。

## 6. 单页专用版式（示例中拼装，不进主题）

原稿约 60% 的行数是按页定制的版式宏（如 `\ysuEvoRail/\ysuEvoStage/\ysuEvoConclude` 研究现状演进栏、`\ysuProblemMap*` 问题图、`\ysuRoadmap*` 技术路线、`\ysuPlant*` 产线照片页、`\ysuDiffCard*`、`\ysuEqMap`、`\ysuTimeAxis`、`\ysuInnovation*` 等）。这些在 `examples/beamer-thesis/lib/` 下用主题组件 + Typst `grid`/`place` 实现为示例局部函数；若某版式在 ≥ 3 页复用且与论文内容无关，再考虑上提到主题。

逐帧使用的宏见 `frame-inventory.md`。

## 7. 图标

原稿用 Font Awesome 5 Solid，语义名映射：process→industry, lab→flask, data→database, clock→clock, sense→eye, forecast→chart-line, optimize→sliders-h, target→bullseye, energy→bolt, fuel→fire, shield→shield-alt, platform→server, layers→layer-group, model→project-diagram, problem→exclamation-triangle, idea→lightbulb, paper→file-alt, award→award, flow→random。

决策（用户 2026-10-27）：主题所有图标参数接收任意 content；包内不引入图标依赖或素材。示例可用 `@preview/fontawesome`（需本机安装 FA Free 字体），未安装时以章节号圆点或纯文字退化。

## 8. 品牌素材映射

| 原稿文件 | 仓库内对应 |
|---|---|
| `slides/assets/brand/ysu-seal.png` | `themes/assets/ysu-seal.png` |
| `slides/assets/brand/ysu-seal-white.png` | `themes/assets/ysu-seal-white.png` |
| `slides/assets/brand/ysu-logo-white.png`（校徽+校名白色横排） | 组合 `ysu-seal-white.png` + `ysu-wordmark-only-white.png` |
| `fig/ysu_logo.png`（彩色横排校标） | 组合 `ysu-seal.png` + `ysu-wordmark-only.png` |

不新增品牌位图（AGENTS.md §5.1）。

## 9. 渲染对照截图

关键页：P01 封面、P02 总目录、P03 第 1 章扉页、P06 图+难点卡+结论条、P07 研究现状演进栏、P10 问题图、P21 三重瓶颈（group box + red frame）、P47 结果表+KPI 卡、P77 现场截图+编号点、P88 致谢。路径 `thesis/slides/deck/preview/page-NNN.png`。
