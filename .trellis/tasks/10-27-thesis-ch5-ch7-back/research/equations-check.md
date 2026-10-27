# 公式逐式核对（本批）

核对方法同第二批：逐式对照 `chapters/chapter5.tex` 中 `DefenseSource` 里的 LaTeX 源，检查符号、上下标、粗体与编号；渲染结果在 cmp 图中目视复核。书写约定：`\boldsymbol{\Theta}` 写作 `Th`（`mbf(Theta)`），`\mathbf` 写作 `mbf()`，`\epsilon` 写作 `epsilon.alt`，`\varepsilon` 写作 `epsilon`，`\phi` 写作 `phi.alt`，`\mathrm{xx}` 下标写作 `_"xx"`。第 6、7 章与致谢没有公式。

| 页 | 编号 | 内容 | 结果 |
| --- | --- | --- | --- |
| P53 | (2-9) | $W_\psi:(o_t,\mathbf Y^d_{t+1:t+H}(\boldsymbol\Theta),\widetilde{\mathbf r}_t)\longmapsto(\widehat{\mathbf U}^{\mathrm{rsp}},\widehat{\mathbf K},\widehat{\mathbf Q}^{\mathrm{wm}})_{t+1:t+H}$，5.5 pt | 一致 |
| P55 | (5-8) | $\mathcal D^d_{t+1:t+H}(\boldsymbol\Theta)=\mathbf Y^d_{t+1:t+H}(\boldsymbol\Theta),\ \mathbf Y^d\in\mathbb R^{H\times n_y}$ | 一致 |
| P56 | (5-11) | 四目标向量最小化，五行 `aligned`；$\mathrm\Delta$ 正体，$\mathcal C_{\mathrm{geom}}\cap\mathcal C_{\mathrm{supp}}(o_t)$ | 一致 |
| P57 | (5-14) | 双侧带距 $d_{\mathcal B}(q)$ 与时域均值 $J_q(\boldsymbol\Theta)$ | 一致 |
| P62 | (5-24) | NURBS 有理基 $R^{(j)}_{i,3}(s)$ 与参考轨迹 $y^d_{t+\tau,j}(\boldsymbol\Theta)$ | 一致；条件 $\tau=1,\ldots,H,\ j=1,\ldots,6$ 移到第三行（同 preview） |
| P62 | (5-29) | $\epsilon_0=Q_{\alpha_\varepsilon}(\{\mathrm{Viol}(\boldsymbol\Theta_i^{(0)})\}_{i=1}^{N_{\mathrm{pop}}})$，$\epsilon_g=\epsilon_0(1-g/(N_{\mathrm{gen}}-1))$ | 一致；条件移到第三行（同 preview） |
| P63 | — | $q<1.5\%$、$W_\psi$、$M_\phi$ | 一致 |
| P64、P70、P71 | — | 表头 $E_\Delta$、$r_{\mathrm{bd}}$、$g_q$、$\sigma$、$E_{95}$、$t_{95}$ | 一致 |
