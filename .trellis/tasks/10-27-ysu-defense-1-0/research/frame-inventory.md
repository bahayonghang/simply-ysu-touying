# 88 帧清单（自动提取）

来源：`thesis/slides/deck/chapters/*.tex`（正文）与 `thesis/slides/deck-notes/chapters/*.tex`（口播）。只读提取；原稿变化后按同样规则重新抽取。

每帧给出：帧 id、LaTeX 版式、帧标题（页眉面包屑一级）、小节（面包屑二级）、结论句（页眉主标题）、公式/表格数量、是否有口播、使用的版式宏与图片路径。图片路径相对论文根的 `fig/` 或 `slides/assets/`（LaTeX `\graphicspath`）。

### P01 `cover`（front，cover）

- 标题：(plain)
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCoverFrame`

### P02 `toc`（front，toc）

- 标题：(plain)
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseTocFrame`

### P03 `c1-toc`（chapter1，toc）

- 标题：(plain)
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseTocFrame`, `\ysuChapterOpener`, `\ysuHL`, `\ysuOpenRow`, `\ysuOpenerBridge`, `\ysuOpenerIcons`, `\ysuOpenerOutline`

### P04 `c1-background-1`（chapter1，bullets）

- 标题：1.1 研究背景与意义
- 结论句：熟料烧成是水泥存量产线提质降耗的关键环节
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuAssetFigure`, `\ysuCascadeRows`, `\ysuChainRow`, `\ysuHL`, `\ysuSupportGap`, `\ysuSupportRowsSetup`
- 图：`slides/assets/cement-output-cn.pdf`

### P05 `c1-plant`（chapter1，bullets）

- 标题：1.1 研究背景与意义
- 结论句：烧成工序直接影响整线能耗与熟料质量
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuHL`, `\ysuPlantFoot`, `\ysuPlantHero`, `\ysuPlantHeroH`, `\ysuPlantKilnH`, `\ysuPlantOpen`, `\ysuPlantShot`, `\ysuPlantSideGoals`, `\ysuPlantStages`, `\ysuPlantThumbH`
- 图：`slides/assets/plant-panorama.jpg`
- 图：`slides/assets/raw-prep.jpg`
- 图：`slides/assets/kiln-plant.jpg`
- 图：`slides/assets/cement-mill.jpg`
- 图：`slides/assets/nsp-kiln-line.jpg`

### P06 `c1-background-2`（chapter1，bullets）

- 标题：1.1 研究背景与意义
- 结论句：烧成运行优化需由稳态寻优拓展至动态序列决策
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuAssetFigure`, `\ysuConclude`, `\ysuDiffCard`, `\ysuDiffCards`, `\ysuHL`
- 图：`slides/assets/clinker-line-side.png`

### P07 `c1-status-modeling`（chapter1，bullets）

- 标题：1.2 国内外研究现状
- 小节：1.2.1 水泥烧成系统运行指标建模研究现状
- 结论句：多源多速率融合逐步发展，慢变先验条件化仍待加强
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuEvoConclude`, `\ysuEvoRail`, `\ysuEvoStage`, `\ysuHL`, `\ysuKey`

### P08 `c1-status-forecast`（chapter1，bullets）

- 标题：1.2 国内外研究现状
- 小节：1.2.2 水泥烧成系统时间序列预测研究现状
- 结论句：预测方法多基于同频等间隔观测，难以协同预测过程与质量
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuEvoConclude`, `\ysuEvoRail`, `\ysuEvoStage`, `\ysuHL`, `\ysuKey`

### P09 `c1-status-optimization`（chapter1，bullets）

- 标题：1.2 国内外研究现状
- 小节：1.2.3 水泥烧成系统运行指标优化研究现状
- 结论句：优化方法多为稳态单点寻优，缺少跨时域动态过渡权衡
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuEvoConclude`, `\ysuEvoRail`, `\ysuEvoStage`, `\ysuHL`, `\ysuKey`

### P10 `c1-challenges`（chapter1，cards）

- 标题：1.3 研究问题与关键挑战
- 结论句：沿感知—预测—优化主线凝练三个关键问题
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCard`, `\ysuKey`, `\ysuProblemGoal`, `\ysuProblemMapSetup`, `\ysuProblemSetup`, `\ysuProblemSketch`

### P11 `c1-organization`（chapter1，bullets）

- 标题：1.4 研究内容与章节安排
- 结论句：第 3–5 章逐层递进，第 6 章完成工程化集成
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuHL`, `\ysuRoadmap`, `\ysuRoadmapBanner`, `\ysuRoadmapCol`, `\ysuRoadmapLink`, `\ysuRoadmapSide`

### P12 `c2-toc`（chapter2，toc）

- 标题：(plain)
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseTocFrame`, `\ysuChapterOpener`, `\ysuHL`, `\ysuOpenRow`, `\ysuOpenerBridge`, `\ysuOpenerIcons`, `\ysuOpenerOutline`

### P13 `c2-foundation-1`（chapter2，figure-bullets）

- 标题：2.2 烧成系统工艺流程与运行特性
- 小节：2.2.4 烧成系统运行特性与建模约束
- 结论句：测量时滞、多速率异步与多层嵌套边界构成运行优化约束
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseFigure`, `\ysuConclude`, `\ysuDiffCard`, `\ysuDiffCards`, `\ysuHL`, `\ysuKey`
- 图：`chapter2/水泥烧成系统工艺流程图.png`

### P14 `c2-variables`（chapter2，bullets）

- 标题：2.3 多源数据特征与过程变量选取
- 小节：2.3.2 过程变量分类与稳态边界
- 结论句：七类变量把多源数据统一为感知、预测与优化接口
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuChapterCard`, `\ysuHL`, `\ysuUseMatrix`, `\ysuUseRow`, `\ysuVarCells`, `\ysuVarGroup`, `\ysuVarLegend`, `\ysuVarNote`, `\ysuVarPage`, `\ysuVarTable`, `\ysuVarTag`

