# 作业一：数据探索性分析与数据预处理
## 问题描述 
[作业描述](https://bitdm.github.io/2018/assignment1/ "Title")
## 数据分析
### 数据集1 NFL Play-by-Play 2009-2017
数据集1的程序代码和结果见NFL文件夹
#### 数据可视化和摘要
##### 数据摘要
经过初步分析，数据集中的标称属性有：
>' Date';'GameID';'Drive';'qtr';'down';'time';'SideofField';'GoalToGo';'FirstDown';'posteam';'DefensiveTeam';...
    'desc';'PlayAttempted';'sp';'Touchdown';'ExPointResult';'TwoPointConv';'DefTwoPoint';'Safety';'Onsidekick';'PuntResult';...
    'PlayType';'Passer';'Passer_ID';'PassAttempt';'PassOutcome';'PassLength';'QBHit';'PassLocation';'InterceptionThrown';...
    'Interceptor';'Rusher';'Rusher_ID';'RushAttempt';'RunLocation';'RunGap';'Receiver';'Receiver_ID';'Reception';'ReturnResult';...
    'Returner';'BlockingPlayer';'Tackler1';'Tackler2';'FieldGoalResult';'Fumble';'RecFumbTeam';'RecFumbPlayer';'Sack';...
    'Challenge.Replay';'ChalReplayResult';'Accepted.Penalty';'PenalizedTeam';'PenaltyType';'PenalizedPlayer';'HomeTeam';...
    'AwayTeam';'Timeout_Indicator';'Timeout_Team';'Season'

其中属性PlayType每个取值的概率为:

| 属性值         | 频数          | 频率  |
| ------------- |:-------------:| -----:|
|End of Game          |            1973           |           0.48%|
 |        Extra Point  |                   10063   |                   2.47%|
  |        Field Goal   |                   8928    |                  2.19%|
  |   Half End   |  40   |              0.01%|
  |          Kickoff      |               23403       |               5.74%|
  |          No Play       |              21414        |              5.25%|
  |              Pass       |             159353        |             39.09%|
  |              Punt        |             22003         |             5.40%|
  |         QB Kneel          |            3530           |           0.87%|
  |    Quarter End      |     4914        |           1.21%|
  |              Run            |        120831             |        29.64%|
  |             Sack             |        10649              |        2.61%|
  |            Spike             |          640              |        0.16%|
  |         Timeout              |       16206               |       3.98%|
  |Two Minute Warning               |       3741                |      0.92%|
  
  其他标称属性的取值的频数见[NFL/result/Nominal](https://github.com/Wenju-Huang/data_mini/raw/master/NFL/result/Nominal)。在计算标称属性的过程中，由于有些标称属性的取值过多（像日期）造成统计困难，并且统计出来的频率也接近于零。对于这些标称属性，当其取值大于1000时，我们剔除不统计。

经过初步分析，数据集中的数值属性有：
>'TimeUnder'; 'TimeSecs'; 'PlayTimeDiff'; 'yrdln'; 'yrdline100'; 'ydstogo';'ydsnet';'Yards.Gained';'AirYards';'YardsAfterCatch';'FieldGoalDistance';'Penalty.Yards';'PosTeamScore';'DefTeamScore';'ScoreDiff';'AbsScoreDiff';'posteam_timeouts_pre';'HomeTimeouts_Remaining_Pre';'AwayTimeouts_Remaining_Pre';'HomeTimeouts_Remaining_Post';'AwayTimeouts_Remaining_Post';'No_Score_Prob';'Opp_Field_Goal_Prob';'Opp_Safety_Prob';'Opp_Touchdown_Prob';'Field_Goal_Prob';'Safety_Prob';'Touchdown_Prob';'ExPoint_Prob';'TwoPoint_Prob';'ExpPts';'EPA';'airEPA';'yacEPA';'Home_WP_pre';'Away_WP_pre';'Home_WP_post';'Away_WP_post';'Win_Prob';'WPA';'airWPA';'yacWPA'

部分数值属性的最大、最小、均值、中位数、四分位数及缺失值的个数如下表：

|attribute                |Maximium      |Minimium      |Average         |Median           |Quartile           |Missing    |
| ------------- |:-------------:| ------------:|:-------------:| ------------:|:-------------:| --------------:|
|TimeUnder|15.00|0.00|7.37420|7.00|3.00,11.00|0.00|
|TimeSecs|3600.00|-900.00|1695.26894|1800.00|778.00,2585.00|224.00|
|PlayTimeDiff|943.00|0.00|20.57676|17.00|5.00,37.00|444.00|
|yrdln|50.00|1.00|28.48833|30.00|20.00,39.00|840.00|
|yrdline100|99.00|1.00|48.64408|49.00|30.00,70.00|840.00|
|ydstogo|50.00|0.00|7.30940|9.00|3.00,10.00|0.00|
|ydsnet|99.00|-87.00|25.94552|19.00|5.00,43.00|0.00|
|Yards.Gained|99.00|-74.00|4.99422|1.00|0.00,7.00|0.00|
|AirYards|84.00|-70.00|3.26401|0.00|0.00,4.00|0.00|
|YardsAfterCatch|90.00|-81.00|1.25260|0.00000|0.00000,0.00000|0.00000|

其余属性的统计摘要见
[/NFL/result/Number/number_statistics/Data_abstract_of_attribute.txt](https://github.com/Wenju-Huang/data_mini/tree/master/NFL/result/Number/number_statistics/Data_abstract_of_attribute.txt)文件
##### 数据可视化
* 绘制数据直方图  
其中，在数值属性'ExpPts','EPA','airEPA','yacEPA','Home_WP_pre','Away_WP_pre'的直方图即qq图如下：
<img src="https://github.com/Wenju-Huang/data_mini/raw/master/NFL/result/Number/number_orignal/histogram_5.jpg" height="300" width="400" /><img src="https://github.com/Wenju-Huang/data_mini/raw/master/NFL/result/Number/number_orignal/qqplot_5.jpg" height="300" width="400" />

从上图可以看出 ExpPts、EPA、airEPA 和 yacEPA 均接近正态分布，并且均值大概都在 0 附近，HomewPpre 和 AwaywPpre 的分布类似，类似均匀分布，但是
在最大值和最小值附近分布较为密集。 从 qq 图也可以判定其前四者更像正态分布，因为在q图中，数据分布近似地在一条直线附近。其余属性的直方图和qq图见
[NFL/result/Number/number_orignal](https://github.com/Wenju-Huang/data_mini/tree/master/NFL/result/Number/number_orignal/)
