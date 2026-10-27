# Design：复刻第 3-4 章

沿用 `10-27-thesis-front-ch1-ch2/design.md` 的入口、帧书写、图片助手、同步与导出约定。本文件只写本批新增问题。

## 1. 公式转写

- 原稿公式在 `\begin{equation}` / `align` 内，宏来自论文 `thesis-macros.tex`（当前为空）与常规 amsmath/bm。
- 转写规则：`\bm{x}` → `bold(x)`，`\mathrm{}` → `upright()`，`\operatorname{}` → `op("")`，`\left( \right)` → 自动伸缩括号，`\tag` / 论文编号 → 右侧 `eq-number[(3-5)]` 组件（不用 Typst `math.equation` 自动编号，以免与论文编号不一致）。
- 复杂多行对齐公式：`$ … & … \ … $`；必要时在示例中引入 `@preview/mitex` 渲染单个公式，记录到 deviations。
- 公式块统一放在主题 `eq-block`（组件 B：ysuTint 底 + 读法），字号比正文小一级（原稿 `\small`）。

## 2. 表格

- 原稿把论文 `tabular*`/`tabularx` 原样复制，并由 `\ysuTableMark` 给本文模型行着色、result-table 样式（task 10-14）给表头上色。
- Typst：`result-table(columns:, header: (...), rows: (...), mark: (<行索引>,), bold: ((r, c), ...))`；列宽按内容自动，整体宽度 100% 或按原稿比例。
- 表题在表上方，muted 小字，格式“表 4-2　不同模型的过程变量预测指标”。

## 3. 图组与轨迹页

- 2×3 预测曲线（P47 附近）：`grid(columns: 3, rows: 2)`，每格 16:9 图 + 子图标签。
- 边际直方图 + t-SNE（P33）：按原稿 `\ysuTsne*` 宏几何实现局部函数。
- 截取（`trim=…,clip`）：Typst 无 trim，改为 `box(clip: true, inset: (top: -Npt))` 包裹实现裁剪。

## 4. 小结页

`paper-summary` 版式：左侧 KPI 卡行（组件 E）+ 汇总图（PDF），右侧/下方 `paper-box` 列出发表论文（截到 `DOI:` 前）。

## 5. 版式函数预计新增

方法流程条（flow-strip + stage notes）、公式映射行（eq-map）、公式向导卡（eq-guide）、组卡（groups，问题→方法两列映射）、阅读卡行（reading-cards）、读数卡（metric-cards）、时间轴（time-axis）。实现时以原稿宏名注释对应关系。
