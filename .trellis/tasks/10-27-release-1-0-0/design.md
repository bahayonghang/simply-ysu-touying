# Design：发布 1.0.0

## 1. 版本号语义

1.0.0 标志 API 稳定：此后 `ysu-theme` 参数、结构页函数与组件名按 semver 管理，破坏性改动需升主版本。发布说明列出全部破坏性变更（父 design §7）。

## 2. 文档结构（README 中英同构）

1. 简介 + 封面/内容页/扉页三张截图
2. 快速上手（`typst init`、最小 `main.typ`）
3. 结构页 API（封面、目录、扉页、内容页页眉逻辑、致谢）
4. 组件一览（表格：名称、用途、示例）
5. 演讲备注（`#note`、`--input notes=on`、FerroStage/pympress、导出口播）
6. 字体（推荐 Source Han Sans SC + Source Sans 3，回退链）
7. 从 0.2.x 迁移
8. 资产与许可（链接 ASSETS.md）

## 3. 缩略图

用 `template/main.typ` 封面页渲染：`typst compile --format png --ppi <n> --pages 1 template/main.typ thumbnail.png`（经本地包路径或相对导入），按 Universe 要求控制尺寸（长边 ≥ 1080px、体积尽量小，参照现有 `thumbnail.png` 尺寸）。

## 4. Universe 模拟

脚本化为一段 PowerShell/bash 命令（写在 `docs/typst-packages-pr-structure.md`）：复制发布文件到 `<tmp>/preview/simply-ysu-touying/1.0.0/`，执行 `typst init` 与 `typst compile`。临时目录用 `.tmp/`。
