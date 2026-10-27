# 公式逐式核对

核对方法：逐式对照 `chapters/chapter3.tex`、`chapter4.tex` 中 `DefenseSource` 里的 LaTeX 源，检查符号、上下标、粗体、编号；渲染结果在 cmp 图中目视复核。书写约定：`\mathbf`/`\boldsymbol` 写作 `mbf()`，`\phi` 写作 `phi.alt`，`\epsilon` 写作 `epsilon.alt`，`\mathrm{xx}` 下标写作 `_"xx"`，`\widehat`/`\widetilde` 写作 `hat`/`tilde`。

| 页 | 编号 | 内容 | 结果 |
| --- | --- | --- | --- |
| P20 | (2-4) | $S_\theta:(\mathbf X^c_h,\mathbf r_h,\mathbf m_h,\mathbf a_h)\longmapsto\hat q_h$ | 一致 |
| P24 | (3-5) | 条件输入 $\mathbf u_j$、条件嵌入 MLP、可靠性分数 $\rho^{\mathrm{rel}}_j$，三行对齐 | 一致 |
| P24 | (3-6) | 分段注意力权重 $\alpha_j$（`cases`，`\notin`） | 一致 |
| P26 | (3-16) | 扩散去噪损失（粗体 $\boldsymbol\epsilon$，空集） | 一致 |
| P26 | (3-18) | 条件生成均值 $\boldsymbol\mu$、$\hat{\mathbf X}$ | 一致 |
| P28 | (3-23) | 校准分数 $\sigma$ 与分位数 $\hat q_{1-\alpha}^{(g_i)}$ | 一致 |
| P28 | (3-24) | 准入权重 `min{…}` | 一致 |
| P39 | (2-7) | $M_\phi:(\mathbf X_t^-,\widetilde{\mathbf r}_t,\widetilde{\mathbf m}_t,\widetilde{\mathbf a}_t)\longmapsto(\widehat{\mathbf X}_t^+,\{\widehat q^{\mathrm{cas}}_{t+\tau}\}_{\tau=1}^{H_p})$，0.7 倍字号 | 一致 |
| P41 | (4-6) | $\widehat q^{\mathrm{cas}}_{t+\tau}=S_\theta(\widehat{\mathbf B}_{t,\tau},\widetilde{\mathbf r}_{t,\tau},\widetilde{\mathbf m}_{t,\tau},\widetilde{\mathbf a}_{t,\tau}),\ \tau=1,\ldots,H_p$ | 一致（`\qquad` 写作 `wide`） |
| P41 | (4-7) | $M_\phi$ 联合映射，输出 $\widehat{\mathbf q}^{\mathrm{cas}}_{t+1:t+H_p}$ | 一致 |
| P44 | (4-8) | $\hat x_t=\gamma\cdot\frac{x_t-\mu}{\sigma+\epsilon}+\beta$（`\tfrac`） | 一致 |
| P44 | (4-9) | $\mathbf{cA}_l[k]$、$\mathbf{cD}_l[k]$ 两行，侧置求和下标 | 一致 |
| P44 | (4-11) | $\pi_{s,i}=g_{s,i}/\sum_{j\in\mathcal T_s}g_{s,j}$、$\mathbf H_s^*=\sum\pi_{s,i}\mathcal E_i(\mathbf Z_s^0)$ | 一致 |
| P46 | (4-19) | $\mathcal L_A=\lambda_a\mathcal L_{\mathrm{anchor}}(\widehat{\mathbf q}^{\mathrm{cas}})+\lambda_s\mathcal L_{\mathrm{smooth}}$ | 一致 |
| P46 | (4-21) | $\mathcal L_B=\mathcal L_x+\alpha_q(\mathcal L_q+\mathcal L_{\mathrm{dist}})+\lambda_{\mathrm{bal}}\mathcal L_{\mathrm{bal}}$ | 一致 |
| P46 | — | 面板符号 $\psi_{\mathrm{cal}}$、$\phi$、$F_\phi,S_\theta$、$\theta,\psi_{\mathrm{cal}}$ | 一致 |
| 讲稿 | — | $H_p$、Top-$k$、$\psi_{\mathrm{cal}}$ 经 `export-speech.py` 还原 | `cmp_speech.py … 51`：51/51 页一致 |
