# 最终集成复核（2026-10-27）

| 验收项 | 结果 | 证据 |
| --- | --- | --- |
| beamer-ysu 与 template 编译 | 通过 | `typst compile --root . examples/beamer-ysu.typ`（16:9、4:3、备注版）无错误；template 经本地包路径 `--package-path .tmp/pkg` 编译 9 页，仅缺 Source Sans 3 字体警告 |
| beamer-thesis 88 / 176 页 | 通过 | 普通版 88 页；`--input notes=on` 176 页，`check-page-labels.py --expect-notes` 输出 `1, notes:1, …, 88, notes:88` |
| 88 页目视对照 | 通过 | 三个复刻子任务的 `research/visual-diff.md`：无明显偏差，残留差异与偏离点逐页记录 |
| 讲稿 | 通过 | `cmp_speech.py` 88/88 页一致，头部“共 88 页，口播约 8438 字” |
| 编译耗时 | 已记录 Typst 侧 | 88 页普通版 1.97 / 2.09 s，备注版 2.01 / 2.05 s（Typst 0.15.1）。CLI 每次都是新进程，冷、热编译相同。原稿 XeLaTeX 耗时未提供，“显著短于”待用户实测确认 |
| 包体边界 | 通过 | 模拟包只含 README.md、LICENSE、LICENSE-MIT-0.txt、typst.toml、lib.typ、thumbnail.png、template/、themes/；无 thumbnail 引用；`themes/assets/` 无新增 |
| 版本号 | 通过 | 六个文件全为 `1.0.0`，无旧版本残留 |
| 本地 Universe 模拟 | 通过 | `typst init` + `typst compile` 成功 |
| 规范同步 | 通过 | `.trellis/spec/theme/*`（theme-core / speaker-notes 期间已更新）、`.trellis/spec/package/*` 与 `AGENTS.md`（release 提交 83dbd88） |

## 未验证 / 待用户确认

- Typst 0.14 基线：本机只有 0.15.1，未验证。
- XeLaTeX 编译耗时对比：需用户提供原稿实测时间。
- README 截图链接指向 `main` 分支，合并推送前不显示。
- `themes/assets/ysu-watermark.png` 已不被代码引用，仍随包发布，是否删除待定。
- 向 `typst/packages` 提交 PR、推送、打标签：按约定未执行。
