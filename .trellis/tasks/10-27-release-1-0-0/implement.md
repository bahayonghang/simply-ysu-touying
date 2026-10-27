# Implement：发布 1.0.0

## 前置

- 其余五个子任务完成。
- 读 `.trellis/spec/package/*`（三篇）。

## 步骤

1. [ ] 版本号替换（PRD R1 列表），跑 grep 校验。
2. [ ] README.md / README.zh.md 按 design §2 重写；`docs/screenshots/` 重新截图。
3. [ ] `docs/typst-packages-pr-structure.md` 更新目录、命令与模拟脚本。
4. [ ] 重生成 `examples/beamer-ysu.pdf`、`template/main.pdf`、`thumbnail.png`。
5. [ ] 更新 `.trellis/spec/theme/*`、`.trellis/spec/package/*`、`AGENTS.md`（可借助 `trellis-update-spec`）。
6. [ ] 本地 Universe 模拟。
7. [ ] 包边界与 thumbnail 引用检查。
8. [ ] trellis-check 全量检查；父任务最终集成复核。

## 验证命令

```bash
grep -rn "simply-ysu-touying:" typst.toml template/main.typ README.md README.zh.md docs/typst-packages-pr-structure.md AGENTS.md
grep -rnE "0\.(1|2)\.0" --exclude-dir=.trellis --exclude-dir=.git .
typst compile --root . examples/beamer-ysu.typ
grep -rn "thumbnail" themes lib.typ template
```

Universe 模拟命令见 `docs/typst-packages-pr-structure.md`（本子任务更新后版本）。

## 回滚点

本子任务单独提交；回滚只撤销版本号与文档。
