# P19–P51 目视对照

对照方法同首批：`.tmp/thesis/out.pdf` 以 110 dpi 渲染，与 `thesis/slides/deck/preview/page-NNN.png` 左右并排（左原稿、右 Typst，`.tmp/thesis/tools/cmp.py`）逐页检查。溢出另页用 PyMuPDF 逐页读首行文字检出（溢出页只剩节标题）。

结论：33 页版式、配色、文字与原稿一致或接近，未见未解释的明显偏差。全稿 54 页 = P01–P51 加第 5–7 章三页占位扉页（见 deviations）。

编译时间（Typst 0.15.1，本机）：普通版 1.51 s，备注版 1.45 s。

| 页 | frame | 结果 | 残留差异 |
| --- | --- | --- | --- |
| P19 | c3-toc | 一致 | — |
| P20 | c3-position | 接近 | 框架图高 5.3 cm，右栏块间距略小 |
| P21 | c3-intro | 接近 | 方法卡第三行折行位置不同 |
| P22 | c3-problem | 一致 | — |
| P23 | c3-method-1-flow | 一致 | — |
| P24 | c3-method-1-detail | 接近 | 公式行高略小 |
| P25 | c3-method-2-flow | 一致 | — |
| P26 | c3-method-2-detail | 接近 | 底栏固定 0.82 cm，卡片间距按 1fr 均分 |
| P27 | c3-method-3-flow | 接近 | 图高 4.85 cm |
| P28 | c3-method-3-detail | 接近 | 同 P26 |
| P29 | c3-experiment-1 | 接近 | 右框手工排为表头 + 三行 |
| P30 | c3-experiment-2 | 接近 | 表 3-2 字号 7 pt、列宽固定，表体比原稿略窄；“模型类型”表头折两行 |
| P31 | c3-experiment-2-boxplot | 一致 | — |
| P32 | c3-experiment-2-curves | 一致 | — |
| P33 | c3-experiment-3 | 接近 | 两条读数卡折行位置不同 |
| P34 | c3-experiment-4 | 接近 | 表 3-4 首列按原稿两行写法 |
| P35 | c3-experiment-4-trajectory | 接近 | 轨迹图下移约 0.1 cm |
| P36 | c3-experiment-5 | 一致 | — |
| P37 | c3-summary | 接近 | 第三个 KPI 的基准行折为两行；图高 3.15 cm |
| P38 | c4-toc | 一致 | — |
| P39 | c4-position | 接近 | 框架图略小；映射式 7 pt |
| P40 | c4-intro | 接近 | 两组框整体略低约 0.1 cm |
| P41 | c4-problem | 接近 | 示意图略大，公式行略上移 |
| P42 | c4-method-1-flow | 一致 | — |
| P43 | c4-method-2-flow | 一致 | — |
| P44 | c4-method-2-detail | 接近 | 三张公式卡间距 4 pt（原稿 5 pt），以便放进版心 |
| P45 | c4-method-3-flow | 一致 | — |
| P46 | c4-method-3-detail | 接近 | 阶段面板高 3.35 cm（原稿 3.5 cm），整体上移约 0.3 cm |
| P47 | c4-experiment-2 | 一致 | 降幅前的“↓”取自回退字体，比原稿略粗 |
| P48 | c4-experiment-3 | 接近 | 子图高 1.75 cm，比原稿略小 |
| P49 | c4-experiment-4 | 接近 | 底部裁切按 15 % 图高（见 deviations） |
| P50 | c4-experiment-5 | 接近 | 交叉组合图高 1.95 cm，比原稿略矮；小节名按 `.tex` |
| P51 | c4-summary | 接近 | 两条数据来源行字距略紧 |
