# Implement：演讲备注

## 前置

- theme-core 已完成（`slide` 包装器与结构页包装器稳定）。
- 读 `research/notes-contract.md`（父任务）与 touying `src/core.typ` 中 `touying-slide`、`speaker-note`、`show-notes-on-second-screen` 相关段落（约 2814–3040 行）、`src/utils.typ:1541-1600`。

## 步骤

1. [ ] Spike 方案 A（design §2），结论写入本任务 `research/spike.md`（命令、报错/成功输出、PDF 标签与 MediaBox 检查结果）。
2. [ ] 选定方案后实现 `note`、`_slide-notes` state、`_notes-page`，接入 `slide` 与全部结构页包装器。
3. [ ] 实现 `<ysu-note>` 元数据（页号、帧标题、章名、纯文本）。
4. [ ] 写 `examples/check-page-labels.py`（标准库），输出页标签序列与 MediaBox 尺寸，校验成对结构，失败退出码 1。
5. [ ] 在 `examples/beamer-ysu.typ` 加入 `#note` 示例（含多段、加粗、公式、`#pause` 页）。
6. [ ] 验证：关闭/开启两种编译、页标签、页脚页码、query 输出。
7. [ ] 写 `research/usage.md`：用法、编译命令、FerroStage/pympress 使用提示、建议不用 `#pause` 的说明。

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
