# 燕山大学 Touying 幻灯片模板

[[English]](./README.md)

这是基于 [Touying](https://touying-typ.github.io/touying/zh/) 的燕山大学 Typst 幻灯片主题。1.0 版按博士学位论文答辩稿的版式重写：藏青配色，页眉用面包屑加结论句，带章节扉页、页脚章节导航，以及组织“问题—方法—结论”页面的组件库。演讲备注可编译为独立备注页，供演讲者工具使用。

| 封面 | 章节扉页 | 内容页 |
| --- | --- | --- |
| ![封面](https://raw.githubusercontent.com/bahayonghang/simply-ysu-touying/main/docs/screenshots/beamer-ysu-cover.png) | ![章节扉页](https://raw.githubusercontent.com/bahayonghang/simply-ysu-touying/main/docs/screenshots/beamer-ysu-opener.png) | ![内容页](https://raw.githubusercontent.com/bahayonghang/simply-ysu-touying/main/docs/screenshots/beamer-ysu-content.png) |

## 依赖环境

- Typst `0.14.x` 或 `0.15.x`
- `@preview/touying:0.6.3`（由包自动导入）

## 快速开始

```powershell
typst init @preview/simply-ysu-touying:1.0.0 my-slides
Set-Location my-slides
typst compile main.typ
```

最小示例：

```typ
#import "@preview/simply-ysu-touying:1.0.0": *

#show: ysu-theme.with(
  aspect-ratio: "16-9",                 // 或 "4-3"
  nav-labels: ("背景", "方法", "总结"),   // 页脚章节导航的短名
  config-info(
    title: [报告标题],
    author: [姓名],
    supervisor: [导师#h(1em)教授],
    subject: [学科专业],
    school: [学院名称],
    date: datetime.today(),
    stage: [学术汇报],
    stage-en: [Academic Presentation],
  ),
)

#title-slide()
#outline-slide()

= 研究背景
#chapter-opener(question: [本章要回答的#hl[核心问题]是什么？], keywords: ([关键词一], [关键词二]))

== 1.1 研究背景
#sub[1.1.1 可选的小节]
#takeaway[用一句话写出本页结论，它会成为页眉主标题]

正文内容。

#ending-slide()
```

直接在克隆的仓库里使用时，改为导入主题文件：

```typ
#import "@preview/touying:0.6.3": *
#import "themes/ysu-beamer.typ": *
```

内置示例演示全部组件：

```powershell
typst compile --root . examples/beamer-ysu.typ
typst compile --root . --input ratio=4-3 examples/beamer-ysu.typ   # 4:3 版
```

## 结构页

| 写法 | 页面 |
| --- | --- |
| `title-slide(research-line: ((no:, icon:, label:), ...), note:)` | 封面：左侧白底标题，右侧深色栏放阶段标签与研究主线 |
| `outline-slide(title:, groups: ((from:, to:, tags:, icons:),), note:)` | 目录：每个一级标题一行，`groups` 高亮连续的核心章节 |
| `= 章名` + `chapter-opener(question:, keywords:, icon:, outline:, bridge:)` | 章节扉页：章号、章名、本章问题、关键词、本章二级标题与承接行 |
| `== 页名` | 内容页；面包屑显示章、二级标题与 `sub` |
| `sub[...]` / `takeaway[...]` | 当前页的面包屑小节 / 页眉结论句 |
| `slide(composer: (1fr, 1fr))[...][...]` | 自由内容页，支持 Touying 分栏与 `#pause` |
| `ending-slide(title:, kicker:, recap: ((title:, chapter:, icon:, body:, tags:), ...), note:)` | 致谢页；给出 `recap` 时显示贡献回顾卡 |

`ysu-theme` 参数：`aspect-ratio`（`"16-9"` 或 `"4-3"`）、`align`（正文竖直对齐）、`nav-labels` 与 `nav-full-labels`（页脚与扉页的章节名，默认取一级标题）、`font: (latin:, cjk:)`、`notes`（备注页，见下文）。

## 组件一览

| 组件 | 用途 |
| --- | --- |
| `hl[...]`、`key[...]` | 藏青加粗术语；红色加粗关键结论 |
| `tag`、`pill`、`tab-pill`、`edge-label`、`icon-disc` | 标签、胶囊与图标圆片 |
| `conclude(label:, red-label:, pill:)`、`base-bar`、`section-bar` | 通栏结论条与分节标题 |
| `title-box(title:, icon:, aside:)`、`tblock(title:)` | 藏青标题栏卡片（`tblock` 保留为别名） |
| `group-box(label:, red:)`、`sub-box`、`dash-box`、`label-row` | 分组要点，如问题组与方法组 |
| `block-arrow[...]` | 分组之间带文字的块箭头 |
| `red-frame(label:, center:)` | 红框目的句或约束句 |
| `card`、`side-card`、`paper-box`、`points` | 卡片、带侧标签卡片、论文列表、编号要点 |
| `kpi(label:, value:, basis:, key:)` | 关键数字，顶部藏青粗线 |
| `figure-box(caption:)`、`fig-caption`、`eq-block(number:, note:)`、`eq-number` | 论文风格的图与公式 |
| `reading-card(title:)`、`screen-frame(title:)` | 读数卡；现场截图的深色窗框 |
| `result-table(header:, rows:, mark:)` | 藏青表头、可标记行的结果表 |

颜色与渐变（`ysu-navy`、`ysu-red`、`ysu-tint`、`grad-key` 等）以及 `seal()`、`wordmark()`、`logo()` 也一并导出。

## 演讲备注

`#note[...]` 可写在幻灯片正文任意位置，同一页多次调用按段落拼接。封面、目录、致谢用 `note:` 参数；章节扉页的备注写在 `= 章名` 之后。

```typ
#show: ysu-theme.with(
  notes: sys.inputs.at("notes", default: "off") == "on",
  config-info(...),
)

#title-slide(note: [各位老师好，我汇报的题目是……])

== 1.1 研究背景
#note[第一段口播。

第二段口播。]
```

```powershell
typst compile --root . slides.typ                              # 投屏版
typst compile --root . --input notes=on slides.typ notes.pdf   # 每页之后一张备注页
```

备注页与幻灯片同宽（16:9 时为 16 cm × 13.5 cm），深色底、18 pt。PDF 页标签幻灯片为 `N`、备注页为 `notes:N`，FerroStage 与 pympress 据此配对；可用 `examples/check-page-labels.py notes.pdf --expect-notes` 检查。备注同时写入 pdfpc。口播稿可用 `typst query --root . slides.typ "<ysu-note>" --field value` 导出为 JSON。用 `#pause` 分步的页面，备注页只跟在最后一个子页之后。

## 字体

推荐安装思源黑体 Source Han Sans SC（中文）与 Source Sans 3（西文）。回退顺序：中文 Source Han Sans → Noto Sans SC → 微软雅黑，西文 Source Sans 3 → Arial；可用 `font: (latin: (...), cjk: (...))` 修改。

## 从 0.2.x 迁移

1.0.0 含破坏性变更。

- 删除 `ysu-theme` 参数：`progress-bar`、`watermark`、`footer-columns`、`footer-a` … `footer-d`。页脚改为“作者 · 阶段”、章节导航（`nav-labels`）与页码。
- 页面尺寸改为 16 cm × 9 cm（4:3 为 12 cm × 9 cm），不再用 `presentation-16-9`；正文默认竖直居中（`horizon`）。
- `config-info` 新增 `supervisor`、`subject`、`school`、`stage`、`stage-en`，封面使用这些字段；`institution`、`subtitle`、`short-title` 不再显示。
- `title-slide(extra:)` 改为 `research-line:`；`ending-slide` 改用 `title:`、`kicker:` 与 `recap:`。
- 新增页面标记 `sub[...]`、`takeaway[...]`、`chapter-opener(...)` 与上面的组件库；`tblock` 保留为 `title-box` 的别名。
- 配色由燕大蓝（`#2B69C1`）改为藏青 `#1F296A` 加红色 `#B42318` 强调；字体由楷体 / Times New Roman 改为思源黑体 / Source Sans 3。
- 不再依赖 `@preview/cuti`：主题使用字体的真实粗体，不再用伪粗体。

## 目录结构

- `lib.typ`：包入口
- `themes/ysu-beamer.typ`：主题、结构页与备注
- `themes/components.typ`：组件库
- `themes/tokens.typ`：颜色、渐变、字体与校标
- `themes/assets/`：燕山大学视觉资源
- `template/main.typ`：`typst init` 使用的模板入口

## 视觉资源说明

学校品牌资源的来源链接、转换方式、许可边界与 Typst Universe reviewer note 统一记录在 [`ASSETS.md`](./ASSETS.md)。

## 许可与资源说明

- 主题和库源码按 MIT License 发布。
- 根目录 [`LICENSE`](./LICENSE) 同时保留上游 `QuadnucYard` 与当前作者 `Geekyhang` 的版权声明，用于说明本仓库是在上游工作基础上的 MIT 衍生与扩展实现。
- `template/main.typ` 中的模板起始内容额外按 MIT No Attribution 提供，详见 [`LICENSE-MIT-0.txt`](./LICENSE-MIT-0.txt)。
- `themes/assets/ysu-*` 这类带有学校品牌元素的资源不属于 `typst.toml` 中 SPDX 许可表达式覆盖范围，详见 [`ASSETS.md`](./ASSETS.md) 中的文件清单、来源、转换说明与 reviewer 指引。
- 向 Typst Universe 提交时，应在 reviewer note 里说明包内只保留主题所需的 `ysu-*` 资源，并将其来源与再使用边界指向 [`ASSETS.md`](./ASSETS.md)。

## License

Licensed under the [MIT License](LICENSE).