### P15 `c2-foundation-2-flow`（chapter2，figure-bullets）

- 标题：2.4 水泥烧成系统运行优化问题描述
- 结论句：运行优化解耦为质量感知、策略延续预测与动态优化
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuFlowStrip`, `\ysuFlowStripH`, `\ysuHL`, `\ysuRowPoint`
- 图：`chapter2/水泥烧成系统运行优化过程示意图.png`

### P16 `c2-foundation-2-detail`（chapter2，equations-figure）

- 标题：2.4 水泥烧成系统运行优化问题描述
- 结论句：三项映射分别对应质量、趋势与候选响应
- 公式 3 / 表格 0 / 口播 有
- 宏：`\ysuEqMap`, `\ysuEqMapBadge`, `\ysuEquationCenter`, `\ysuHL`, `\ysuIconDisc`

### P17 `c2-foundation-3-flow`（chapter2，figure-bullets）

- 标题：2.5 水泥烧成系统运行优化框架设计
- 结论句：三层框架把感知、预测与决策分层解耦
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuFlowDeck`, `\ysuHL`, `\ysuRailFigPlain`, `\ysuRailFour`
- 图：`slides/assets/ch2-framework-deck.png`

### P18 `c2-foundation-3-detail`（chapter2，equations-figure）

- 标题：2.5 水泥烧成系统运行优化框架设计
- 结论句：运行指标决策形式化为有约束多目标问题
- 公式 2 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuBandCol`, `\ysuEquationCenter`, `\ysuFrameworkBoard`
- 图：`chapter2/水泥烧成系统序列预测与运行优化总体框架.png`

### P19 `c3-toc`（chapter3，toc）

- 标题：(plain)
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseTocFrame`, `\ysuChapterOpener`, `\ysuHL`, `\ysuOpenRow`, `\ysuOpenerBridge`, `\ysuOpenerIcons`, `\ysuOpenerOutline`

### P20 `c3-position`（chapter3，equations-figure）

- 标题：3.1 引言
- 小节：本章在运行优化框架中的位置
- 结论句：本章为监测层提供决策起点的 f-CaO 估计
- 公式 1 / 表格 0 / 口播 有
- 宏：`\ysuHL`, `\ysuKey`, `\ysuPositionArrow`, `\ysuPositionBlock`, `\ysuPositionDeck`, `\ysuPositionEq`, `\ysuPositionFigure`, `\ysuPositionMark`, `\ysuPositionNext`, `\ysuPositionReset`, `\ysuRedFrameCenter`

### P21 `c3-intro`（chapter3，bullets）

- 标题：3.1 引言
- 小节：研究内容 1：基于多速率数据融合的熟料质量指标建模
- 结论句：f-CaO 在线估计受三重数据瓶颈制约
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuComponents`, `\ysuHL`, `\ysuPairHead`, `\ysuPairRow`, `\ysuPairRowTwo`, `\ysuPairRows`, `\ysuPairTagged`, `\ysuRedFrame`

### P22 `c3-problem`（chapter3，figure-bullets）

- 标题：3.2 多源多速率软测量问题描述
- 结论句：相近过程观测难以唯一确定熟料 f-CaO
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuContrastZone`, `\ysuKey`, `\ysuMetricDeck`, `\ysuMetricFig`
- 图：`chapter3/软测量实验结果/SOI状态重叠示例.png`

### P23 `c3-method-1-flow`（chapter3，figure-bullets）

- 标题：3.3 扩散模型增强的多速率融合软测量
- 小节：3.3.1 可靠性门控多速率软测量网络
- 结论句：OAM-Net 按化验时效门控低频条件，补充易烧性信息
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuComponents`, `\ysuFlowDeck`, `\ysuHL`, `\ysuRailFig`, `\ysuRailThree`
- 图：`chapter3/architecture/OAM-Net可靠性门控交叉注意力架构图.png`

### P24 `c3-method-1-detail`（chapter3，equations-figure）

- 标题：3.3 扩散模型增强的多速率融合软测量
- 小节：3.3.1 可靠性门控多速率软测量网络
- 结论句：可靠性权重随更新时滞衰减并调制注意力
- 公式 2 / 表格 0 / 口播 有
- 宏：`\ysuEqFigH`, `\ysuEqFigure`, `\ysuEquationRow`, `\ysuHL`
- 图：`slides/assets/c3-reliability-attention.png`

### P25 `c3-method-2-flow`（chapter3，figure-bullets）

- 标题：3.3 扩散模型增强的多速率融合软测量
- 小节：3.3.2 工艺可行性引导条件扩散模型
- 结论句：PFG-CDM 在工艺可行域内定向生成尾部工况候选
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuComponents`, `\ysuFlowDeck`, `\ysuHL`, `\ysuRailFig`, `\ysuRailStage`, `\ysuRailStages`
- 图：`chapter3/architecture/PFG-CDM因子化条件扩散架构图.png`

### P26 `c3-method-2-detail`（chapter3，equations-figure）

- 标题：3.3 扩散模型增强的多速率融合软测量
- 小节：3.3.2 工艺可行性引导条件扩散模型
- 结论句：工况与质量分级引导，能量梯度校正采样均值
- 公式 2 / 表格 0 / 口播 有
- 宏：`\ysuEqGuide`, `\ysuEquationCenter`, `\ysuGuideChips`, `\ysuHL`

