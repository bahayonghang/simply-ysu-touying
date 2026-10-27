# 主题核心：答辩版式替换 ysu-theme

父任务：`10-27-ysu-defense-1-0`（总体设计见其 `design.md` §1–§4，视觉数值见 `research/latex-visual-spec.md`）。

## Goal

把 `themes/ysu-beamer.typ` 重写为原稿的现代藏青答辩版式，沿用 `ysu-theme` 等公开 API 名，并把 `examples/beamer-ysu.typ` 与 `template/main.typ` 迁移到新 API。

## Requirements

1. 令牌：visual-spec §2 全部颜色与五种渐变、§3 字体回退链与字号层级，作为模块级常量导出。
2. 内容页页眉（§4.1）：面包屑、右上校徽、结论句主标题（可多行，下方元素随之下移）、全宽细线 + 红短线；有/无结论句两种逻辑。
3. 页脚（§4.2）：作者·阶段、章节短标签导航（当前章高亮下划线）、渐变平行四边形页码 `N / 总数`。结构页无页脚。
4. 封面（§4.3）、总目录（§4.4，含高亮分组）、章节扉页（§4.5，含 `chapter-opener` 数据与简版退化）、致谢（§4.6，含回顾卡与简版退化）。
5. 组件库：visual-spec §5 表全部通用组件。
6. API：父 design §2 契约；元数据走 `config-info` 扩展键；`#sub[]` / `#takeaway[]` 标记与 `slide(sub:, takeaway:)` 参数等价。
7. 保留 touying 能力：`composer`、`#pause`、`config-*` 覆盖；`aspect-ratio: "4-3"` 可编译且无溢出。
8. 品牌素材只用 `themes/assets/` 现有 5 张位图；彩色/白色横排校标由校徽 + 校名组合。
9. 去掉 `@preview/cuti` 依赖（父 design §3），若实测需要则恢复并记录原因。
10. 迁移 `examples/beamer-ysu.typ`：改写为新主题的通用功能演示（结构页 + 每个组件至少一次 + 多栏 + `#pause` + 表格 + 公式），不含论文内容；迁移 `template/main.typ` 到新 API（版本号在 release 子任务统一改）。

## Acceptance Criteria

- [ ] `typst compile --root . examples/beamer-ysu.typ` 成功，无错误。
- [ ] 渲染 `beamer-ysu` 的封面、目录、扉页、内容页、致谢 PNG，与原稿 P01、P02、P03、P06、P88 目视比对：区块位置、配色、字号层级一致（允许 ±2% 位置偏差）。
- [ ] 同一示例以 `aspect-ratio: "4-3"` 编译成功，无内容溢出页面。
- [ ] `lib.typ` 不变或仅调整导出；`typst.toml` 无新增依赖（cuti 移除或保留有记录）。
- [ ] 无新增 `themes/assets/*` 文件。
- [ ] 每个公开组件在 `beamer-ysu.typ` 中至少演示一次。

## Out of Scope

- 演讲备注（speaker-notes 子任务），但 `slide` 包装器需预留在帧结束后追加内容的位置。
- 版本号与 README（release 子任务）。
