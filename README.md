# 作业一：数据探索性分析与数据预处理
## 问题描述 
[作业描述](https://bitdm.github.io/2018/assignment1/ "Title")
## 代码说明
### 环境
* MATLAB2017a
* Linux 16.04
### 代码目录
* NFL  
数据集 NFL Play-by-Play 2009-2017的代码和结果
> - main.m 
主程序
> - preprocessing.m
填补数据缺失值，有三种方法（1）最高频值替代（2）属性相关关系（3）对象相似性
> - visualization.m
数据可视化，用于绘制直方图、QQ图、盒图
* SanBuilding  
数据集 San Francisco Building Permits 的代码和结果
> - main.m 
主程序
> - preprocessing.m
填补数据缺失值，有三种方法（1）最高频值替代（2）属性相关关系（3）对象相似性
> - visualization.m
数据可视化，用于绘制直方图、QQ图、盒图
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
其中，在数值属性'ExpPts','EPA','airEPA','yacEPA','Home_WP_pre','Away_WP_pre'的直方图和qq图如下：
<img src="https://github.com/Wenju-Huang/data_mini/raw/master/NFL/result/Number/number_orignal/histogram_5.jpg" height="300" width="400" /><img src="https://github.com/Wenju-Huang/data_mini/raw/master/NFL/result/Number/number_orignal/qqplot_5.jpg" height="300" width="400" />

从直方图可以看出 ExpPts、EPA、airEPA 和 yacEPA 均接近正态分布，并且均值大概都在 0 附近，HomewPpre 和 AwaywPpre 的分布类似，类似均匀分布，但是
在最大值和最小值附近分布较为密集。 从 qq 图也可以判定其前四者更像正态分布，因为在q图中，数据分布近似地在一条直线附近。其余属性的直方图和qq图见
[NFL/result/Number/number_orignal](https://github.com/Wenju-Huang/data_mini/tree/master/NFL/result/Number/number_orignal/)

* 绘制盒图

>盒图（英文：Box plot）是一种用作显示一组数据分散情况资料的统计图。因型状如盒子而得名。在各种领域也经常被使用，常见于品质管理，快速识别异常值。关于盒图的详细说明见
[箱形图-快速识别离群值](https://blog.csdn.net/qq_39303465/article/details/79221254)

其中，在数值属性'ExpPts','EPA','airEPA','yacEPA','Home_WP_pre','Away_WP_pre'的盒图如下：
/><img src="https://github.com/Wenju-Huang/data_mini/raw/master/NFL/result/Number/number_orignal/boxplot_5.jpg" height="300" width="400" />

从上图可以看出可以看出 ExpPts、HomewPpre 和 AwaywPp 的离散值比较小，EPA,airEPA,yacEPA的离散值比较大。

#### 数据缺失的处理
1  分析数据缺失的原因  
数据缺失的原因是多方面的，常见的缺失情况有：
* 信息暂时无法获取。例如在医疗数据库中，并非所有病人的所有临床检验结果都能在给定的时间内得到，就致使一部分属性值空缺出来。
* 信息被遗漏。可能是因为输入时认为不重要、忘记填写了或对数据理解错误而遗漏，也可能是由于数据采集设备的故障、存储介质的故障、传输媒体的故障、一些人为因素等原因而丢失。
* 有些对象的某个或某些属性是不可用的。如一个未婚者的配偶姓名、一个儿童的固定收入状况等

2  缺失值处理  
在可视化缺失值处理中，我们同样是选择'ExpPts','EPA','airEPA','yacEPA','Home_WP_pre','Away_WP_pre' 这五个属性的直方图来比较。其余的可视化图见[NFL/result/Number](https://github.com/Wenju-Huang/data_mini/tree/master/NFL/result/Number/)文件夹。  
- 将缺失部分剔除  
剔除掉缺失值的属性的直方图如下所示：  
<img src="https://github.com/Wenju-Huang/data_mini/raw/master/NFL/result/Number/number_orignal/histogram_5.jpg" height="300" width="400" >  

- 用最高频率值来填补缺失值  
用最高频率值来填补缺失值的直方图如下所示。  
<img src="https://github.com/Wenju-Huang/data_mini/raw/master/NFL/result/Number/number_filledbymaxium/histogram_5.jpg" height="300" width="400" >  
对比剔除缺失值的情况可发现，用最高频率值填补后，最高频的属性的频数变得更多，其直方图会更高。也就是说本填补方法的直方图的最高值比剔除缺失值的方法高，而直方图的其他部分和剔除的方法一样。  

- 通过相关属性来填补缺失值  
通过相关属性来填补缺失的效果如下图所示  
<img src="https://github.com/Wenju-Huang/data_mini/raw/master/NFL/result/Number/number_filledbyattributes/histogram_5.jpg" height="300" width="400" >  

- 通过数据对象之间的相似性来填补缺失值  

<img src="https://github.com/Wenju-Huang/data_mini/raw/master/NFL/result/Number/number_filledbysimilarity/histogram_5.jpg" height="300" width="400" >

从上面结果可以看到，用相关属性和对象相似性来填补缺失值后，数据分布与原来数据根本基本一直，说明这种填补方法不会改变数据的分布，比用最高频率的方法跟可靠。

### 数据集2 San Francisco Building Permits
数据集1的程序代码和结果见SanBuilding文件夹
#### 数据可视化和摘要
##### 数据摘要
经过初步分析，数据集中的标称属性有：
>'Permit Number'; 'Permit Creation Date'; 'Block'; 'Lot'; 'Street Number'; 'Street Number Suffix';'Street Name';'Street Suffix';'Unit';'Unit Suffix';'Description';'Current Status';'Current Status Date';'Filed Date';'Issued Date';'Completed Date';'First Construction Document Date';'Structural Notification';'Voluntary Soft-Story Retrofit';'Fire Only Permit';'Permit Expiration Date';'Existing Use';'Proposed Use';'Plansets';'TIDF Compliance';'Site Permit';'Supervisor District';'Neighborhoods - Analysis Boundaries';'Zipcode';'Location';'Record ID';'Permit Type'; 'Existing Construction Type'; 'Proposed Construction Type'

其中属性Current Status每个取值的概率为:

| 属性值         | 频数          | 频率  |
| ------------- |:-------------:| -----:|
|             appeal|                        2|                     0.00%|
|           approved|                      733|                     0.37%|
|          cancelled|                     1536|                     0.77%|
|           complete|                    97077|                    48.81%|
|        disapproved|                        2|                     0.00%|
|            expired|                     1370|                     0.69%|
|              filed|                    12043|                     6.05%|
|         incomplete|                        2|                     0.00%|
|             issued|                    83559|                    42.01%|
|          plancheck|                       16|                     0.01%|
|         reinstated|                      563|                     0.28%|
|            revoked|                       50|                     0.03%|
|            suspend|                      193|                     0.10%|
|          withdrawn|                     1754|                     0.88%|
  
  其他标称属性的取值的频数见[SanBuilding/result/Nominal](https://github.com/Wenju-Huang/data_mini/raw/master/SanBuilding/result/Nominal)。在计算标称属性的过程中，由于有些标称属性的取值过多（像日期）造成统计困难，并且统计出来的频率也接近于零。对于这些标称属性，当其取值大于1000时，我们剔除不统计。

经过初步分析，数据集中的数值属性有：
>'Number of Existing Stories'; 'Number of Proposed Stories'; 'Estimated Cost'; 'Revised Cost'; 'Existing Units'; 'Proposed Units'

数值属性的最大、最小、均值、中位数、四分位数及缺失值的个数如下表：

|attribute                |Maximium      |Minimium      |Average         |Median           |Quartile           |Missing    |
| ------------- |:-------------:| ------------:|:-------------:| ------------:|:-------------:| --------------:|
|Existing Stories|78|0|5.7058|3|2, 4|42784|
|Proposed Stories|78|0|5.745|3|2, 4|42868|
|Estimated Cost|537958646|1|168955.4433|11000|3300, 35000|38066|
|Revised Cost|780500000|0|132856.1865|7000|1, 28710|6066|
|Existing Units|1907|0|15.6662|1|1, 4|51538|
|Proposed Units|1911|0|16.511|2|1, 4|50911|

##### 数据可视化
* 绘制数据直方图  
在数值属性'Number of Existing Stories'; 'Number of Proposed Stories'; 'Estimated Cost'; 'Revised Cost'; 'Existing Units'; 'Proposed Units'的直方图和qq图如下：

<img src="https://github.com/Wenju-Huang/data_mini/raw/master/SanBuilding/result/Number/raw_graph.PNG" height="300" width="400" /><img src="https://github.com/Wenju-Huang/data_mini/raw/master/SanBuilding/result/Number/raw_qq.PNG" height="300" width="400" />

从直方图可以看出六个数据都不像均正态分布。属性'Number of Existing Stories'; 'Number of Proposed Stories';呈现泊松分布。属性'Estimated Cost'; 'Revised Cost'; 'Existing Units'; 'Proposed Units'的分布集中在最小值处。 从 qq 图也可以判定其这六个属性都不是正态分布，因为在q图中，数据没有分布在一条直线附近。
* 绘制盒图

>盒图（英文：Box plot）是一种用作显示一组数据分散情况资料的统计图。因型状如盒子而得名。在各种领域也经常被使用，常见于品质管理，快速识别异常值。关于盒图的详细说明见
[箱形图-快速识别离群值](https://blog.csdn.net/qq_39303465/article/details/79221254)

数值属性的盒图如下：

/><img src="https://github.com/Wenju-Huang/data_mini/raw/master/SanBuilding/result/Number/raw_box.PNG" height="300" width="400" />

从上图可以看出可以看出这六个属性的离散值都比较大。

#### 数据缺失的处理
1  分析数据缺失的原因  
数据缺失的原因是多方面的，常见的缺失情况有：
* 信息暂时无法获取。例如在医疗数据库中，并非所有病人的所有临床检验结果都能在给定的时间内得到，就致使一部分属性值空缺出来。
* 信息被遗漏。可能是因为输入时认为不重要、忘记填写了或对数据理解错误而遗漏，也可能是由于数据采集设备的故障、存储介质的故障、传输媒体的故障、一些人为因素等原因而丢失。
* 有些对象的某个或某些属性是不可用的。如一个未婚者的配偶姓名、一个儿童的固定收入状况等

2  缺失值处理  
在可视化缺失值处理中，我们同样是选择属性的直方图来比较。
- 将缺失部分剔除  
剔除掉缺失值的属性的直方图如下所示：  

<img src="https://github.com/Wenju-Huang/data_mini/raw/master/SanBuilding/result/Number/raw_graph.PNG" height="300" width="400" >  

- 用最高频率值来填补缺失值  
用最高频率值来填补缺失值的直方图如下所示。  

<img src="https://github.com/Wenju-Huang/data_mini/raw/master/SanBuilding/result/Number/filled_by_max_graph.PNG" height="300" width="400" >  

对比剔除缺失值的情况可发现，用最高频率值填补后，最高频的属性的频数变得更多，其直方图会更高。也就是说本填补方法的直方图的最高值比剔除缺失值的方法高，而直方图的其他部分和剔除的方法一样。  

- 通过相关属性来填补缺失值  
通过相关属性来填补缺失的效果如下图所示  

<img src="https://github.com/Wenju-Huang/data_mini/raw/master/SanBuilding/result/Number/filled_by_attribute_graph.PNG" height="300" width="400" >  

- 通过数据对象之间的相似性来填补缺失值  

<img src="https://github.com/Wenju-Huang/data_mini/raw/master/SanBuilding/result/Number/2filled_by_similarity_graph.PNG" height="300" width="400" >

从上面结果可以看到，用相关属性和对象相似性来填补缺失值后，数据分布与原来数据根本基本一直，说明这种填补方法不会改变数据的分布，比用最高频率的方法跟可靠。
