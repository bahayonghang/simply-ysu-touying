# P52–P88 目视对照与三批汇总

对照方法同前两批：`.tmp/thesis/out.pdf` 以 110 dpi 渲染，与 `thesis/slides/deck/preview/page-NNN.png` 左右并排（左原稿、右 Typst，`.tmp/thesis/tools/cmp.py`）逐页检查。溢出另页用 PyMuPDF 逐页读文字行数检出（溢出页只剩节标题和少量文字）。

结论：37 页版式、配色、文字与原稿一致或接近，未见未解释的明显偏差。全稿 88 页，备注版 176 页。

## 编译时间（Typst 0.15.1，本机，各两次）

| 版本 | 第 1 次 | 第 2 次 |
| --- | --- | --- |
| 普通版 88 页 | 1.97 s | 2.09 s |
| 备注版 176 页 | 2.01 s | 2.05 s |

`typst compile` 每次都是新进程，不在进程之间保留增量缓存，因此冷、热编译耗时相同。用户未提供 XeLaTeX 编译耗时，只记录 Typst 一侧。

## 第 5 章

第 5 章版式统一按 tex 宏的字号排（卡片正文 9–9.5 pt、标题 10 pt、行距 0.55 em）。初版比 tex 大约 1 pt，导致 8 页溢出，已修正。

| 页 | frame | 结果 | 残留差异 |
| --- | --- | --- | --- |
| P52 | c5-toc | 一致 | — |
| P53 | c5-position | 一致 | — |
| P54 | c5-intro | 接近 | 问题/方法卡行高 33 pt，组框略矮 |
| P55 | c5-problem-flow | 接近 | 依据框行距略小 |
| P56 | c5-problem-detail | 接近 | 卡头字号 9.5 pt，公式面板行距收紧 |
| P57 | c5-method-1-flow | 一致 | — |
| P58 | c5-method-1-detail | 一致 | — |
| P59 | c5-method-2-flow | 接近 | 阶段卡折行位置不同，第三卡文字贴底 |
| P60 | c5-method-2-detail | 接近 | 图 5-4 比原稿略小 |
| P61 | c5-method-3-flow | 接近 | 输出链方框高 0.85 cm |
| P62 | c5-method-3-detail | 接近 | 公式编号与条件行位置略不同 |
| P63 | c5-experiment-1 | 接近 | 时间轴标签行距略大 |
| P64 | c5-experiment-2 | 接近 | 表体内边距 2 pt，比原稿紧 |
| P65 | c5-experiment-2-trajectory | 接近 | 读数卡折行位置不同 |
| P66 | c5-decision-single-cv | 一致 | — |
| P67 | c5-decision-single-outcomes | 接近 | 图高 3.3 cm |
| P68 | c5-experiment-3 | 接近 | 图高 2.4 cm，指标卡自适应高度 |
| P69 | c5-decision-rolling-smoothness | 接近 | 图高 2.95 cm |
| P70 | c5-experiment-4 | 接近 | 方法列 3.5 cm，表格整体略靠上 |
| P71 | c5-experiment-5 | 接近 | 方法列 3.7 cm |
| P72 | c5-summary | 接近 | 评价结果行间细线比原稿淡；左栏 42 % |

## 第 6 章

| 页 | frame | 结果 | 残留差异 |
| --- | --- | --- | --- |
| P73 | c6-toc | 接近 | 章名按 `.tex` 为“运行监测与优化平台”（见 deviations） |
| P74 | c6-position | 一致 | — |
| P75 | c6-architecture | 一致 | 图注按 `.tex` |
| P76 | c6-intro | 接近 | 图顶裁 7.6 %，读数栏折行位置不同 |
| P77 | c6-home | 接近 | 截图窗框占满左栏，比原稿略宽 |
| P78 | c6-pred-energy | 接近 | 两张放大图各高 1.95 cm |
| P79 | c6-pred-quality | 接近 | 同 P78 |
| P80 | c6-pred-overview | 一致 | — |
| P81 | c6-decision | 一致 | — |
| P82 | c6-decision-effect | 接近 | KPI 行与截图间距略小 |
| P83 | c6-summary | 接近 | 证据面板行距略小 |

## 第 7 章与致谢

| 页 | frame | 结果 | 残留差异 |
| --- | --- | --- | --- |
| P84 | c7-toc | 接近 | 承接行字号 8.2 pt，以免折行 |
| P85 | c7-innovation | 接近 | 创新点陈述折行位置不同 |
| P86 | c7-outlook | 接近 | 面板顶部留白略大 |
| P87 | c7-achievements | 接近 | 论文框箭头为细线箭头 |
| P88 | thanks | 一致 | 主题 `ending-slide(recap: ...)`，未加参数 |

## 三批汇总

| 批次 | 页 | 一致 | 接近 | 明显偏差 |
| --- | --- | --- | --- | --- |
| 首批（front-ch1-ch2） | P01–P18 | 见该任务 visual-diff | 其余 | 0 |
| 第二批（ch3-ch4） | P19–P51 | 见该任务 visual-diff | 其余 | 0 |
| 第三批（本任务） | P52–P88 | 10 | 27 | 0 |

本批只改了 `lib/layouts.typ` 的第 5–7 章新段，以及两处向后兼容的参数：`flow-deck` 的 `bar` 允许为 `none`，`kpi-row` 新增 `rule`（默认值不变）。前两批页面的输出不受影响：页数与讲稿第 1–51 页均未变化。
