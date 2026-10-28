#import "@preview/touying:0.6.3": *
#import "/themes/ysu-beamer.typ": *

#show: ysu-theme.with(
  aspect-ratio: sys.inputs.at("ratio", default: "16-9"),
  nav-labels: ("概览", "结构", "组件", "图表", "使用"),
  // `typst compile --input notes=on` adds a notes page after every slide.
  notes: sys.inputs.at("notes", default: "off") == "on",
  config-info(
    title: [燕山大学 Touying 演示模板\ 答辩版式示例],
    short-title: [YSU Touying 模板],
    author: [张三],
    supervisor: [李四#h(1em)教授],
    subject: [控制科学与工程],
    school: [电气工程学院],
    date: datetime(year: 2026, month: 10, day: 27),
    stage: [学术汇报示例],
    stage-en: [Academic Presentation],
  ),
)

// Icons are plain content; any icon font or symbol works.
#let ic(s) = text(font: "DejaVu Sans Mono", s)

#title-slide(note: [各位老师好，我汇报的题目是*燕山大学 Touying 演示模板*。], research-line: (
  (no: "01", icon: ic("◉"), label: [结构页]),
  (no: "02", icon: ic("▤"), label: [内容组件]),
  (no: "03", icon: ic("↗"), label: [图表公式]),
))

#outline-slide(note: [汇报分五部分，第 2 到 4 章是重点。], groups: (
  (from: 2, to: 4, tags: ([结构], [组件], [图表]), icons: (ic("◉"), ic("▤"), ic("↗"))),
))

= 主题概览
#chapter-opener(
  question: [如何让中文学术汇报既#hl[规范统一]，\ 又保留 Touying 的灵活性？],
  keywords: ([藏青配色], [结构页], [组件库]),
  icon: ic("▣"),
  bridge: [输入：Typst 源文件；输出：与 LaTeX 答辩稿#hl[同一版式]的 PDF],
)
#note[第一部分介绍主题的设计目标。]

== 1.1 设计目标
#takeaway[以答辩稿版式为基准，统一页眉、页脚与组件语言]

- 页眉：面包屑 + 结论句主标题 + 红色短线
- 页脚：作者与阶段、章节导航、页码
- 结构页：封面、目录、章节扉页、致谢
- 组件：标题框、分组框、结论条、编号点、数值卡等

#note[
  本页给出四个设计目标。*页眉*与*页脚*沿用答辩稿的版式。

  第二段：备注支持行内公式 $y = f(x) + 5%$ 与多段文字。
]

== 1.2 页眉逻辑
#sub[1.2.1 有结论句时]
#takeaway[有结论句时，面包屑显示“标题 / 小节”，主标题显示结论句]

#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.4cm,
  title-box(title: [无结论句])[面包屑 = 小节\ 主标题 = 二级标题],
  title-box(title: [有结论句])[面包屑 = 二级标题 / 小节\ 主标题 = 结论句],
)

== 1.3 分步展示

#slide(composer: (1fr, 1fr))[
  保留 Touying 的分步能力：
  #pause
  - 逐条呈现要点
  #pause
  - 与多栏、表格、公式混用
  #note[分步页的备注页只跟在最后一个子页之后。]
][
  #reading-card(title: [答辩建议])[
    正式答辩稿建议一页一帧、不用 `#pause`，以便演讲者视图的备注页与幻灯片一一对应。
  ]
]

= 页面结构
#chapter-opener(
  question: [封面、目录、扉页与致谢如何自动生成？],
  keywords: ([config-info], [一级标题]),
  icon: ic("▣"),
)

== 2.1 结构页 API
#takeaway[结构页数据来自 config-info 与一级标题，无需手工排版]

#label-row(label: [封面])[`title-slide(research-line: ...)`：左白右深，阶段标签与研究主线]
#v(0.15cm)
#label-row(label: [目录])[`outline-slide(groups: ...)`：一级标题自动成行，核心章节可分组高亮]
#v(0.15cm)
#label-row(label: [扉页], dashed: true)[`= 标题` 后接 `chapter-opener(...)`：章节号、本章问题、本章内容]
#v(0.15cm)
#label-row(label: [致谢])[`ending-slide(recap: ...)`：三张贡献回顾卡]

= 内容组件
#chapter-opener(
  question: [常用组件有哪些，分别在什么场合使用？],
  keywords: ([框组], [强调], [数值]),
  icon: ic("▣"),
)

== 3.1 分组与流向
#takeaway[分组框承载并列要点，块箭头连接问题与方法]

#grid(
  columns: (1fr, auto, 1fr),
  column-gutter: 0.25cm,
  align: horizon,
  group-box(label: [三类问题], red: true)[
    #sub-box[#key[01 采样异步]：分钟级数据与化验不同步]
    #sub-box[02 状态重叠：相近观测对应不同结果]
  ],
  block-arrow[本文\ 方法],
  group-box(label: [对应方法])[
    #sub-box[门控交叉注意力]
    #dash-box[条件生成补充尾部样本]
  ],
)
#v(0.2cm)
#red-frame(label: [研究目的])[提高在线估计精度，为#key[运行决策]提供依据]

== 3.2 编号点与卡片
#takeaway[编号点按页重新计数，卡片以顶部色条区分语义]

