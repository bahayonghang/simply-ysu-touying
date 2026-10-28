# Implement：演讲备注

## 前置

- theme-core 已完成（`slide` 包装器与结构页包装器稳定）。
- 读 `research/notes-contract.md`（父任务）与 touying `src/core.typ` 中 `touying-slide`、`speaker-note`、`show-notes-on-second-screen` 相关段落（约 2814–3040 行）、`src/utils.typ:1541-1600`。

## 步骤

1. [x] Spike 方案 A（design §2），结论写入本任务 `research/spike.md`（命令、报错/成功输出、PDF 标签与 MediaBox 检查结果）。
2. [x] 选定方案后实现 `note`、`_slide-notes` state、`_notes-page`，接入 `slide` 与全部结构页包装器。
3. [x] 实现 `<ysu-note>` 元数据（页号、帧标题、章名、纯文本）。
4. [x] 写 `examples/check-page-labels.py`（标准库），输出页标签序列与 MediaBox 尺寸，校验成对结构，失败退出码 1。
5. [x] 在 `examples/beamer-ysu.typ` 加入 `#note` 示例（含多段、加粗、公式、`#pause` 页）。
6. [x] 验证：关闭/开启两种编译、页标签、页脚页码、query 输出。
7. [x] 写 `research/usage.md`：用法、编译命令、FerroStage/pympress 使用提示、建议不用 `#pause` 的说明。

## 验证命令

```bash
typst compile --root . examples/beamer-ysu.typ .tmp/notes-off.pdf
typst compile --root . --input notes=on examples/beamer-ysu.typ .tmp/notes-on.pdf
python -I examples/check-page-labels.py .tmp/notes-on.pdf --expect-notes
python -I examples/check-page-labels.py .tmp/notes-off.pdf
typst query --root . examples/beamer-ysu.typ "<ysu-note>" --field value
```

## 回滚点

- 备注功能全部受 `notes` 开关与 `note` 函数隔离；回滚只需撤销本子任务提交。

## 执行记录（2026-10-27）

- 方案 A 通过，见 `research/spike.md`。
- 结构页备注：`title-slide` / `outline-slide` / `ending-slide` 新增 `note:` 参数；扉页备注写在 `= 标题` 之后（`new-section-slide` 的 body 移出 `context`）。
- 所有包装器改经 `_emit(self, title:, ..)`：`touying-slide` + `_notes-tail`。
- 示例：notes 关 21 页（与改动前一致）；开 40 页 = 21 + 19 帧备注页；16:9 与 4:3 均通过 `check-page-labels.py --expect-notes`。
- FerroStage GUI 未验证（无 CLI 检测）。
