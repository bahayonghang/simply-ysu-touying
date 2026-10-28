# 演讲备注：FerroStage 独立备注页

父任务：`10-27-ysu-defense-1-0`（总体设计 §5；契约与 spike 结果见 `research/notes-contract.md`）。依赖 `10-27-theme-core` 的 `slide` 包装器。

## Goal

学习 `thesis/slides/deck-notes` 的 `\note` 写法与独立备注页功能，在主题中提供 `#note[...]`，开启后生成与 LaTeX 版同契约的 FerroStage / pympress 备注页，并能导出逐页口播打印稿。

## Requirements

1. `#note[...]` 写在任意幻灯片正文中；支持多段、`*加粗*`、行内公式、转义字符；同一页多次调用按段落拼接。
2. `ysu-theme(notes: false)` 默认关闭，关闭时不产生任何可见内容、不改变页数。
3. 开启时：每个内容页（含封面、目录、扉页、致谢）之后紧跟一张备注页。
   - 备注页尺寸 16cm × 13.5cm（按 16:9 页面宽度等比：宽 = 内容页宽，高 = 宽 × 13.5/16）。
   - 底色 `#252320`，正文 `#E6DFD8`，加粗 `#FAF9F5`；18pt/24pt（按页面比例换算），段距 0.4em，无首行缩进，左右 0.5cm 留白，左对齐。
   - PDF 页标签：内容页 `N`，备注页 `notes:N`。
   - 无备注的页仍生成备注页（空白，或可配置为跳过——默认生成，保证 `2N` 页的成对结构）。
4. 开启备注不改变内容页页脚的 `N / 总数`。
5. 一帧多 subslide（`#pause`）时，备注页只跟在最后一个 subslide 后；文档注明答辩稿建议不用 `#pause`。
6. pdfpc：`note` 内容同时进入 touying pdfpc 元数据。
7. 导出：每条备注带 `<ysu-note>` 元数据（页号、帧标题、章名、纯文本）；`typst query` 可取到 JSON。
8. `README`（release 子任务落地）需要的用法片段在本子任务的 `research/usage.md` 中写好。

## Acceptance Criteria

- [ ] spike 结论写入 `research/spike.md`，选定方案（A 包装器追加页 / B 外层重排 / C touying 双屏回退）并给出依据。
- [ ] 在 `examples/beamer-ysu.typ` 中加入若干 `#note`；`typst compile --root . --input notes=on examples/beamer-ysu.typ .tmp/notes.pdf` 生成 `2N` 页。
- [ ] 页标签检查脚本（Python，读取 PDF `/PageLabels`，无第三方依赖或仅用 pypdf）输出 `1, notes:1, 2, notes:2, …`，且内容页 MediaBox 16:9、备注页 16:13.5。
- [ ] 关闭备注时页数与改动前一致。
- [ ] 备注版内容页页脚显示 `N / N_total`（不是 2N）。
- [ ] `typst query --root . examples/beamer-ysu.typ "<ysu-note>" --field value` 输出每条备注的 JSON。
- [ ] 用 FerroStage 或 pympress 打开备注版 PDF，识别为独立备注页（若本机无该软件，记录为“未验证”，以页标签检查为准）。

## Out of Scope

- `speech.md` 导出脚本本体放在复刻示例（thesis-front-ch1-ch2 子任务），本子任务只保证 query 数据完整。