### P27 `c3-method-3-flow`（chapter3，figure-bullets）

- 标题：3.3 扩散模型增强的多速率融合软测量
- 小节：3.3.3 多准则置信校准课程训练方法
- 结论句：多准则校准把候选转为带置信权重的区间监督
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuFlowStrip`, `\ysuFlowStripH`, `\ysuHL`, `\ysuRowPoint`
- 图：`chapter3/architecture/MC3校准准入与学生训练框架图.png`

### P28 `c3-method-3-detail`（chapter3，equations-figure）

- 标题：3.3 扩散模型增强的多速率融合软测量
- 小节：3.3.3 多准则置信校准课程训练方法
- 结论句：教师与目标区间取交集，置信权重加权合成监督
- 公式 2 / 表格 0 / 口播 有
- 宏：`\ysuEqGuide`, `\ysuEquationCenter`, `\ysuGuideChips`, `\ysuHL`

### P29 `c3-experiment-1`（chapter3，bullets）

- 标题：3.4 实验与结果分析
- 小节：3.4.1 实验设置与评价指标
- 结论句：按时间先后切分，边界隔离与回看窗口等长
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuHL`, `\ysuSetupPair`, `\ysuSetupSplit`, `\ysuSetupTriple`

### P30 `c3-experiment-2`（chapter3，table）

- 标题：3.4 实验与结果分析
- 小节：3.4.2 软测量模型对比实验
- 结论句：OAM-Net 的总体与高值欠烧尾部估计误差在 12 种模型中最低
- 公式 0 / 表格 1 / 口播 有
- 宏：`\DefenseCaption`, `\ysuHL`, `\ysuKey`, `\ysuReadLabel`, `\ysuTableBase`, `\ysuTableFit`, `\ysuTableMark`, `\ysuTableRead`, `\ysuTableReadKey`, `\ysuTableReadLabels`, `\ysuTableReadMain`, `\ysuTableReadNote`, `\ysuTableReadPrepare`

### P31 `c3-experiment-2-boxplot`（chapter3，figure-bullets）

- 标题：3.4 实验与结果分析
- 小节：3.4.2 软测量模型对比实验
- 结论句：OAM-Net 的绝对误差中位数与四分位距在 12 种模型中最低
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseFigure`, `\ysuHL`, `\ysuKey`, `\ysuPointCards`, `\ysuReadLabel`
- 图：`chapter3/软测量实验结果/模型误差箱线图.png`

### P32 `c3-experiment-2-curves`（chapter3，bullets）

- 标题：3.4 实验与结果分析
- 小节：3.4.2 软测量模型对比实验
- 结论句：可靠性门控贴合欠烧升降沿，固定查询注意力削平尖峰
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuHL`, `\ysuPredEnd`, `\ysuPredLabel`, `\ysuPredLabelMark`, `\ysuPredPairSetup`, `\ysuReadLabel`, `\ysuRowPoint`

### P33 `c3-experiment-3`（chapter3，figure-grid）

- 标题：3.4 实验与结果分析
- 小节：3.4.3 统计保真度与尾部增强实验
- 结论句：选定集的边际与联合分布贴近真实数据
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuFidBegin`, `\ysuFidCap`, `\ysuFidGroupBegin`, `\ysuFidGroupEnd`, `\ysuFidHist`, `\ysuFidHistEnd`, `\ysuFidHistSep`, `\ysuFidNotes`, `\ysuFidTsne`, `\ysuFidTsneBegin`, `\ysuFidTsneEnd`, `\ysuFidTsneGroupBegin`, `\ysuFidTsneGroupEnd`, `\ysuFidTsneSep`, `\ysuHL`, `\ysuKey`

### P34 `c3-experiment-4`（chapter3，table）

- 标题：3.4 实验与结果分析
- 小节：3.4.3 统计保真度与尾部增强实验
- 结论句：完整 MC3 协议同时改善总体估计与高值尾部
- 公式 0 / 表格 1 / 口播 有
- 宏：`\DefenseCaption`, `\ysuHL`, `\ysuKey`, `\ysuReadLabel`, `\ysuTableBase`, `\ysuTableFit`, `\ysuTableMark`, `\ysuTableRead`, `\ysuTableReadKey`, `\ysuTableReadLabels`, `\ysuTableReadMain`, `\ysuTableReadNote`, `\ysuTableReadPrepare`

### P35 `c3-experiment-4-trajectory`（chapter3，figure-bullets）

- 标题：3.4 实验与结果分析
- 小节：3.4.3 统计保真度与尾部增强实验
- 结论句：完整增强协议贴合平稳工况并跟随欠烧峰值
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuAside`, `\ysuAsideChart`, `\ysuAsideFig`, `\ysuAsideTag`, `\ysuChartReads`, `\ysuHL`
- 图：`chapter3/软测量实验结果/OAM-Net-PFG-CDM-MC3最终预测结果.png`
- 图：`slides/assets/ch3-tail-rmse.pdf`

### P36 `c3-experiment-5`（chapter3，table）

- 标题：3.4 实验与结果分析
- 小节：3.4.4 软测量组件消融实验
- 结论句：输入信息与表征深度不足引起的性能退化最为突出
- 公式 0 / 表格 1 / 口播 有
- 宏：`\DefenseCaption`, `\ysuHL`, `\ysuKey`, `\ysuReadLabel`, `\ysuRowPoint`, `\ysuTableBase`, `\ysuTableFit`, `\ysuTableMark`

### P37 `c3-summary`（chapter3，paper-summary）

