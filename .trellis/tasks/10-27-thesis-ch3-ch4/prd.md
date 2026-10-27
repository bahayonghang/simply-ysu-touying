# 复刻二：第 3-4 章

父任务：`10-27-ysu-defense-1-0`。依赖 `10-27-thesis-front-ch1-ch2` 的工程骨架、书写约定与 `lib/layouts.typ`（见该任务 design.md）。逐帧清单：父任务 `research/frame-inventory.md` P19–P51。

## Goal

复刻原稿第 3 章（P19–P37，19 帧）与第 4 章（P38–P51，14 帧）及其口播。这两章是方法与实验的主体，集中了公式详解页、论文表格页、图组页、KPI 与小结页。

## 范围

| 类型 | 页 |
|---|---|
| 扉页 | P19 c3-toc、P38 c4-toc |
| 章节定位 / 引言 / 问题 | P20 c3-position、P21 c3-intro、P22 c3-problem、P39 c4-position、P40 c4-intro、P41 c4-problem |
| 方法流程 + 详解（公式） | P23–P28、P42–P46 |
| 实验设置 / 表格 / 图组 / 轨迹 | P29–P36、P47–P50 |
| 小结（paper-summary：KPI + 论文框） | P37 c3-summary、P51 c4-summary |

## Requirements

1. 文字、数字、公式、表体与原稿 `.tex` 一致；公式编号沿用论文编号（如 (3-5)），以 muted 小字显示。
2. 论文表格转写为 `result-table`（或主题等价组件），本文模型行着色、最佳值加粗与原稿一致；数字分组（`0.032\,2` 形式）保留。
3. 图组页（`figure-grid`）子图排列、子图标签、图注与原稿一致。
4. 原稿 PDF 数据图（`slides/assets/ch3-*.pdf`、`ch4-*.pdf`）直接以 PDF 图片嵌入（Typst ≥ 0.14 支持）。
5. 33 条 `#note` 搬运；`export-speech.py` 对本批逐字比对通过。
6. 新增单页版式函数写入 `lib/layouts.typ`，与首批命名风格一致；偏离点写入本任务 `research/deviations.md`。

## Acceptance Criteria

- [x] `sync-assets.py` 无缺失；全稿编译页数 = 51。（实际 54 页：P01–P51 加第 5–7 章三页占位扉页，见 research/deviations.md）
- [x] 备注版 102 页，页标签检查通过。（实际 108 页，同上；`check-page-labels.py --expect-notes` 通过）
- [x] P19–P51 目视对照记录写入 `research/visual-diff.md`。
- [x] 公式逐式核对清单（页号、编号、核对结果）写入 `research/equations-check.md`。
- [x] 回归 G1（`beamer-ysu.typ`）通过。
