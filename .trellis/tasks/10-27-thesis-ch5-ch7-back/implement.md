# Implement：复刻第 5-7 章与致谢（P52–P88）

## 前置

- `10-27-thesis-ch3-ch4` 已完成，全稿可编译 51 页。
- 原稿：`chapter5.tex`、`chapter6.tex`、`chapter7.tex`、`back.tex` 及 deck-notes 同名文件。

## 步骤

1. [ ] 同步本批图片（第 5 章 `pg_final_results/**` 较多，确认 `.build-img` 副本优先）。
2. [ ] 第 5 章 P52–P72（公式、表格、图组）。
3. [ ] 第 6 章 P73–P83（截图窗、裁剪放大图）。
4. [ ] 第 7 章 P84–P87、致谢 P88。
5. [ ] 37 条 `#note`。
6. [ ] `export-speech.py --check` 全文比对。
7. [ ] 备注版 176 页 + 页标签检查。
8. [ ] 汇总 `research/visual-diff.md`（三批）、公式核对、偏离点；记录编译耗时。
9. [ ] 回归 `beamer-ysu.typ`。

## 验证命令

```bash
python -I examples/beamer-thesis/sync-assets.py
typst compile --root . examples/beamer-thesis/main.typ
typst compile --root . --input notes=on examples/beamer-thesis/main.typ .tmp/thesis-notes.pdf
python -I examples/check-page-labels.py .tmp/thesis-notes.pdf --expect-notes
python -I examples/beamer-thesis/export-speech.py --check "D:/Documents/LYH/200-Learning/00博士毕业/毕业论文/thesis/slides/deck-notes/speech.md"
typst compile --root . examples/beamer-ysu.typ
```