- 标题：3.5 本章小结
- 结论句：完整增强协议缓解欠烧峰值低估与响应迟滞
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuAssetFigure`, `\ysuComponents`, `\ysuHL`, `\ysuKey`, `\ysuKpi`, `\ysuKpiCompact`, `\ysuKpiRow`, `\ysuMechPair`, `\ysuRedFrame`, `\ysuSummaryChartH`
- 图：`slides/assets/ch3-summary-kpi.pdf`

### P38 `c4-toc`（chapter4，toc）

- 标题：(plain)
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseTocFrame`, `\ysuChapterOpener`, `\ysuHL`, `\ysuOpenRow`, `\ysuOpenerBridge`, `\ysuOpenerIcons`, `\ysuOpenerOutline`

### P39 `c4-position`（chapter4，equations-figure）

- 标题：4.1 引言
- 小节：本章在运行优化框架中的位置
- 结论句：联合预测融合历史过程与低频条件，预测过程与质量变化趋势
- 公式 1 / 表格 0 / 口播 有
- 宏：`\ysuHL`, `\ysuPositionArrow`, `\ysuPositionBlock`, `\ysuPositionDeck`, `\ysuPositionEq`, `\ysuPositionFigure`, `\ysuPositionMark`, `\ysuPositionNext`, `\ysuPositionReset`, `\ysuRedFrame`

### P40 `c4-intro`（chapter4，bullets）

- 标题：4.1 引言
- 小节：研究内容 2：水泥烧成系统过程与质量联合预测模型
- 结论句：运行优化需要过程与质量的联合多步预测
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuComponents`, `\ysuHL`, `\ysuPairSpaced`, `\ysuRedFrame`

### P41 `c4-problem`（chapter4，equations-figure）

- 标题：4.2 多速率过程与质量联合预测问题
- 小节：4.2.2 稀疏监督的过程与质量联合序列预测
- 结论句：稀疏监督下，质量前瞻受异构训练与级联累积双重制约
- 公式 2 / 表格 0 / 口播 有
- 宏：`\ysuEquationCenter`, `\ysuHL`, `\ysuPoint`, `\ysuSchematicPair`

### P42 `c4-method-1-flow`（chapter4，figure-bullets）

- 标题：4.3 多速率过程与质量联合预测模型
- 小节：4.3.1 多速率过程与质量序列预测框架设计
- 结论句：融合冻结软测量的多速率过程与质量联合预测框架
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuComponents`, `\ysuHL`, `\ysuOverviewCard`, `\ysuOverviewDeck`, `\ysuOverviewThree`, `\ysuRailFig`
- 图：`chapter4/联合预测监测总体框架.png`

### P43 `c4-method-2-flow`（chapter4，figure-bullets）

- 标题：4.3 多速率过程与质量联合预测模型
- 小节：4.3.2 质检条件多输入多任务时序预测模型
- 结论句：质检条件小波稀疏专家网络刻画非平稳多尺度过程
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuComponents`, `\ysuHL`, `\ysuOverviewCard`, `\ysuOverviewDeck`, `\ysuOverviewThree`, `\ysuRailFig`
- 图：`chapter4/质检条件多输入多任务时序预测模型.png`

### P44 `c4-method-2-detail`（chapter4，equations-figure）

- 标题：4.3 多速率过程与质量联合预测模型
- 小节：4.3.2 质检条件多输入多任务时序预测模型
- 结论句：时序预测主干的归一化、多尺度分解与稀疏路由
- 公式 3 / 表格 0 / 口播 有
- 宏：`\DefenseFigure`, `\ysuHL`, `\ysuMechanismCard`, `\ysuMechanismDeck`, `\ysuRailFig`
- 图：`chapter4/序列路由稀疏Mamba专家模块.png`

### P45 `c4-method-3-flow`（chapter4，figure-bullets）

- 标题：4.3 多速率过程与质量联合预测模型
- 小节：4.3.3 软测量嵌入与两阶段交替协同训练
- 结论句：两阶段交替协同训练机制与误差累积抑制
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuFlowStrip`, `\ysuFlowStripH`, `\ysuHL`, `\ysuRowPoint`
- 图：`chapter4/级联联合训练流程.png`

### P46 `c4-method-3-detail`（chapter4，equations-figure）

- 标题：4.3 多速率过程与质量联合预测模型
- 小节：4.3.3 软测量嵌入与两阶段交替协同训练
- 结论句：两阶段交替协同训练的参数更新与梯度传递
- 公式 2 / 表格 0 / 口播 有
- 宏：`\ysuDistillPath`, `\ysuEquationRow`, `\ysuGradientStage`, `\ysuGradientStages`, `\ysuQualityPath`

### P47 `c4-experiment-2`（chapter4，table）

- 标题：4.4 过程与质量联合预测实验与分析
- 小节：4.4.2 多速率过程变量预测实验
- 结论句：QC-MTWaveSME 的四项过程预测误差在九种模型中均为最低
- 公式 0 / 表格 1 / 口播 有
- 宏：`\DefenseCaption`, `\ysuForecastLead`, `\ysuForecastMain`, `\ysuForecastMetric`, `\ysuForecastPrepare`, `\ysuForecastSide`, `\ysuForecastSummary`, `\ysuTableFit`, `\ysuTableMark`

### P48 `c4-experiment-3`（chapter4，figure-grid）

