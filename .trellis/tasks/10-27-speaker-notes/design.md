# Design：演讲备注

继承父任务 `design.md` §5 与 `research/notes-contract.md`。

## 1. API

```typ
#let note(body) = { ... }            // 公开，主题导出
#show: ysu-theme.with(notes: sys.inputs.at("notes", default: "off") == "on")
```

`note` 同时完成三件事：

1. `speaker-note(body)`（touying）——保留 pdfpc。
2. `[#metadata((kind: "ysu-note", text: _plain(body))) <ysu-note>]`——导出用。页号、帧标题、章名在导出时由 `query` 结果的 `location()` 与 `heading` 查询补齐（导出脚本走 `typst query` 时拿不到 location，所以元数据里直接存：在 `context` 内取 `here().page()`、当前二级/一级标题文本）。
3. 写入 `_slide-notes` state（追加），供备注页渲染。

## 2. 备注页插入（方案 A，优先）

- theme-core 的 `slide` 包装器（以及所有结构页包装器）在 touying 输出之后返回 `{ touying-output; _notes-page(self) }`。
- `_notes-page`：`if self.store.notes { page(width: W, height: W * 13.5 / 16, margin: (x: 0.5cm·比例, y: …), fill: …, numbering: "notes:1", header: none, footer: none, background: none)[ #counter(page).update(n => n - 1) #context _slide-notes.get() ] ; _slide-notes.update(none) }`。
- 页码处理：`counter(page).update(n => n - 1)` 在备注页内执行，使备注页标签与上一内容页同号；下一内容页因 `counter(page)` 自增恢复正常序号。需确认 touying 的 `slide-counter`（逻辑页码，页脚使用）不因备注页增加——备注页不经过 touying，不会触发 slide-counter step。
- 总页数：页脚 `N / total` 用 touying `utils.last-slide-number`（基于 slide-counter），不受物理页影响；需实测。
- subslide：touying 对一帧的每个 subslide 调用同一回调；只在 `self.subslide == self.repeat`（最后一个）时追加备注页。

### 方案 A 的 spike 步骤

1. 在 scratchpad 建最小 touying 文档（simple 主题即可），在一个自定义 `slide` 包装器里返回 `touying-slide(...)` 后追加 `page(...)[...]`。
2. 检查：能否编译（`page` 是否落在容器中报错）、页序、页标签、页脚页码、touying 的 `#pause`。
3. 若失败（典型报错 “pagebreaks are not allowed inside of containers”），转方案 B。

## 3. 方案 B（备选）：外层重排

Typst 的 show 规则和 `page.foreground`/`background` 都不能凭空插入新页，所以方案 B 是两次编译：一次出内容 PDF，一次用 touying `config-common(show-only-notes: true)` 思路只出备注页（尺寸与配色按 §5），再用外部脚本把两份 PDF 交错合并并写入 `notes:N` 页标签。它引入 PDF 后处理依赖，只作次选。

## 4. 方案 C（保底）

`config-common(show-notes-on-second-screen: right)`：touying 原生，把备注拼在内容页右侧（双宽页面）。pympress 可用；FerroStage 契约（独立页 + `notes:N`）不满足。仅当 A、B 都不可行时采用，并在 PRD 验收中标注偏离。

## 5. 备注页排版

- 字号：原稿 18pt 对 16cm 宽纸面；Typst 页宽 841.89pt → 18 × 1.856 ≈ 33.4pt。
- `show strong: set text(fill: rgb("#FAF9F5"))`，正文 `rgb("#E6DFD8")`。
- `set par(first-line-indent: 0pt, spacing: 0.4em, leading: (24-18)/18 em 换算)`, `justify: false`。
- 数学：继承正文字体颜色。

## 6. 页标签检查脚本

`scripts/check-page-labels.py`？——仓库不应新增发布无关脚本到包内；放在 `docs/` 外的 `.trellis/tasks/<本任务>/research/check_labels.py` 或示例目录。决定：放 `examples/check-page-labels.py`（examples 不入包，入库），供两份示例共用。实现只用标准库（解析 `/PageLabels` Nums 数组与各页 MediaBox，用正则即可，Typst 输出未压缩这些对象——spike 已验证）。
