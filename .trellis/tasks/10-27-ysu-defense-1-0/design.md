# Design：YSU 答辩主题 1.0.0

本文件是父任务的总体技术设计；各子任务的 `design.md` 只补充本子任务的细节，并引用这里的章节号。视觉数值见 `research/latex-visual-spec.md`，备注契约见 `research/notes-contract.md`，逐帧清单见 `research/frame-inventory.md`。

## 1. 边界

| 层 | 位置 | 是否入包 | 是否入库 |
|---|---|---|---|
| 主题 | `themes/ysu-beamer.typ`（整体重写；可按需拆出 `themes/components.typ`、`themes/notes.typ`，由 `ysu-beamer.typ` 重新导出） | 是 | 是 |
| 包入口 | `lib.typ`（不变：重导出 touying + 主题） | 是 | 是 |
| 通用示例 | `examples/beamer-ysu.typ` | 否 | 是 |
| 模板 | `template/main.typ` | 是 | 是 |
| 复刻示例 | `examples/beamer-thesis/**` | 否 | **否**（`examples/.gitignore` 已忽略整个目录，论文内容只留本机） |

主题只放与论文内容无关、可复用的版式。原稿中按页定制的版式（演进栏、问题图、技术路线、产线照片页等）放在 `examples/beamer-thesis/lib/`。判断规则：与论文内容无关，且在 ≥ 3 页复用，才上提到主题。

## 2. 公开 API 契约（替换后）

保留旧名，参数按新版式重定义。旧参数 `progress-bar`、`watermark`、`footer-columns`、`footer-a..d` 删除（破坏性变更，1.0.0 发布说明需写明迁移方法）。

### 2.1 初始化

```typ
#show: ysu-theme.with(
  aspect-ratio: "16-9",
  nav-labels: auto,        // 页脚章节短标签数组；auto = 一级标题文本
  nav-full-labels: auto,   // 扉页底部进度条标签；auto = nav-labels
  notes: false,            // true 时生成独立备注页（见 §5）
  config-info(
    title: [...], short-title: [...], author: [...], date: ...,
    institution: [...],
    stage: [博士学位论文预答辩],          // 扩展键：页脚、封面阶段标签
    stage-en: [Doctoral Pre-defense],    // 扩展键：封面底部英文
    supervisor: [...], subject: [...], school: [...],
  ),
)
```

`config-info` 在 touying 0.6.3 中接受任意命名参数（`configs.typ:507`，`..args.named()` 并入 `info`），扩展键无需改 touying。`notes` 允许由 `sys.inputs` 驱动：示例写 `notes: sys.inputs.at("notes", default: "off") == "on"`。

### 2.2 结构页

| 函数 | 作用 | 关键参数 |
|---|---|---|
| `title-slide(research-line: ())` | 封面（visual-spec §4.3） | `research-line`：`((no: "03", icon: none, label: [状态感知]), …)`，为空时右栏只放水印与英文名 |
| `outline-slide(groups: ())` | 总目录（§4.4），章节来自一级标题查询 | `groups`：`((from: 3, to: 5, tags: (..), icons: (..)),)` 高亮分组 |
| `chapter-opener(question:, keywords:, keyword-icons:, icon:, outline: auto, bridge:)` | 不产出页面，只把扉页数据写入 state；紧随其后的 `= 标题` 触发的 `new-section-slide` 读取并清空 | `outline: auto` = 本章内去重后的二级标题 |
| `new-section-slide` | 章节扉页（§4.5）；未设置 opener 数据时退化为“章号 + 章名 + 进度条”简版 | — |
| `ending-slide(recap: ())` | 致谢（§4.6）；`recap` 为三项 `(title:, chapter:, icon:, body:, tags:)` 时画回顾卡，否则画简版 | — |

### 2.3 内容页

