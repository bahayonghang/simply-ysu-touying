# Design：主题核心

继承父任务 `design.md` §1–§4、§7。本文件只写本子任务的实现细节。

## 1. 文件组织

```
themes/
├── ysu-beamer.typ     # 入口：令牌、ysu-theme、slide 包装器、结构页；末尾 #import 并重导出下列模块
├── components.typ     # 组件库（纯函数，只依赖令牌）
└── assets/            # 不变
```

`components.typ` 需要令牌，令牌放在 `themes/tokens.typ`（无副作用常量），`ysu-beamer.typ` 与 `components.typ` 都从它导入，避免循环导入。`lib.typ` 仍只 `#import "themes/ysu-beamer.typ": *`；`ysu-beamer.typ` 用 `#import "components.typ": *` 与 `#import "tokens.typ": *` 让符号一起导出。

内部辅助函数以 `_` 开头（沿用现有规范）。

## 2. 几何换算

原稿纸面 16cm × 9cm；touying `presentation-16-9` 为 841.89pt × 473.56pt。定义 `_u(x) = x * (841.89pt / 16cm)` 之类的换算函数会使代码难读；改为直接以页面比例表达：

- 定义 `let _cm = 841.89pt / 16`（1 原稿 cm 对应的 Typst 长度），结构页坐标写成 `5.125 * _cm`，与 visual-spec 数值一一对应，便于对照。
- 字号同理乘 `841.89 / (16cm in pt ≈ 453.54)` ≈ 1.856：原稿 14pt → 26pt。定义 `_pt(x) = x * 1.856pt`。
- 4:3 时页面宽 841.89pt 不变、高变大：结构页按宽度定位、纵向用比例，页眉页脚高度不变。

## 3. 页面骨架

- `config-page`：`presentation-<ratio>`，`margin: (x: 0.8 * _cm, top: <页眉高>, bottom: <页脚高 0.45cm + 间距>)`，白底；页眉高按“一行主标题”预留，多行结论句时页眉自身向下扩展——实现方式：`header` 用 `place(top)` 自绘，正文顶部 `v()` 补偿量由页眉同一函数在正文起始处计算（`slide` 包装器在 body 前插入 `context` 计算的 `v(extra-lines * 17pt·比例)`）。
- 页眉/页脚通过 touying `config-page(header:, footer:)` + `self.store` 传参；结构页用 `config-page(header: none, footer: none, margin: 0pt)`。
- 垂直居中：`slide` 默认 `align: horizon`，通过 touying `alignment` 设置；`align: top` 覆盖。

## 4. 页眉标记查询

```typ
#let sub(body) = [#metadata(body) <ysu-sub>]
#let takeaway(body) = [#metadata(body) <ysu-takeaway>]
// 页眉内：
context {
  let pg = here().page()
  let pick(lbl) = query(lbl).filter(m => m.location().page() == pg).at(0, default: none)
  ...
}
```

`#pause` 产生的多个 subslide 页各自都含 metadata（touying 复制正文），因此每页都能查到。性能：88 页 × 2 次 query，预计可接受；若慢，改为 `query(selector(<ysu-takeaway>).after(here()).before(<下一页起点>))`。

## 5. 结构页实现要点

- 全部结构页用 `touying-slide-wrapper` + `config-page(margin: 0pt, header: none, footer: none)`，内部 `place(top + left, dx:, dy:)` 按 visual-spec 坐标绘制。
- 45° 渐变：`gradient.linear(night, navy, angle: -45deg)`（Typst 角度方向与 TikZ 相反，需实测确认左下深右上浅）。
- 径向渐变：`gradient.radial(navy, navy, night, center: (60%, 65%), radius: ...)`，实测贴近原稿后固定参数。
- 水印：`box(clip: true)` 包住栏区域，`image(..., width:)` + 透明度——Typst 0.14 图片无 opacity 参数，用白色校徽位图本身 + 叠加同色半透明矩形，或预乘：在 navy 底上以 `ysu-seal-white.png` 放置后再覆盖 `rect(fill: navy.transparentize(9%))` 达到 opacity 0.09 的视觉效果。实现时二选一并记录。
- 倒梯形阶段标签、平行四边形页码：`polygon` / `curve`。
- 扉页章名断行：测量 `measure(title)`，宽于 9.85cm 时把盒宽设为 10.5em。
- 致谢回顾卡复用组件 `title-box` 的绘制函数（给定宽高）。

## 6. 组件实现约定

- 卡片类统一 `block(fill:, stroke:, radius:, inset:)`；顶部色条用 `block` 内 `place(top, rect(height: 2.5pt))` 或 `stroke: (top: …)`（注意圆角与粗边冲突，优先 place）。
- 出血：`conclude`/`base-bar` 在全宽时用 `block(width: 100% + 2 * margin-x)` 并 `move(dx: -margin-x)`；margin 由 `self.page.margin.x` 读取（需要 `touying-fn-wrapper` 拿 `self`）或用常量 `0.8 * _cm`。选择常量，4:3 同值。
- `points`：参数是若干 content，组件内 `enumerate` 生成 `01 02`，数字 navy bold、等宽（`text(number-width: "tabular")`）。
- `hl` / `key`：`box(text(weight: "bold", fill: …, body))`，`box` 防断行，与原稿 `\mbox` 一致。
- `result-table(columns:, header:, rows:, mark: (行号,))`：`table` + `table.hline`，表头行 navy 填充白字，标记行 navy 8% 底。

## 7. beamer-ysu 示例改写

章节建议：封面 → 目录 → 第 1 章（扉页带 opener 数据）演示页眉两种逻辑、列表、两栏 composer、`#pause` → 第 2 章组件陈列（每页 2–4 个组件）→ 第 3 章表格、公式、图（用仓库内现有图？仓库无示例图：用 Typst 绘制的占位图形，避免引入新位图）→ 致谢（回顾卡）。

## 8. 待实测确认

- Typst 渐变角度方向；径向渐变参数。
- 图片透明度方案。
- 回退字体（Arial + Source Han Sans）下 14pt·比例 主标题宽度是否与原稿 13.6cm 测宽一致；不一致时调整主标题宽度常量。
