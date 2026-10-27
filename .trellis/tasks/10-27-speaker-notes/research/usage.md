# 演讲备注用法（README 片段草稿，release 子任务落地）

## 写法

```typ
#show: ysu-theme.with(
  // typst compile --input notes=on 时生成备注页
  notes: sys.inputs.at("notes", default: "off") == "on",
  config-info(...),
)

#title-slide(note: [各位老师好，我汇报的题目是……])
#outline-slide(note: [汇报分为……])

= 绪论
#chapter-opener(question: [...])
#note[本章回答……]          // 扉页的备注写在一级标题之后

== 1.1 研究背景
#takeaway[...]
正文……
#note[
  第一段口播，可含 *加粗* 与行内公式 $x^2$。

  第二段口播。
]

#ending-slide(note: [以上是我的汇报……])
```

- `#note[...]` 可写在幻灯片正文任意位置；同一页多次调用按段落拼接。
- 封面、目录、致谢没有正文，用 `note:` 参数。
- 备注同时写入 pdfpc（`typst query <file> "<pdfpc-file>"`）。

## 编译

```bash
typst compile --root . slides.typ                          # 投屏版：无备注页
typst compile --root . --input notes=on slides.typ notes.pdf  # 备注版
```

备注版每帧之后紧跟一张备注页：

- 尺寸：宽 = 幻灯片宽，高 = 宽 × 13.5/16（16:9 为 16cm × 13.5cm）。
- 深色底 `#252320`，18pt / 24pt，加粗为亮白。
- PDF 页标签：幻灯片 `N`，备注页 `notes:N`。FerroStage 与 pympress 据此识别备注页；页脚页码仍为 `N / 总帧数`。

检查页标签：

```bash
python -I examples/check-page-labels.py notes.pdf --expect-notes
```

## 导出口播稿

```bash
typst query --root . slides.typ "<ysu-note>" --field value
```

每条记录：`frame`（帧序号，从 1 起，含封面）、`page`（物理页）、`title`（帧标题：二级标题；扉页为章名；封面/目录/致谢为其标题）、`chapter`（所属章，封面目录为 null）、`text`（纯文本，段落以空行分隔）。

## 建议

答辩稿一帧一页、不用 `#pause`：分步页的备注页只跟在最后一个子页之后，翻页时前几个子页看不到备注。
