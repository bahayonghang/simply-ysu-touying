# 演讲备注（Notes）契约与 Typst 可行性

来源：`thesis/slides/deck-notes/`（`defense.tex` 的 `notes-sync` 段、`chapters/*.tex` 的 `\note{}`）与 `thesis/slides/AGENTS.md`「deck-notes」「正文同步到 deck-notes」两节。只读分析。

## 1. LaTeX 侧的写法

- 每帧在 `\end{frame}` 前写一条 `\note{...}`，段落用空行分隔，可含 `$...$` 行内公式、`\%` 等转义、`\textbf{}` 加粗。
- 88 帧全部有口播（含封面、目录、扉页、致谢）。
- 原稿无 overlay：一帧一页，一页一备注页。

## 2. LaTeX 侧的产物契约（FerroStage / pympress）

| 项 | 值 |
|---|---|
| 开关 | `\setbeameroption{show notes}`，只在 notes 副本中开启；投屏稿无备注页 |
| 页序 | 内容页 N 之后紧跟其备注页；88 帧 → 176 物理页 |
| 页标签 | 内容页 `N`，备注页 `notes:N`（N 与前一内容页相同）；FerroStage 据此识别独立备注页，缺前缀会被当成普通翻页 |
| 备注页尺寸 | 16cm × 13.5cm（453.5 × 382.7 bp）；内容页仍为 16cm × 9cm |
| 备注页底色 | `#252320` |
| 正文色 | `#E6DFD8`；加粗色 `#FAF9F5`（`\textbf` 被重定义） |
| 排版 | 18pt / 24pt 行距，段距 0.4em，无首行缩进，左右各 0.5cm 留白，左对齐不两端 |
| 溢出 | 不自动缩字、不截断；密集页需目视检查 |
| 打印稿 | `just slides-notes-export` 从各帧 `\note` 导出 `speech.md`：开场/各章/致谢用二级标题分开，每页三级标题 `第 N 页　标题`，页间 `---` |

## 3. Typst 可行性（2026-10-27 spike，scratchpad，Typst 0.15.1）

最小样例：

```typ
#set page(width: 16cm, height: 9cm, numbering: "1")
Slide one
#page(width: 16cm, height: 13.5cm, fill: rgb("#252320"), numbering: "notes:1")[
  #counter(page).update(n => n - 1)
  Notes for slide one
]
```

PDF 结果：

- `/PageLabels` 依次为 `{S/D St 1}`、`{S/D P(notes:) St 1}`、`{S/D St 2}`、`{S/D P(notes:) St 2}` —— 即标签 `1, notes:1, 2, notes:2`，满足 FerroStage 契约。
- MediaBox：内容页 453.54 × 255.12，备注页 453.54 × 382.68 —— 每页独立尺寸可行。

结论：页标签前缀与逐页尺寸在 Typst 原生可行，无需后处理 PDF。

## 4. 待在实现时验证的风险

1. **在 touying 流水线中插入独立页面**：touying 0.6.3 由 `touying-slide` 生成每页（`core.typ` 约 3040 行起），页面参数通过 `set page` 下发。需验证：在主题的 `slide` 包装器返回内容之后追加一个顶层 `page(...)[...]` 是否被 touying 接受（`page` 不能出现在容器内）。备选：
   - 方案 B：备注模式下由主题自行在 `touying-slides` 外层 show 规则里按 `<ysu-note>` 元数据重排页面（复杂，尽量避免）。
   - 方案 C：回退到 touying 自带 `config-common(show-notes-on-second-screen: right)`（pympress 双屏拼接版式），并在文档中说明与 FerroStage 独立备注页的差异。
2. **页码计数**：备注页不能推进 touying 的 `slide-counter` / 逻辑页码，页脚 `N / 88` 的总数不能变成 176。
3. **subslide（`#pause`）**：一帧多页时，备注页只跟在该帧最后一个 subslide 之后，标签为 `notes:<该帧最后一页的页码>`；并在文档中建议答辩稿不用 `#pause`（与原稿约定一致）。
4. **pdfpc 兼容**：`note` 同时调用 touying `speaker-note`，保证 `typst query ... <pdfpc-file>` 导出的 .pdfpc 仍带备注。
5. **导出 speech.md**：每条备注附 `metadata((page:, title:, chapter:, text:)) <ysu-note>`，用 `typst query --field value main.typ "<ysu-note>"` 得到 JSON，再由示例目录的小脚本写成与原稿同结构的 `speech.md`。