- 标题：4.4 过程与质量联合预测实验与分析
- 小节：4.4.2 多速率过程变量预测实验
- 结论句：典型热工、操纵与能耗通道的多步预测跟随过程动态
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\DefenseFigure`, `\ysuGridBox`, `\ysuSixGridCell`, `\ysuSixGridFoot`, `\ysuSixGridGap`, `\ysuSixGridRow`
- 图：`chapter4/过程预测窗口/分解炉出口温度.png`
- 图：`chapter4/过程预测窗口/窑尾烟室温度.png`
- 图：`chapter4/过程预测窗口/分解炉煤反馈.png`
- 图：`chapter4/过程预测窗口/F1风机电流.png`
- 图：`chapter4/过程预测窗口/实物煤耗.png`
- 图：`chapter4/过程预测窗口/电耗.png`

### P49 `c4-experiment-4`（chapter4，figure-bullets）

- 标题：4.4 过程与质量联合预测实验与分析
- 小节：4.4.3 过程与质量联合预测实验
- 结论句：协同训练使 f-CaO 滚动预测误差低于无协同级联
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuEvidenceBand`, `\ysuEvidenceComparison`, `\ysuEvidenceFigH`, `\ysuEvidenceHeading`, `\ysuEvidenceLegend`, `\ysuEvidenceMetricHeading`, `\ysuEvidenceReduction`, `\ysuEvidenceSource`, `\ysuHL`, `\ysuKey`
- 图：`chapter4/过程预测窗口/联合训练f-CaO预测测试集时间线.png`

### P50 `c4-experiment-5`（chapter4，table）

- 标题：4.4 过程与质量联合预测实验与分析
- 小节：4.4.4 模型有效性分析与消融实验
- 结论句：级联质量精度的提升主要来自过程预测器的协同更新
- 公式 0 / 表格 1 / 口播 有
- 宏：`\DefenseCaption`, `\ysuAblationCaption`, `\ysuAblationFoot`, `\ysuAblationGap`, `\ysuAblationHeading`, `\ysuAblationMain`, `\ysuAblationPrepare`, `\ysuAblationReading`, `\ysuAblationSide`, `\ysuHL`, `\ysuTableFit`, `\ysuTableMark`
- 图：`slides/assets/ch4-ablation-joint.pdf`

### P51 `c4-summary`（chapter4，paper-summary）

- 标题：4.5 本章小结
- 结论句：协同训练提升质量预测精度，过程预测精度与预训练持平
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuAssetFigure`, `\ysuChapterChartHeading`, `\ysuChapterConclusion`, `\ysuChapterKpi`, `\ysuChapterKpiRow`, `\ysuChapterReading`, `\ysuChapterSource`, `\ysuChapterSummaryGap`, `\ysuChapterSummaryPrepare`
- 图：`slides/assets/ch4-summary-kpi.pdf`

### P52 `c5-toc`（chapter5，toc）

- 标题：(plain)
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseTocFrame`, `\ysuChapterOpener`, `\ysuHL`, `\ysuOpenRow`, `\ysuOpenerBridge`, `\ysuOpenerIcons`, `\ysuOpenerOutline`

### P53 `c5-position`（chapter5，equations-figure）

- 标题：5.1 引言
- 小节：本章在运行优化框架中的位置
- 结论句：动态优化在优化层评价并求解候选设定序列
- 公式 1 / 表格 0 / 口播 有
- 宏：`\ysuHL`, `\ysuPositionArrow`, `\ysuPositionBlock`, `\ysuPositionDeck`, `\ysuPositionEq`, `\ysuPositionFigure`, `\ysuPositionMark`, `\ysuPositionNext`, `\ysuPositionReset`, `\ysuRedFrame`

### P54 `c5-intro`（chapter5，bullets）

- 标题：5.1 引言
- 小节：研究内容 3：水泥烧成系统运行指标多目标动态优化算法
- 结论句：寻优须计入动态过渡与累积调节代价
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuComponents`, `\ysuHL`, `\ysuPairFilled`, `\ysuRedFrame`

### P55 `c5-problem-flow`（chapter5，equations-figure）

- 标题：5.2 运行指标动态优化问题描述
- 小节：5.2.2 多目标动态序列优化模型构建
- 结论句：以被控变量候选设定轨迹为优化对象
- 公式 1 / 表格 0 / 口播 有
- 宏：`\ysuDecisionDefinition`, `\ysuDecisionEvaluation`, `\ysuEquationCenter`

### P56 `c5-problem-detail`（chapter5，equations-figure）

- 标题：5.2 运行指标动态优化问题描述
- 小节：5.2.2 多目标动态序列优化模型构建
- 结论句：四目标按向量最小化，并满足工程可行性约束
- 公式 1 / 表格 0 / 口播 有
- 宏：`\ysuConstraintSet`, `\ysuEquationCenter`, `\ysuHL`, `\ysuObjectiveProblem`, `\ysuObjectiveSet`

### P57 `c5-method-1-flow`（chapter5，equations-figure）

- 标题：5.3 条件动态响应驱动的多目标动态优化方法
- 小节：5.3.1 多目标序列决策框架与约束体系
- 结论句：条件动态响应评价候选序列，后退时域执行并延续保障
- 公式 1 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuComponents`, `\ysuEquationRow`, `\ysuFrameCard`, `\ysuFrameworkCards`, `\ysuHL`, `\ysuRailFig`
- 图：`chapter5/基于条件响应的水泥烧成系统多目标序列决策框架.png`

### P58 `c5-method-1-detail`（chapter5，figure-bullets）

