# Implement：升级 Touying 到 0.8.0

按这个顺序做。前一步编译失败时，只修报错，不扩大范围。

## Checklist

1. 把下列文件里的 `@preview/touying:0.6.3` 改为 `@preview/touying:0.8.0`：`lib.typ`、`themes/ysu-beamer.typ`、`examples/beamer-ysu.typ`、`README.md`、`README.zh.md`、`AGENTS.md`、`.trellis/spec/theme/index.md`、`.trellis/spec/package/packaging-guidelines.md`。归档任务和日记不要改。
2. 在 `themes/ysu-beamer.typ` 的 `ysu-theme` → `config-common` 增加 `receive-body-for-new-section-slide-fn: true`。不要设置 `breakable`，不要实现 `notes-fn`。
3. 编译仓库示例：
   - `typst compile --root . examples/beamer-ysu.typ`
   - `typst compile --root . --input ratio=4-3 examples/beamer-ysu.typ`
   - `typst compile --root . --input notes=on examples/beamer-ysu.typ .tmp/notes.pdf`
   - `python -I examples/check-page-labels.py .tmp/notes.pdf --expect-notes`
4. 编译答辩稿，不入库、不 `sync`：
   - `just --justfile examples/beamer-thesis/justfile build`
   - `just --justfile examples/beamer-thesis/justfile notes`
5. 确认 `simply-ysu-touying` 的版本引用仍是 `0.2.0`，且 `examples/beamer-thesis/` 不在 `git status` 的待提交列表里。

## If compilation fails

- 缺符号：按 `research/touying-0.8-migration.md` 查 0.8.0 的 `src/exports.typ`。能从包根拿到就改调用；不能就停下来改计划。
- 页数或页标签变了：先检查 `receive-body-for-new-section-slide-fn: true` 是否按 design 写上。仓库示例在这项设置后应与 0.6.3 同为 21 页。答辩稿若多出页，再查是不是 `breakable: true` 把溢出拆页，不要提前改这个默认值。
- 答辩稿因 Font Awesome 路径不存在而失败：用该配方的 `icons=off` 重试一次，并在任务记录里写明字体缺失。图标字体以外的编译错误要修。
- 不要改 `examples/beamer-thesis/chapters/` 来迁就新接口。

## Rollback point

第 2 步之后、第 3 步之前，工作区应只多出导入版本和 `receive-body-for-new-section-slide-fn: true`。示例编译失败时，先回到这一点，而不是继续改组件。
