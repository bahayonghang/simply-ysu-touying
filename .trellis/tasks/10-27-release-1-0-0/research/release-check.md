# 1.0.0 发布验证记录（2026-10-27）

| 检查 | 命令 / 方法 | 结果 |
| --- | --- | --- |
| 版本引用 | `grep -rn "simply-ysu-touying:" typst.toml template/main.typ README.md README.zh.md docs/typst-packages-pr-structure.md AGENTS.md` | 全部为 `1.0.0` |
| 残留旧版本 | `grep -rnE "0\.(1\|2)\.0"`（排除 `.trellis`、`.git`、`.tmp`、`examples/beamer-thesis`、二进制） | 无 |
| 本地 Universe 模拟 | `docs/typst-packages-pr-structure.md` 的 bash 脚本：`.tmp/pkg/preview/simply-ysu-touying/1.0.0/` → `typst init` → `typst compile` | 成功（9 页）；仅 `unknown font family: source sans 3` 警告，本机未装该字体，回退 Arial |
| 包内文件 | `find .tmp/pkg -type f` | README.md、LICENSE、LICENSE-MIT-0.txt、typst.toml、lib.typ、thumbnail.png、template/main.typ、template/main.pdf、themes/{ysu-beamer,components,tokens}.typ、themes/assets/ 5 个 PNG |
| `themes/assets/` | `git status --short themes/assets` | 无新增、无改动 |
| thumbnail 引用 | `grep -rn thumbnail themes lib.typ template/main.typ` | 无 |
| 示例回归 | `typst compile --root . examples/beamer-ysu.typ`，`--input ratio=4-3`，`--input notes=on` + `check-page-labels.py --expect-notes` | 均成功；19 帧 / 19 备注页 |
| Typst 0.14 基线 | 本机只有 0.15.1（scoop），无 `.local-typst/` | **未验证**；需要下载 0.14 才能验证，未下载 |

## 重生成产物

- `thumbnail.png`：从模拟包编译 `template/main.typ` 第 1 页，`--ppi 203.2`，1280 × 720，128 KB（原 1280 × 720，125 KB）。
- `template/main.pdf`：模拟包中 `typst compile` 的输出（9 页）。
- `examples/beamer-ysu.pdf`：重新编译，与已提交版本逐字节相同（主题自上次提交后未变），无需改动。
- `docs/screenshots/`：从 `examples/beamer-ysu.typ` 以 278.4 ppi（1754 px 宽，与旧图一致）导出 `beamer-ysu-cover.png`（第 1 页）、`beamer-ysu-opener.png`（第 3 页）、`beamer-ysu-content.png`（第 12 页）、`beamer-ysu-minimal-example.png`（第 20 页）；删除旧的 `beamer-ysu-two-column.png`。

## 待用户确认

- README 截图链接改为 `raw.githubusercontent.com/.../main/docs/screenshots/...`，在 dev 合入 main 并推送前不会显示。
- `themes/assets/ysu-watermark.png` 已不被任何代码引用（1.0 版式不画角标水印，结构页水印改用校徽），但仍随包发布；是否在发布前删除并同步 `ASSETS.md`，由用户决定。
- 向 `typst/packages` 提交 PR、打标签与 GitHub Release 不在本任务范围。