#grid(
  columns: (1.15fr, 1fr),
  column-gutter: 0.4cm,
  points(rule: true, [依托#hl[工业通信接口]接入既有控制系统], [首页集成工况识别与指标预警], [设定值计算在#hl[算法服务]中完成]),
  stack(
    spacing: 0.2cm,
    card[#hl[默认卡片]：白底细边，顶部藏青色条],
    card(accent: ysu-red)[#text(fill: ysu-red, weight: "bold")[问题卡片]：红色色条],
    side-card(label: [问题一])[状态重叠与尾部样本稀缺],
  ),
)

== 3.3 结论条与基底条
#takeaway[结论条与基底条全宽出血，收束整页]

#base-bar[研究对象：工业过程运行优化]
#v(0.3cm)
#section-bar(icon: ic("◉"))[章节条]
#v(0.2cm)
#grid(
  columns: (1fr,) * 3,
  column-gutter: 0.3cm,
  kpi(label: [MAE], value: [↓ 19.6%], basis: [相对基线], key: true),
  kpi(label: [NRMSE], value: [↓ 9.6%], basis: [相对基线]),
  kpi(label: [SMAPE], value: [↓ 12.7%], basis: [相对基线]),
)
#v(0.3cm)
#conclude(label: [核心目标], pill: [第 3 章])[依托#hl[在线感知]与#hl[联合预测]，求解#hl[多目标动态优化决策]]

== 3.4 标签与图标
#takeaway[标签区分语义，图标接收任意内容]

#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.4cm,
  row-gutter: 0.3cm,
  align: horizon,
  [#tag[藏青标签] #h(0.3em) #tag(kind: "red")[红色标签] #h(0.3em) #box(fill: ysu-navy, inset: 3pt, radius: 2pt, tag(kind: "line")[描边标签])],
  [#tab-pill[答辩人：张三]],
  [#edge-label[方法] #h(0.3em) #edge-label(red: true)[问题]],
  [#icon-disc(ic("◉")) 状态感知 #h(0.6em) #icon-disc(ic("↗")) 联合预测 #h(0.6em) #logo(height: 0.6cm)],
  tblock(title: [tblock（兼容 0.x）])[等同于 `title-box(title: ...)`],
  [$ E = m c^2 $ #h(1fr) #eq-number[(3-1)]],
)

= 图表与公式
#chapter-opener(
  question: [结果表、公式与截图如何统一呈现？],
  keywords: ([结果表], [公式块], [截图窗]),
  icon: ic("▣"),
)

== 4.1 结果表
#takeaway[结果表以藏青表头标出指标，以浅底行标出本文方法]

#grid(
  columns: (1.5fr, 1fr),
  column-gutter: 0.4cm,
  align: horizon,
  {
    fig-caption[表 4-1　不同模型的预测指标]
    result-table(
      header: ([模型], [MAE↓], [RMSE↓]),
      rows: (
        ([基线 A], [0.379 3], [0.471 0]),
        ([基线 B], [0.051 4], [0.075 7]),
        ([基线 C], [0.032 0], [0.052 2]),
        ([本文方法], [0.025 0], [0.046 1]),
      ),
      mark: (3,),
    )
  },
  title-box(title: [误差降幅])[以基线 C 为比较基准，本文方法 MAE 降低 #key[21.9%]。],
)

== 4.2 公式与截图
#takeaway[公式块沿用论文编号，截图窗统一现场画面]

#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.4cm,
  align: horizon,
  stack(
    spacing: 0.2cm,
    eq-block(number: [(4-1)], note: [门控权重由当前观测与慢变条件共同决定。])[
      $ bold(g)_t = sigma (bold(W)_g [bold(x)_t ; bold(c)] + bold(b)_g) $
    ],
    eq-block(number: [(4-2)])[$ hat(y)_t = bold(g)_t dot.o bold(h)_t + (1 - bold(g)_t) dot.o bold(c) $],
  ),
  figure-box(caption: [图 4-1　截图窗示意])[
    #screen-frame(title: [监测平台首页])[
      #rect(width: 100%, height: 2.6cm, fill: gradient.linear(ysu-navy, ysu-night, angle: 90deg))
    ]
  ],
)

= 使用方式
#chapter-opener(question: [如何开始一份新的汇报？], keywords: ([typst init],), icon: ic("▣"))

== 5.1 最小示例
#takeaway[导入包、设置元数据、写一级与二级标题即可]

#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 0.4cm,
  align: horizon,
  block(fill: ysu-tint, inset: 8pt, width: 100%, text(size: 7.5pt, ```typ
  #import "@preview/simply-ysu-touying:1.0.0": *
  #show: ysu-theme.with(config-info(
    title: [报告标题], author: [姓名],
    stage: [学术汇报], date: datetime.today(),
  ))
  #title-slide()
  #outline-slide()
  = 第一章
  == 1.1 第一页
  #takeaway[本页结论句]
  ```)),
  paper-box("Zhang S, Li S. An example paper title. Journal of Examples, 2026, 1(1): 1-10. DOI: 10.0000/example"),
)

#ending-slide(note: [以上是我的汇报，敬请各位老师批评指正。], recap: (
  (title: [结构页], chapter: [第 2 章], icon: ic("◉"), body: [封面、目录、扉页与致谢由元数据与标题自动生成], tags: ([title-slide], [outline-slide])),
  (title: [内容组件], chapter: [第 3 章], icon: ic("▤"), body: [标题框、分组框、结论条、编号点与数值卡], tags: ([group-box], [conclude], [kpi])),
  (title: [图表公式], chapter: [第 4 章], icon: ic("↗"), body: [结果表、公式块与截图窗统一呈现实验结果], tags: ([result-table], [eq-block])),
))