- 标题：5.3 条件动态响应驱动的多目标动态优化方法
- 小节：5.3.1 多目标序列决策框架与约束体系
- 结论句：候选决策序列的约束筛选与可接受集判定
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuAcceptanceCard`, `\ysuAcceptancePair`, `\ysuFlowStrip`, `\ysuFlowStripH`
- 图：`chapter5/工况覆盖与预测MV可行性筛选流水线.png`

### P59 `c5-method-2-flow`（chapter5，figure-bullets）

- 标题：5.3 条件动态响应驱动的多目标动态优化方法
- 小节：5.3.2 候选决策序列条件动态响应模型
- 结论句：双流门控对齐历史与候选调控，协同预测操纵响应与指标趋势
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuComponents`, `\ysuExplainCard`, `\ysuHL`, `\ysuRailFig`, `\ysuStructureCards`, `\ysuStructureLead`
- 图：`chapter5/CSC-MTWaveSME候选序列条件动态响应模型结构.png`

### P60 `c5-method-2-detail`（chapter5，figure-bullets）

- 标题：5.3 条件动态响应驱动的多目标动态优化方法
- 小节：5.3.2 候选决策序列条件动态响应模型
- 结论句：条件动态响应模型的深层表征与质量梯度隔离
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuHL`, `\ysuRailFig`, `\ysuResponseMechanismCard`, `\ysuResponseMechanismDeck`
- 图：`chapter5/块注意力残差机制.png`

### P61 `c5-method-3-flow`（chapter5，figure-bullets）

- 标题：5.3 条件动态响应驱动的多目标动态优化方法
- 小节：5.3.3 偏好引导的序列多目标优化算法
- 结论句：偏好引导的多目标序列优化流程
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuHL`, `\ysuPreferenceSearchDeck`, `\ysuSearchCard`, `\ysuSearchEdges`, `\ysuSearchFallback`, `\ysuSearchOutput`, `\ysuSearchStage`

### P62 `c5-method-3-detail`（chapter5，equations-figure）

- 标题：5.3 条件动态响应驱动的多目标动态优化方法
- 小节：5.3.3 偏好引导的序列多目标优化算法
- 结论句：参考轨迹参数化与偏好引导约束搜索
- 公式 2 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuBasisRead`, `\ysuBasisSheet`, `\ysuEquationCenter`, `\ysuFlowPair`, `\ysuFlowPairH`, `\ysuHL`
- 图：`chapter5/三段三次NURBS基函数.png`
- 图：`chapter5/单参数扰动的局部影响.png`

### P63 `c5-experiment-1`（chapter5，bullets）

- 标题：5.4 动态优化实验与结果分析
- 小节：5.4.1 决策实验设置与评价指标
- 结论句：多目标动态优化的离线评价设置与指标
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuEvalBranch`, `\ysuEvalBranches`, `\ysuEvalFoot`, `\ysuEvalHeading`, `\ysuEvalMetric`, `\ysuEvalProtocol`, `\ysuEvalTime`

### P64 `c5-experiment-2`（chapter5，table）

- 标题：5.4 动态优化实验与结果分析
- 小节：5.4.2 条件响应模型准确度评价
- 结论句：CSC-MTWaveSME 的预测精度、动态跟踪与技能分均居首
- 公式 0 / 表格 1 / 口播 有
- 宏：`\DefenseCaption`, `\ysuHL`, `\ysuKey`, `\ysuResponseCard`, `\ysuResponseCards`, `\ysuResponseFoot`, `\ysuResponsePrepare`, `\ysuTableFit`, `\ysuTableMark`

### P65 `c5-experiment-2-trajectory`（chapter5，figure-bullets）

- 标题：5.4 动态优化实验与结果分析
- 小节：5.4.2 条件响应模型准确度评价
- 结论句：条件动态响应模型的多通道预测轨迹跟随实测变化趋势
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseFigure`, `\ysuHL`, `\ysuTrajectoryFig`, `\ysuTrajectoryFoot`, `\ysuTrajectoryReading`, `\ysuTrajectorySetup`
- 图：`chapter5/world_model_backbone/channel_detail/通道轨迹对比_九通道.png`

### P66 `c5-decision-single-cv`（chapter5，figure-grid）

- 标题：5.4 动态优化实验与结果分析
- 小节：5.4.3 单窗决策与滚动优化评价
- 结论句：NURBS 参数化生成连续的 CV 候选参考轨迹
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuCurveGrid`, `\ysuCurvePanel`, `\ysuCurveReading`, `\ysuCurveScope`, `\ysuCurveSetup`, `\ysuCurveSix`, `\ysuDecisionCaption`, `\ysuDecisionEnd`, `\ysuDecisionImageH`, `\ysuDecisionPrepare`
- 图：`chapter5/pg_final_results/single_frame/cv/01_分解炉出口温度.png`
- 图：`chapter5/pg_final_results/single_frame/cv/02_二次风温平均值.png`
- 图：`chapter5/pg_final_results/single_frame/cv/03_三次风温度.png`
- 图：`chapter5/pg_final_results/single_frame/cv/04_窑头罩负压反馈.png`
- 图：`chapter5/pg_final_results/single_frame/cv/05_窑尾烟室温度.png`
- 图：`chapter5/pg_final_results/single_frame/cv/06_篦冷机一室压力.png`

### P67 `c5-decision-single-outcomes`（chapter5，figure-grid）

