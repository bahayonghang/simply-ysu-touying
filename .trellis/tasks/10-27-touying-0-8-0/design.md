# Design：升级 Touying 到 0.8.0

## Boundary

Touying 仍是唯一依赖。主题继续从包根 `#import "@preview/touying:0.8.0": *`，不改为按 0.8.0 的新模块路径导入。

公开 API、页面几何和备注页契约不变。0.8.0 的新能力不接入。

包版本保持已经改好的 `0.2.0`。

## Contract

`ysu-theme` 的 `config-common` 在现有键之外增加一个显式值：

- `receive-body-for-new-section-slide-fn: true`。0.7.3 起这项默认改为 `false`，0.8.0 仍是 `false`。不设置时，`examples/beamer-ysu.typ` 仍能编译，但五张扉页与后文拆开，21 页变成 26 页。设置之后，16:9、4:3 和备注版 PDF 与 0.6.3 逐字节相同。

不设置 `breakable`。0.8.0 的默认是 `true`，同一组对照编译已经与 0.6.3 逐字节相同，所以不把这项钉成 `false`。

不设置 `notes-fn`、`show-only-notes` 或 `show-notes-on-second-screen`。备注页仍由 `_emit` 在 `touying-slide` 之后追加 `page()`。`speaker-note(body)` 的调用保留，pdfpc 仍由 Touying 解析器写入。

`ysu-beamer.typ` 的星号导入会把 `measure` 绑到 Touying 的 `measure`，而不是 `std.measure`。对照 PDF 已经相同，本次不改这些调用。`themes/components.typ` 不导入 Touying，仍用 `std.measure`。

`lib.typ` 继续重导出 Touying 与 `themes/ysu-beamer.typ`。只有包根不再导出主题正在用的名字时，才在 `lib.typ` 里补一层转发。调研结论是这些名字都还在包根。

## Data flow

用户稿 → `ysu-theme` → `touying-slides`（扉页继续接收正文）→ `slide` / `new-section-slide` → `_emit` → 内容页，以及在 `notes: true` 时的备注页。

答辩稿 `examples/beamer-thesis/main.typ` 通过 `#import "/lib.typ": *` 使用主题，所以它跟仓库示例走同一份实现。验收编译它，但不改它的章节，也不把它提交。

## Trade-off

不钉 `breakable: false`。仓库示例在默认 `breakable: true` 下已经与 0.6.3 逐字节相同。答辩稿随后也按 88 帧编过，投屏版 88 页、备注版 176 页，没有多出拆页。

不把自定义备注页改成 `notes-fn`。那个钩子服务的是 Touying 的双屏备注和 `show-only-notes`，不是现在的独立 `notes:N` 页。

## Rollback

还原 `@preview/touying:0.8.0` 为 `0.6.3`，并删掉 `config-common` 里新增的 `receive-body-for-new-section-slide-fn: true`。包版本 `0.2.0` 的改动不属于这次回滚。
