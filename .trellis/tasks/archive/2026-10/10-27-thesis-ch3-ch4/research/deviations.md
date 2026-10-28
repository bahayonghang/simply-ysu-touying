# 偏离点

| 页 | 原稿做法 | Typst 做法 | 原因 |
| --- | --- | --- | --- |
| 全部 | 本批完成后应为 51 页（备注版 102 页） | 54 页（备注版 108 页）：P01–P51 加第 5–7 章三页占位扉页 | 占位章保留 `= 标题`，导航栏与总目录不缺章；下一批补全后为 88 / 176 页 |
| 全部 | 表格用 `result-table`（prd 名称） | 用 `lib/layouts.typ` 的 `paper-table`：`"*"` 前缀标最佳、`"_"` 标次优，数字按三位一组加细空格并整体装箱 | 主题没有论文表组件；装箱避免数字在细空格处断开 |
| 全部 | 公式编号 `\scriptsize` muted | 公式行编号 9 pt 正文色 | preview 中编号为正文色常规字号，按渲染结果 |
| 全部 | 数字与单位间 `~` 不断行 | 备注外数字间空格改为 `~` | 同首批约定 |
| P30、P34 | 表格 `max width=\textwidth` 缩放 | 字号 7 / 7.2 pt、列宽给定 cm 值 | Typst 不缩放表格；按版心与页脚留白定字号 |
| P47 | 表 4-2 原表名为“Nonstationary Transformer”“QC-MTWaveSME (本章)”，次优加下划线 | 写作“NS-Transformer”、粗体“QC-MTWaveSME”，无下划线 | 原稿 `forecast` 表格配置对表体做了这些替换，按其输出 |
| P50 | 表 4-5 原表名“去小波条件图块”，次优加下划线 | 写作“移除小波分解与图传播”，无下划线；表题行替换为“结构组件消融｜过程预测（表 4-5）” | 原稿 `ablation` 表格配置与 `\ysuAblationCaption` 的输出 |
| P50 | preview 小节名“4.4.4 模型有效性分析与消融实验” | 按 `.tex` 写作“4.4.4 联合预测各模块消融实验” | preview 为旧版渲染，以 `.tex` 为准 |
| P38、P40、P46 等 | 卡片与面板中的 `\\` 强制换行 | 窄卡、侧栏标签保留换行（`\ `）；扉页问题句保留首句后的换行 | 这些位置的自然断行会在词中间折断；宽行文字已去掉强制换行 |
| P44 | `\tfrac` 与侧置求和上下标的 display 公式 | 多行公式用 `eq-lines`：左右两列行内公式，按关系符对齐 | Typst 的 display 公式求和上下标放在下方，卡片放不下；行内公式自然得到 `\tfrac` 与侧置上下标 |
| P44 | — | 公式单元设 `top-edge: "bounds"`、`bottom-edge: "bounds"` | 主题正文的文字边界为 cap-height / baseline，分式会与下一行重叠 |
| P46 | 阶段面板高 3.5 cm | 3.35 cm，`breakable: false` | Typst 版心比原稿 tikz 画布矮约 0.3 cm；面板固定高溢出时会被拆页 |
| P49 | `trim=0 34 0 0`（裁去底部 34 bp，约 9.6 % 图高） | 裁去 15 % 图高 | 按 9.6 % 裁切时图例仍露出一截；原稿 preview 不显示图例 |
| 讲稿 | 备注中 `$\psi_{\mathrm{cal}}$`、后续 `$\boldsymbol{\Theta}$`、`$\mathcal{T}_{\mathrm{wm}}$` | 备注写 `$psi_"cal"$`；`export-speech.py` 把多字母下标还原为 `_{\mathrm{..}}`，并把 Unicode 数学字母 `𝚯`、`𝒯` 还原为 `\boldsymbol{\Theta}`、`\mathcal{T}` | 不改主题 `_plain`；样式字母只能靠 Unicode 数学字母保留到纯文本 |
| 主题 | `red-frame(center: true)` 报错 | `themes/components.typ` 中改用 `std.align(std.center, …)` | 参数名 `center` 遮蔽了对齐常量；主题修复，单独提交 |