- 标题：5.4 动态优化实验与结果分析
- 小节：5.4.3 单窗决策与滚动优化评价
- 结论句：单窗候选方案降低预测能耗并缩小质量带距
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuCurveEnergy`, `\ysuCurveGrid`, `\ysuCurveOutcomePanel`, `\ysuCurveQualityCard`, `\ysuCurveQualityCards`, `\ysuCurveScope`, `\ysuCurveSetup`, `\ysuDecisionCaption`, `\ysuDecisionEnd`, `\ysuDecisionImageH`, `\ysuDecisionPrepare`
- 图：`chapter5/pg_final_results/single_frame/kpi/01_实物煤耗.png`
- 图：`chapter5/pg_final_results/single_frame/kpi/02_电耗.png`

### P68 `c5-experiment-3`（chapter5，figure-grid）

- 标题：5.4 动态优化实验与结果分析
- 小节：5.4.3 单窗决策与滚动优化评价
- 结论句：离线滚动评价显示能耗降低与质量带距缩小
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuCurveCardMetric`, `\ysuCurveGrid`, `\ysuCurveMetricCard`, `\ysuCurveMetricCards`, `\ysuCurvePanel`, `\ysuCurveScope`, `\ysuCurveSetup`, `\ysuDecisionCaption`, `\ysuDecisionEnd`, `\ysuDecisionImageH`, `\ysuDecisionPrepare`
- 图：`chapter5/pg_final_results/rolling/kpi/01_实物煤耗.png`
- 图：`chapter5/pg_final_results/rolling/kpi/02_电耗.png`
- 图：`chapter5/pg_final_results/rolling/kpi/03_f_cao_minute_pred.png`

### P69 `c5-decision-rolling-smoothness`（chapter5，figure-grid）

- 标题：5.4 动态优化实验与结果分析
- 小节：5.4.3 单窗决策与滚动优化评价
- 结论句：滚动候选序列保持平稳并满足模型侧约束
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuCurveGrid`, `\ysuCurvePanel`, `\ysuCurveScope`, `\ysuCurveScore`, `\ysuCurveScoreKey`, `\ysuCurveSetup`, `\ysuCurveStability`, `\ysuDecisionCaption`, `\ysuDecisionEnd`, `\ysuDecisionImageH`, `\ysuDecisionPrepare`
- 图：`chapter5/pg_final_results/rolling/mv/01_最新生料转子秤流量反馈.png`
- 图：`chapter5/pg_final_results/rolling/mv/02_分解炉煤反馈.png`
- 图：`chapter5/pg_final_results/rolling/mv/04_高温风机转速反馈.png`

### P70 `c5-experiment-4`（chapter5，table）

- 标题：5.4 动态优化实验与结果分析
- 小节：5.4.4 决策策略与求解算法比较
- 结论句：所提序列决策方法兼顾节能与质量稳定性
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuCompareCaption`, `\ysuCompareGroups`, `\ysuCompareHeader`, `\ysuCompareReadings`, `\ysuCompareRow`, `\ysuCompareTable`, `\ysuDecisionEnd`, `\ysuDecisionPrepare`

### P71 `c5-experiment-5`（chapter5，bullets）

- 标题：5.4 动态优化实验与结果分析
- 小节：5.4.4 决策策略与求解算法比较
- 结论句：所提方法综合得分居首，在 NURBS 方法中收敛最快
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuDecisionEnd`, `\ysuDecisionPrepare`, `\ysuHL`, `\ysuScoreFoot`, `\ysuScoreHeader`, `\ysuScoreRow`, `\ysuScoreScope`, `\ysuScoreSource`, `\ysuScoreTable`

### P72 `c5-summary`（chapter5，bullets）

- 标题：5.5 本章小结
- 结论句：多目标动态优化在质量非劣约束下降低离线评价能耗
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuContributionEvidence`, `\ysuContributionItem`, `\ysuKey`, `\ysuSummaryResult`

### P73 `c6-toc`（chapter6，toc）

- 标题：(plain)
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseTocFrame`, `\ysuChapterOpener`, `\ysuHL`, `\ysuOpenRow`, `\ysuOpenerBridge`, `\ysuOpenerIcons`, `\ysuOpenerOutline`

### P74 `c6-position`（chapter6，figure-bullets）

- 标题：6.1 引言
- 小节：本章在运行优化框架中的位置
- 结论句：在数据入口与控制层整合三类模型
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuHL`, `\ysuPositionArrowLong`, `\ysuPositionBlock`, `\ysuPositionDeck`, `\ysuPositionFigure`, `\ysuPositionMark`, `\ysuPositionNext`, `\ysuPositionReset`, `\ysuRedFrame`

### P75 `c6-architecture`（chapter6，figure-bullets）

- 标题：6.2 系统架构与功能设计
- 小节：6.2.1 体系结构与接口规范
- 结论句：体系结构沿数据流与控制反馈纵向解耦
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuComponents`, `\ysuFlowDeck`, `\ysuHL`, `\ysuRailFigPlain`, `\ysuRailThree`
- 图：`chapter6/architecture/水泥烧成系统运行监测与优化平台总体架构.png`

### P76 `c6-intro`（chapter6，figure-bullets）

- 标题：6.3 算法任务运行与调度机制
- 小节：6.3.2 算法任务组织与模型版本管理
- 结论句：训练、预测与决策任务协同及版本管理
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuHL`, `\ysuTaskCoordination`, `\ysuTaskFigH`, `\ysuTaskReading`
- 图：`chapter6/architecture/训练预测决策服务编排.png`

### P77 `c6-home`（chapter6，figure-bullets）

