# 偏离点

| 页 | 原稿做法 | Typst 做法 | 原因 |
| --- | --- | --- | --- |
| 全部 | `\DefenseFigure` 与 `\ysuAssetFigure` 两种入口，图片经 `\graphicspath{{../../fig/}{../../}}` 查找 | 单一 `img(path)`，路径固定为 `img/<path>`；`sync-assets.py` 按 `.build-img` → `fig/` → 论文根目录的顺序复制 | Typst 没有 graphicspath；把查找放进同步脚本，模板代码只剩一种写法。design.md 计划的 `fig`/`asset` 两个函数合并为一个 |
| 全部 | `\usepackage{fontawesome5}` | Font Awesome 5 Free Solid 字体经 `--font-path` 引入，`lib/icons.typ` 按语义名映射字符；`--input icons=off` 关闭 | 不增加 `@preview/fontawesome` 依赖；TeX Live 已带该字体 |
| 全部 | 88 页 | 当前 23 页：P01–P18 加第 3–7 章各一页占位扉页 | 后两批任务补全；占位章保留 `= 标题`，导航栏与总目录能先生成 |
| P02、P11 | preview 写作“智能监测与决策平台” | 按 `.tex` 写作“运行监测与优化平台” | preview 是旧版渲染，以 `.tex` 为准 |
| P09 | preview 写作“脱离数据覆盖” | 按 `.tex` 写作“脱离真实工况” | 同上 |
| P10 | `\ysuProblemSketch` 为 TikZ 绘图 | 用 Typst `curve` 逐段转写，比例 0.65、标注 5.5 pt | 原稿比例 0.75、6 pt 在 Typst 的字宽下会使问题标题与标注换行 |
| P14 | 章节卡正文有 `\\` 强制换行 | 去掉强制换行，自然断行 | 强制换行按 LaTeX 行宽设定，在 Typst 中会留下单字孤行并把表注挤出版心 |
| P14 | `\ysuVarTable` 的 `p{}` 列宽不含 `\tabcolsep` | 列宽用 `fr` 比例 6:11:34:13:14:14，内边距计入列宽 | 百分比列宽减去内边距后“稳定运行”表头会折行 |
| P16、P18 | `\mathbf`、`\boldsymbol` | `mbf(x) = bold(upright(x))`；`\phi` 写作 `phi.alt` | Typst `bold` 对单字母保持斜体；LaTeX `\phi` 的字形是 ϕ |
| 讲稿 | 备注源文件中的公式为 LaTeX | 备注中写 Typst 公式，`export-speech.py` 把希腊字母还原为 `\theta`、`\phi`、`\psi` 等 | 讲稿与原稿 `speech.md` 逐字一致；后续章节的 `\mathrm{}`、`\boldsymbol{}` 写法需在后续批次扩展映射 |
| 讲稿 | 答辩人取自驱动文件宏 | `export-speech.py` 从 `main.typ` 的 `author: [...]` 读取 | `<ysu-note>` 记录不含文档信息；不为此修改主题 |
| 主题 | — | `_plain` 增加公式转写；`<ysu-note>` 记录增加 `kind`、`sub`、`chapter-no` 字段 | 讲稿导出需要页类型、小节与章号；改动在 `themes/ysu-beamer.typ`，需单独提交 |