- `== 1.1 研究背景与意义` 开一页（touying 默认行为），标题即面包屑一级/无结论句时的主标题。同一标题可重复用于多页。
- 结论句与小节两种写法等价：`#slide(sub: [...], takeaway: [...])[...]`，或在 `==` 页正文中写 `#sub[...]`、`#takeaway[...]` 标记。
- 页眉逻辑（与原稿一致）：有结论句 → 面包屑 `标题 / 小节`，主标题 = 结论句；无结论句 → 面包屑 = 小节，主标题 = 标题。
- 实现要点：页眉在页面顶部求值，早于正文里的 state 更新，所以不能用 `state.get()`。标记写成 `metadata(...) <ysu-takeaway>` / `<ysu-sub>`，页眉用 `query(...)` 过滤 `location().page() == here().page()` 取本页值；`slide(takeaway:)` 参数直接在包装器内生成同样的 metadata。
- 正文默认垂直居中（原稿 `\beamer@centeredtrue`）；`slide(align: top)` 对应原稿 `[t]` 帧。

### 2.4 组件

名称与参数见 visual-spec §5 表“建议 Typst 名”列。共同约定：

- 全部为普通函数（非 touying-fn-wrapper），颜色取主题令牌常量；需要读 `self` 的组件（极少）才用 `touying-fn-wrapper`。
- `icon` 参数一律接收 `content`/`none`。
- 全宽出血组件（`conclude`、`base-bar`）用 `place` + 负偏移出血到页边，或在 `block` 上设 `outset: (x: <页边距>)`；不改变布局盒宽度。
- `points(..items)` 的编号在每页重置：用组件内部计数而非全局 counter。

## 3. 令牌与样式

- `themes/ysu-beamer.typ` 顶部定义颜色常量（`ysu-navy` 等，公开导出以便用户扩展），同时写入 `config-colors(primary: navy, ...)` 供 touying 组件使用。
- 混色统一用 `color.mix((navy, p), (white, 100% - p))` 的小工具函数，避免 `lighten` 语义差异。
- 字体：`latin: ("Source Sans 3", "Source Sans Pro", "Arial")`，`cjk: ("Source Han Sans SC", "Source Han Sans", "Noto Sans CJK SC", "Noto Sans SC", "Microsoft YaHei")`，允许 `ysu-theme(font: ...)` 覆盖。`set text(lang: "zh", region: "cn")`；正文左对齐不两端（原稿 `flush left`，避免 CJK 拉伸）。
- `cuti` 伪粗体：新版式使用自带粗体字重的黑体族，**去掉 `@preview/cuti` 依赖**（依赖更少；若用户换回无粗体字体，可自行 `show: show-cn-fakebold`）。若实现中发现回退字体缺粗体导致明显问题，再恢复，并在 theme-core 中记录。
- 列表：`set list(marker: ...)` 用 navy 小方块；全宽列表用大一号字（原稿 `\large`），列内保持基础字号——用 `layout` 判断可用宽度 > 0.8 页宽。
- 图注、表格：`show figure.caption` muted 小字；结果表通过 `result-table(...)` 构造（navy 表头白字、三线、可标记本文模型行），不全局改 `table` 样式，避免影响用户普通表格。

## 4. 章节与导航数据流

```
= 绪论                      → touying 新节 → new-section-slide（读取 chapter-opener state）
  (chapter index = counter(heading.where(level: 1)))
== 1.1 研究背景与意义        → 内容页；页眉查询本页 <ysu-sub>/<ysu-takeaway>
页脚                         → context：当前一级标题序号 → nav-labels[i] 高亮
outline-slide / 封面         → query(heading.where(level: 1)) 全文章节列表
扉页进度条                   → 同上 + nav-full-labels
```

一级标题编号：原稿章节号即论文章号（1–7），Typst 侧用一级标题序号，不显示 heading numbering。

## 5. 演讲备注机制

