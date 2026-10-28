# P01–P18 目视对照

对照方法：`.tmp/thesis/out.pdf` 以 110 dpi 渲染，与原稿 `thesis/slides/deck/preview/page-NNN.png`（693×390）左右并排（左原稿、右 Typst）逐页检查。图片尺寸另用 PyMuPDF 读取 PDF 中的图像框核对，像素目测不可靠（P15 曾误判偏窄，实测 13.2×5.2 cm 与原稿一致）。

结论：18 页版式、配色、文字、断行与原稿一致或接近，未见未解释的明显偏差。下表只列可见的细小差异。

| 页 | frame | 结果 | 残留差异 |
| --- | --- | --- | --- |
| P01 | cover | 一致 | — |
| P02 | toc | 一致 | 第 6 章标题按 `.tex` 写作“运行监测与优化平台”，preview 为旧文（见 deviations） |
| P03 | c1-toc | 接近 | 章号“01”约大 10%；本章内容由 `==` 标题自动生成，与原稿一致 |
| P04 | c1-background-1 | 接近 | 柱状图略小（矢量图按高度 4.4 cm 装入） |
| P05 | c1-plant | 接近 | 右栏图片与“两类目标”上移约 0.2 cm |
| P06 | c1-background-2 | 一致 | — |
| P07–P09 | c1-status-* | 一致 | P09 末条按 `.tex` 写作“脱离真实工况” |
| P10 | c1-challenges | 接近 | 问题草图为 TikZ 手工转写，曲线形态略有不同；草图标注改为 5.5 pt 以免换行 |
| P11 | c1-organization | 接近 | 右侧章名按 `.tex` 写作“运行监测与优化平台” |
| P12 | c2-toc | 接近 | 同 P03 |
| P13 | c2-foundation-1 | 一致 | — |
| P14 | c2-variables | 接近 | 表注框底边贴近页脚；章节卡去掉了原稿为 LaTeX 行宽设定的强制换行 |
| P15 | c2-foundation-2-flow | 一致 | — |
| P16 | c2-foundation-2-detail | 接近 | 行距比原稿略紧，底部总结框略高 |
| P17 | c2-foundation-3-flow | 接近 | 框架图比原稿低约 0.2 cm |
| P18 | c2-foundation-3-detail | 接近 | 原稿 preview 中第 4 条约束的 Δ 未显示（渲染问题），Typst 按 `.tex` 显示 Δ |

## 验证记录

- `python -I examples/beamer-thesis/sync-assets.py`：copied 0, skipped 11, missing 0。
- 普通版 23 页（18 页正文 + 第 3–7 章占位扉页 5 页）；`check-page-labels.py` 通过（无备注页）。
- 备注版 46 页；`check-page-labels.py --expect-notes` 通过（frames 23, notes pages 23）。
- `export-speech.py` 输出与原稿 `deck-notes/speech.md` 第 1–18 页逐页一致（分部标题、页标题、正文、公式写法）；页眉仅总页数与字数不同（18 页 2019 字 vs 88 页 8438 字）。
- 编译耗时（Typst 0.15.1，Windows 11，单次冷启动）：普通版 0.72–0.75 s，备注版 0.70 s，`icons=off` 0.69 s。
