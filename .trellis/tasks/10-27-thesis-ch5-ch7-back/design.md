# Design：复刻第 5-7 章与致谢

沿用前两批 design 的全部约定。本批新增：

## 1. 整页大图（P65 九通道轨迹）

原稿 `\ysuTrajectorySetup` 让该页跳过竖图高度上限（高 = 文本高 − 46pt），隐藏外部图注，底部加平铺阅读卡与脚注。Typst：该页直接 `image(height: 1fr)` 放在 `slide(align: top)` 中，阅读卡用 `reading-card`。

## 2. 现场截图

主题 `screen-frame(title:)[image]`：ysuNight 圆角框、左上三个 ysuNightDot 圆点、标题白字；截图按框内宽度缩放。原稿 `\ysuScreenNext` 的“下一张图按截图处理”改为显式包裹，不需要全局状态。

## 3. 第 7 章版式

- 创新点卡（`\ysuInnovation*`）：三张白卡，navy 图标圆盘居上，标题 + 正文 + 章缩略图；`lib/layouts.typ` 局部实现。
- 展望链（`\ysuOutlook*`）：流程链，本文阶段 navy、展望阶段描边；展望 1 连接到链上对应位置。
- 成果页：主题 `paper-box` 列表。

## 4. 全量验收脚本化

- `export-speech.py --check <原稿 speech.md>`：规范化空白后逐页比对，输出不一致页号；退出码表示结果。
- 编译耗时：`Measure-Command { typst compile ... }`（PowerShell）或 `time`，冷编译前删除 `.tmp` 输出与 Typst 包缓存外的产物（Typst 无增量缓存文件，冷/热差异主要来自字体与包加载，第二次运行计为“热”）。
