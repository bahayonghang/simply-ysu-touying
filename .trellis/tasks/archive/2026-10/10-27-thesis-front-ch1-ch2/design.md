# Design：复刻工程骨架与 P01–P18

继承父任务 design §6。本文件定下三个复刻批次共用的工程约定。

## 1. 入口与分章

```typ
// examples/beamer-thesis/main.typ
#import "/lib.typ": *
#import "lib/icons.typ": icon
#import "lib/layouts.typ": *

#show: ysu-theme.with(
  notes: sys.inputs.at("notes", default: "off") == "on",
  nav-labels: ("绪论", "框架", "感知", "预测", "优化", "平台", "结论"),
  nav-full-labels: ("绪论", "框架", "状态感知", "联合预测", "动态优化", "平台", "结论"),
  config-info(title: [水泥烧成系统运行指标联合预测模型\ 与动态优化算法研究], author: [李永航],
    supervisor: [郝晓辰#h(1em)教授], subject: [仪器科学与技术], school: [电气工程学院],
    date: [2026/10/23], stage: [博士学位论文预答辩], stage-en: [Doctoral Pre-defense]),
)
#include "chapters/front.typ"
#include "chapters/ch1.typ"
… #include "chapters/back.typ"
```

分章文件各自 `#import "/lib.typ": *` 与 `lib/*`（Typst include 不继承导入）。

## 2. 帧书写约定

```typ
// frame: c1-background-2 (P06)
== 1.1 研究背景与意义
#takeaway[烧成运行优化需由稳态寻优拓展至动态序列决策]
#grid(columns: (50%, 48%), gutter: 2%, fig-asset("clinker-line-side.png"), diff-cards(...))
#conclude(label: [核心目标])[依托#hl[在线质量感知]与#hl[联合预测]，求解#hl[多目标动态优化决策]]
#note[熟料烧成的运行调控面临三个难点。

质量指标 f-CaO 依赖离线化验……]
```

- 图片助手（`lib/layouts.typ`）：`fig(path, ..args)` → `/examples/beamer-thesis/fig/<path>`；`asset(path, ..args)` → `/examples/beamer-thesis/slides/assets/<path>`。
- 扉页：`#chapter-opener(question: [...], keywords: ([状态感知], [联合预测], [动态优化]), icon: icon("process"), bridge: [...])` 紧接 `= 绪论`；`outline: auto` 取本章二级标题——原稿行是 `1.1 研究背景与意义` 等，与 `==` 标题一致；若不一致则显式传入。
- 总目录：`#outline-slide(groups: ((from: 3, to: 5, tags: ([状态感知], [联合预测], [动态优化]), icons: (icon("sense"), icon("forecast"), icon("optimize")))),)`。
- 封面：`#title-slide(research-line: ((no: "03", icon: icon("sense"), label: [状态感知]), …))`。

## 3. 单页版式库（`lib/layouts.typ`）首批函数

| 原宏 | Typst | 用于 |
|---|---|---|
| `\ysuCascadeRows` + `\ysuChainRow` + `\ysuSupportGap` | `cascade-rows(figure, focus-label, rows, target-label, target)` / `chain-row(icon, label, body)` | P04 |
| `\ysuPlant*` | `plant-page(hero:, stages:, foot:, side:)` | P05 |
| `\ysuDiffCards` / `\ysuDiffCard` | `diff-cards(..cards)` / `diff-card(title, tag, body, effect)` | P06 |
| `\ysuEvoRail` / `\ysuEvoStage` / `\ysuEvoConclude` | `evo-rail(stages: 4 名, cells: 4 × (优势, 局限), limit:, trend:, pill:)` | P07–P09 |
| `\ysuProblemSetup` / `\ysuProblemMapSetup` / `\ysuProblemSketch` / `\ysuProblemGoal` | `problem-map(...)` + 三种草图 `sketch-overlap/rate-gap/step-sequence`（Typst 绘制） | P10 |
| `\ysuRoadmap*` | `roadmap(banner:, sides:, cols:, links:)` | P11 |
| 第 2 章变量表、流程/详解页宏 | 按 P13–P18 实际宏命名，实现时补表 | P13–P18 |

宏的完整定义在原稿 `ysu-defense-modern.sty` 中按名搜索；几何数值优先照搬，再按目视微调。

## 4. 素材同步脚本

```
python -I examples/beamer-thesis/sync-assets.py [--thesis <论文根>] [--dry-run]
```

- 扫描 `chapters/*.typ` 与 `lib/*.typ` 中 `fig("…")`、`asset("…")` 的字面量参数。
- `fig(p)`：候选 `<论文根>/slides/deck/.build-img/<p>` → `<论文根>/fig/<p>`；`asset(p)`：`<论文根>/slides/deck/.build-img/slides/assets/<p>` → `<论文根>/slides/assets/<p>`。
- 目标存在且大小、mtime 一致则跳过；输出 copied/skipped/missing 计数。
- 默认论文根写死为用户本机路径常量，并允许 `THESIS_ROOT` 环境变量覆盖。

## 5. 口播导出

```
python -I examples/beamer-thesis/export-speech.py [--out examples/beamer-thesis/speech.md]
```

内部执行 `typst query --root . examples/beamer-thesis/main.typ "<ysu-note>" --field value`，按 `chapter` 分二级标题（`开场`、`第 N 章　章名`、`致谢`），每页 `### 第 N 页　标题`，页间 `---`；头部写题名、答辩人、页数与字数（与原稿 speech.md 头部格式一致）。

## 6. 视觉对照

```
typst compile --root . --format png --ppi 72 examples/beamer-thesis/main.typ ".tmp/thesis/page-{0p}.png"
```

与 `thesis/slides/deck/preview/page-NNN.png`（693×390 左右）并排查看；必要时写小脚本拼图到 `.tmp/` 便于浏览。
