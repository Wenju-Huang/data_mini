# 作业一：数据探索性分析与数据预处理
## 问题描述 
[作业描述](https://bitdm.github.io/2018/assignment1/ "Title")
## 数据分析
### 数据可视化和摘要
#### 数据集1 
经过初步分析，数据集中的标称属性有：
>{'TimeUnder'; 'TimeSecs'; 'PlayTimeDiff'; 'yrdln'; 'yrdline100'; 'ydstogo';'ydsnet';'Yards.Gained';'AirYards';'YardsAfterCatch';'FieldGoalDistance';'Penalty.Yards';'PosTeamScore';'DefTeamScore';'ScoreDiff';'AbsScoreDiff';'posteam_timeouts_pre';'HomeTimeouts_Remaining_Pre';'AwayTimeouts_Remaining_Pre';'HomeTimeouts_Remaining_Post';'AwayTimeouts_Remaining_Post';'No_Score_Prob';'Opp_Field_Goal_Prob';'Opp_Safety_Prob';'Opp_Touchdown_Prob';'Field_Goal_Prob';'Safety_Prob';'Touchdown_Prob';'ExPoint_Prob';'TwoPoint_Prob';'ExpPts';'EPA';'airEPA';'yacEPA';'Home_WP_pre';'Away_WP_pre';'Home_WP_post';'Away_WP_post';'Win_Prob';'WPA';'airWPA';'yacWPA'}

其中属性PlayType每个取值的概率为:

| 属性值         | 频数          | 频率  |
| ------------- |:-------------:| -----:|
|End of Game          |            1973           |           0.48%|
 |        Extra Point  |                   10063   |                   2.47%|
  |        Field Goal   |                   8928    |                  2.19%|
  |        Half End     |                   40      |              0.01%|
  |          Kickoff      |               23403       |               5.74%|
  |          No Play       |              21414        |              5.25%|
  |              Pass       |             159353        |             39.09%|
  |              Punt        |             22003         |             5.40%|
  |         QB Kneel          |            3530           |           0.87%|
  |      Quarter End          |            4914           |           1.21%|
  |              Run            |        120831             |        29.64%|
  |             Sack             |        10649              |        2.61%|
  |            Spike             |          640              |        0.16%|
  |         Timeout              |       16206               |       3.98%|
  |Two Minute Warning               |       3741                |      0.92%|
  
  其他标称属性的取值的频数见[result](../../NFL/resul/Nominal)。在计算标称属性的过程中，由于有些标称属性的取值过多（像日期）造成统计困难，并且统计出来的频率也接近于零。对于这些标称属性，当其取值大于1000时，我们剔除不统计。
