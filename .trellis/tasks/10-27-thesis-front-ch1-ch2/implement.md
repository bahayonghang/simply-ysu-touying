# Implement：复刻一（骨架 + P01–P18）

## 前置

- theme-core、speaker-notes 已完成。
- 读父任务 `research/latex-visual-spec.md`、`research/frame-inventory.md`（P01–P18）、`research/notes-contract.md`。
- 原稿路径：`D:\Documents\LYH\200-Learning\00博士毕业\毕业论文\thesis\slides\deck\chapters\{front,chapter1,chapter2}.tex`；口播 `…\slides\deck-notes\chapters\` 同名文件；样式 `…\slides\deck\ysu-defense-modern.sty`。

## 步骤

1. [ ] 骨架：`main.typ`、`chapters/*.typ`（9 个空文件）、`lib/layouts.typ`（`fig`/`asset`）、`lib/icons.typ`、`README.md`。编译出空壳。
2. [ ] `sync-assets.py`；先复制 P01–P18 用到的图片。
3. [ ] P01 封面、P02 总目录、P03/P12 扉页（只用主题 API）。对照 preview。
4. [ ] P04–P11：逐页实现 `lib/layouts.typ` 版式函数并复刻；每页完成即编译、对照。
5. [ ] P13–P18：第 2 章（含公式转写）。
6. [ ] 18 条 `#note` 搬运。
7. [ ] `export-speech.py`，与原稿 speech.md 前 18 页比对。
8. [ ] 备注版编译 + 页标签检查。
9. [ ] 写 `research/visual-diff.md`、`research/deviations.md`，记录编译耗时。
10. [ ] 若有组件需上提主题：在主题中实现、补 `beamer-ysu.typ` 演示、回归 G1。

## 验证命令

```bash
python -I examples/beamer-thesis/sync-assets.py
typst compile --root . examples/beamer-thesis/main.typ
typst compile --root . --input notes=on examples/beamer-thesis/main.typ .tmp/thesis-notes.pdf
python -I examples/check-page-labels.py .tmp/thesis-notes.pdf --expect-notes
python -I examples/beamer-thesis/export-speech.py --out .tmp/speech.md
typst compile --root . examples/beamer-ysu.typ
git status --short examples/
```

## 回滚点

示例目录不入库；主题若有上提改动，单独提交。
