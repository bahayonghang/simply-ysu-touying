# Spike：在 touying 流水线中插入独立备注页（2026-10-27）

环境：Typst 0.15.1，touying 0.6.3。样例：`.tmp/notes/spike.typ`（simple 主题 + 自定义 `slide-fn`）。

## 方案 A：包装器在 `touying-slide(...)` 之后追加顶层 `page(...)`

```typ
#let myslide(..args) = touying-slide-wrapper(self => {
  touying-slide(self: self, ..args)
  page(width: 16cm, height: 13.5cm, numbering: "notes:1", fill: rgb("#252320"), ...)[
    #counter(page).update(n => n - 1)
    #context query(<ysu-note-body>).filter(m => m.location().page() == here().page() - 1) ...
  ]
})
#show: simple-theme.with(config-page(width: 16cm, height: 9cm, numbering: "1"), config-common(slide-fn: myslide))
```

结果（PyMuPDF 读取，`ageLabel` 前缀是 PyMuPDF 对无前缀标签的误读，原始 PDF 中为 `/S/D/St N`）：

| 物理页 | 标签 | 高 | 内容 |
|---|---|---|---|
| 1 | 1 | 9cm | 节标题页（未走 myslide，无备注页） |
| 2 | 2 | 9cm | Slide A |
| 3 | notes:2 | 13.5cm | Note A 𝑥² |
| 4 | 3 | 9cm | Slide B 子页 1 |
| 5 | 3 | 9cm | Slide B 子页 2 |
| 6 | notes:3 | 13.5cm | 两条备注按段拼接 |
| 7 | 4 | 9cm | 页脚逻辑页码 `4 / 4` |
| 8 | notes:4 | 13.5cm | （空） |

结论：

1. 顶层 `page()` 能被 touying 接受，无 “pagebreaks are not allowed inside of containers”。
2. touying 默认冻结 `counter(page)`，同一帧的子页共用标签 N；备注页 `counter(page).update(n => n - 1)` 后与 N 同号。满足 `notes:<该帧最后一页>`。
3. 备注页不经过 touying，`slide-counter` / `last-slide-counter` 不变，页脚总数不翻倍。
4. 逐页 MediaBox 独立（453.54×255.12 与 453.54×382.68）。

`touying-fn-wrapper` 不可用于区分子页：自动计算 repeat 的首轮解析时 `self.repeat` 尚未设置。最终实现改为“每帧之后的尾部按文档顺序收集备注”，与子页无关。

**选定方案 A**。方案 B（两次编译 + PDF 合并）与 C（touying 双屏拼页）不再需要。

## 实现中发现的两点

- **关闭备注时尾部 `context` 落在下一帧的页面上**（它在上一帧 `set page` 作用域之外，属于下一页）。所以备注不能按 `here().page()` 取，改为：取上一个 `<ysu-note-tail>` 之后、当前位置之前的 `<ysu-note-body>`，再只保留其中最大页号（最后一个子页）的那些。开、关两种模式共用此逻辑。
- **`new-section-slide` 的 `body` 原先在 `context` 内**，touying 解析不到其中的 `speaker-note`（pdfpc 缺失）。改为 `slide-body + body` 传给 `touying-slide`，版面不变。

## FerroStage 实测

本机已装 FerroStage（`%LOCALAPPDATA%/Programs/FerroStage/ferrostage.exe`），但只有 GUI，无命令行检测。GUI 打开检查：**未验证**，以 `examples/check-page-labels.py --expect-notes` 通过为准。