- `note(body)`：①调用 touying `speaker-note` 保持 pdfpc；②写 `metadata((text: <纯文本>, ...)) <ysu-note>`；③若 `notes` 开启，把 `body` 写入本页的备注 state。
- 备注页由主题 `slide` 包装器在 touying 输出该帧最后一个 subslide 后追加顶层 `page(width: 16cm·比例, height: 13.5cm·比例, fill: #252320, numbering: "notes:1")[...]`，页内先 `counter(page).update(n => n - 1)` 让标签 `N` 与内容页对齐；touying 的 `slide-counter` 与 `last-slide-counter` 不推进。
- 风险与备选方案见 `research/notes-contract.md` §4；speaker-notes 子任务先做 spike 再定方案。
- 导出：`typst query --root . examples/beamer-thesis/main.typ "<ysu-note>" --field value` → JSON → `examples/beamer-thesis/export-speech.py` 生成 `speech.md`（结构同原稿：二级标题分章，三级标题 `第 N 页　标题`，页间 `---`）。

## 6. 复刻示例结构（本机，不入库）

```
examples/beamer-thesis/
├── main.typ              # #import "/lib.typ": *；元数据；include chapters/*
├── chapters/
│   ├── front.typ  ch1.typ … ch7.typ  back.typ
├── lib/
│   ├── layouts.typ       # 单页专用版式（演进栏、问题图、技术路线、产线页…）
│   └── icons.typ         # 语义图标表：优先 @preview/fontawesome，缺字体时退化
├── fig/                  # ← 同步自 thesis/fig（优先 slides/deck/.build-img 降采样副本）
├── slides/assets/        # ← 同步自 thesis/slides/assets
├── sync-assets.py        # 扫描 chapters/*.typ 中的 fig("…")/asset("…") 引用，按需复制
├── export-speech.py      # typst query → speech.md
└── README.md             # 编译、备注、同步、导出命令
```

- 图片路径与论文保持同一相对结构，`fig("chapter2/xxx.png")` → `image("/examples/beamer-thesis/fig/chapter2/xxx.png")`（根绝对路径，避免 Typst 按调用文件解析相对路径的歧义）。
- `sync-assets.py`：参数 `--thesis <论文根>`（默认用户本机路径），用 `python -I` 运行，无第三方依赖；复制前比较大小/mtime，打印缺失文件清单并以非零退出码报告缺失。
- 帧 id 在每页上方以注释保留：`// frame: c1-background-1 (P04)`，便于与原稿、口播对照。
- 编译命令：`typst compile --root . examples/beamer-thesis/main.typ`；备注版：`… --input notes=on examples/beamer-thesis/main.typ examples/beamer-thesis/main-notes.pdf`。

## 7. 兼容性与发布

- 破坏性：旧 `ysu-theme` 参数删除、配色字体全换、去掉 `cuti`。README 增加“从 0.2.x 迁移”小节。
- `examples/beamer-ysu.typ` 改写为新 API 的通用功能演示（不含论文内容），继续作为回归基准。
- `thumbnail.png`、`template/main.pdf`、`examples/beamer-ysu.pdf` 由新主题重新生成。
- Typst 编译器基线保持 `0.14.0`；需在 0.14 与 0.15 上各编一次（本机 0.15.1；0.14 可用 `.local-typst/` 或跳过并在 release 子任务记录）。

## 8. 风险

| 风险 | 影响 | 缓解 |
|---|---|---|
| 备注页插入与 touying 页面流水线冲突 | R2 无法按 FerroStage 契约实现 | speaker-notes 先 spike；备选 touying 双屏模式（notes-contract §4） |
| 页眉跨页查询性能 | 88 页 query 可能拖慢编译 | metadata 只在需要的页写；查询限定 `heading`/label 选择器；记录编译耗时 |
| 原稿单页版式依赖 TikZ 精确坐标 | 复刻偏差 | 用 `place(dx:, dy:)` 按 visual-spec 坐标 × 比例；逐页对照 preview |
| 公式从 LaTeX 转 Typst 出错 | 数学内容失真 | 复刻子任务逐式核对原 `.tex`；可用 `mitex` 包兜底单个复杂公式（只在示例中用） |
| 字体缺失（Source Sans 3、FA） | 外观偏差 | 回退链；README 写明推荐字体 |

## 9. 回滚

主题重写在独立提交中完成；若 1.0.0 发布前发现无法接受的问题，`git revert` theme-core 提交即可恢复 0.2.0 主题。复刻示例不入库，不影响回滚。