- 标题：6.4 系统应用案例分析
- 结论句：运行监测与优化平台部署于山西某水泥熟料生产线
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuBandCol`, `\ysuBandFig`, `\ysuBandFoot`, `\ysuBandFootPrepare`, `\ysuBandNotes`, `\ysuBandPrepare`, `\ysuFigMain`, `\ysuFigSide`, `\ysuHL`, `\ysuNoteIcon`, `\ysuScreen`
- 图：`chapter6/现场运行评价/水泥生产智能决策系统首页.png`

### P78 `c6-pred-energy`（chapter6，figure-bullets）

- 标题：6.4 系统应用案例分析
- 小节：6.4.1 关键指标在线预测精度评价
- 结论句：电耗与煤耗在线预测跟踪实测趋势并抑制高频噪声
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuBandCol`, `\ysuBandNotes`, `\ysuBandPrepare`, `\ysuBandSource`, `\ysuBandSub`, `\ysuFigMain`, `\ysuFigSide`, `\ysuHL`, `\ysuKey`, `\ysuNoteIcon`, `\ysuScreenStack`
- 图：`chapter6/现场运行评价/预测评价/电耗预测放大.png`
- 图：`chapter6/现场运行评价/预测评价/煤耗预测放大.png`

### P79 `c6-pred-quality`（chapter6，figure-bullets）

- 标题：6.4 系统应用案例分析
- 小节：6.4.1 关键指标在线预测精度评价
- 结论句：在线软测量重构相邻化验点之间的质量波动轨迹
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuBandCol`, `\ysuBandNotes`, `\ysuBandPrepare`, `\ysuBandSource`, `\ysuBandSub`, `\ysuFigMain`, `\ysuFigSide`, `\ysuHL`, `\ysuKey`, `\ysuNoteIcon`, `\ysuScreenStack`
- 图：`chapter6/现场运行评价/预测评价/游离钙预测放大.png`
- 图：`chapter6/现场运行评价/预测评价/游离钙一周趋势.png`

### P80 `c6-pred-overview`（chapter6，figure-bullets）

- 标题：6.4 系统应用案例分析
- 小节：6.4.1 关键指标在线预测精度评价
- 结论句：正常生产窗口内三项指标精度与趋势跟踪保持稳定
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuBandCol`, `\ysuBandFig`, `\ysuBandFoot`, `\ysuBandFootH`, `\ysuBandFootPrepare`, `\ysuBandNotes`, `\ysuBandPrepare`, `\ysuBandSource`, `\ysuBandSourceH`, `\ysuFigMain`, `\ysuFigSide`, `\ysuHL`, `\ysuKey`, `\ysuNoteIcon`, `\ysuScreen`
- 图：`chapter6/现场运行评价/预测评价/水泥烧成关键指标预测精度总览页面.png`

### P81 `c6-decision`（chapter6，figure-bullets）

- 标题：6.4 系统应用案例分析
- 小节：6.4.2 设定值与现场反馈跟踪评价
- 结论句：候选序列经五层安全门控后由既有专家系统下发
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCaption`, `\ysuBandCol`, `\ysuBandFig`, `\ysuBandFootCenter`, `\ysuBandFootH`, `\ysuBandFootPrepare`, `\ysuBandNotes`, `\ysuBandPrepare`, `\ysuBandSource`, `\ysuBandSourceH`, `\ysuFigMain`, `\ysuFigSide`, `\ysuHL`, `\ysuNoteIcon`, `\ysuScreen`
- 图：`chapter6/现场运行评价/决策评价/正常生产时点候选决策序列与关键指标趋势页面.png`

### P82 `c6-decision-effect`（chapter6，figure-bullets）

- 标题：6.4 系统应用案例分析
- 小节：6.4.2 设定值与现场反馈跟踪评价
- 结论句：工况相近的自然月对比中，能耗与 f-CaO 波动均出现观察降幅
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseFigure`, `\ysuBandPanel`, `\ysuBandSource`, `\ysuKpi`, `\ysuKpiRow`, `\ysuKpiScreenGap`, `\ysuNoteIcon`, `\ysuPanelDrop`, `\ysuPanelFigDrop`, `\ysuPanelFigH`, `\ysuPanelH`, `\ysuScreenNext`
- 图：`chapter6/现场运行评价/决策评价/水泥烧成运行指标决策性能统计页面.png`

### P83 `c6-summary`（chapter6，bullets）

- 标题：6.5 本章小结
- 结论句：在线平台支撑感知、预测与决策协同运行
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuContributionItem`, `\ysuKey`, `\ysuPlatformMetric`, `\ysuPlatformObservation`, `\ysuPlatformPrediction`, `\ysuPlatformSummary`

### P84 `c7-toc`（chapter7，toc）

- 标题：(plain)
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseTocFrame`, `\ysuChapterOpener`, `\ysuHL`, `\ysuOpenRow`, `\ysuOpenerBridge`, `\ysuOpenerIcons`, `\ysuOpenerOutline`

### P85 `c7-innovation`（chapter7，cards）

- 标题：结论
- 小节：主要创新点
- 结论句：面向水泥烧成系统的三项方法创新
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseCard`, `\ysuHL`, `\ysuInnovationMedallionSetup`, `\ysuInnovationRowMeta`

### P86 `c7-outlook`（chapter7，outlook）

- 标题：结论
- 小节：研究展望
- 结论句：模型持续适应与跨工序协同优化研究展望
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuHL`, `\ysuOutlookChain`, `\ysuOutlookChainLeft`, `\ysuOutlookPaired`, `\ysuOutlookPanel`

### P87 `c7-achievements`（chapter7，bullets）

- 标题：结论
- 小节：学术成果
- 结论句：攻读博士学位期间取得的研究成果
- 公式 0 / 表格 0 / 口播 有
- 宏：`\ysuAchievement`, `\ysuPaperAchievements`, `\ysuPaperBadge`, `\ysuPaperRow`

### P88 `thanks`（back，thanks）

- 标题：(plain)
- 公式 0 / 表格 0 / 口播 有
- 宏：`\DefenseThanksFrame`, `\ysuThanksRecap`, `\ysuThanksTag`, `\ysuThanksTags`

