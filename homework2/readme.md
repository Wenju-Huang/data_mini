# 数据挖掘作业2 关联规则挖掘
## 问题描述 
[作业描述](https://bitdm.github.io/2018/assignment2/)
## 代码说明
### 环境
* MATLAB2017a
* Linux 16.04
### 代码目录
* data/  
数据集
* result/  
测试结果
> - frequent.txt  
频繁项和对应的支持度
> - rules.txt  
关联规则及其支持度，置信度和相关性系数lift
* main.m  
主函数
* Apriori.m  
Apriori算法，用以计算属性的关联规则
* PrintFrequentItemset.m  
打印数据的频繁集和支持度
* PrintRules.m  
打印数据的关联规则和对于的支持度，置信度和lift相关性系数
## 挖掘过程
### 数据处理
本实验我们用的是San Francisco Building Permits，包含了198900条记录，没条记录有43个属性，其中数值属性13个，标称属性30个。对于数值属性，我们对其取负作为其标识，对于标称属性，我们给每个标称取个独一的正数字标识。由于数据集包含了19万条记录，过于庞大，全部计算耗时过大，因此我们随机采样10000条用以计算关联规则。
### 挖掘算法
本实验采用的算法关联规则挖掘算法为Apriori。Apriori算法是一种用于关联规则挖掘（Association rule mining）的代表性算法，它根据数据的支持度和置信度来减枝搜索，从而减少搜索空间，提升算法效率。Apriori算法的详细说明可见[数据挖掘十大算法之Apriori详解](https://blog.csdn.net/baimafujinji/article/details/53456931)
### 参数设置
在本实验中，我们设置支持度的阈值为0.5，置信度的阈值为0.7。
## 挖掘结果与分析
### 频繁集项
数据集中支持度大于0.5的频繁项如下:
```c  
--------------------------Frequent Itemset|Suppoort-------------------------
FI 1:  8 (Permit Type)|support:18337
FI 2:  5 (Permit Type)|support:23696
FI 3:  3 (Permit Type)|support:9082
FI 4:  2 (Permit Type)|support:8371
FI 5:  1 (Permit Type)|support:14512
FI 6:  201301000000 (Permit_Number)|support:11879
FI 7:  201302000000 (Permit_Number)|support:6393
FI 8:  201303000000 (Permit_Number)|support:6534
FI 9:  201304000000 (Permit_Number)|support:6934
FI10:  201309000000 (Permit_Number)|support:9989
FI11:  201405000000 (Permit_Number)|support:7922
FI12:  1420130000000 (Record_ID)|support:10000
FI13:  8 (Permit Type), 5 (Permit Type)|support:5311
FI14:  8 (Permit Type), 1 (Permit Type)|support:5729
FI15:  8 (Permit Type), 201301000000 (Permit_Number)|support:5850
FI16:  8 (Permit Type), 201304000000 (Permit_Number)|support:5413
FI17:  8 (Permit Type), 201309000000 (Permit_Number)|support:6048
FI18:  8 (Permit Type), 201405000000 (Permit_Number)|support:6667
FI19:  8 (Permit Type), 1420130000000 (Record_ID)|support:9028
FI20:  5 (Permit Type), 1420130000000 (Record_ID)|support:6020
FI21:  1 (Permit Type), 1420130000000 (Record_ID)|support:6249
FI22:  201301000000 (Permit_Number), 1420130000000 (Record_ID)|support:6474
FI23:  201303000000 (Permit_Number), 1420130000000 (Record_ID)|support:5709
FI24:  201304000000 (Permit_Number), 1420130000000 (Record_ID)|support:5874
FI25:  201309000000 (Permit_Number), 1420130000000 (Record_ID)|support:6596
FI26:  201405000000 (Permit_Number), 1420130000000 (Record_ID)|support:7367
FI27:  8 (Permit Type), 5 (Permit Type), 1420130000000 (Record_ID)|support:5311
FI28:  8 (Permit Type), 1 (Permit Type), 1420130000000 (Record_ID)|support:5729
FI29:  8 (Permit Type), 201301000000 (Permit_Number), 1420130000000 (Record_ID)|support:5850
FI30:  8 (Permit Type), 201304000000 (Permit_Number), 1420130000000 (Record_ID)|support:5413
FI31:  8 (Permit Type), 201309000000 (Permit_Number), 1420130000000 (Record_ID)|support:6048
FI32:  8 (Permit Type), 201405000000 (Permit_Number), 1420130000000 (Record_ID)|support:6667
------------------------------------------------------------------
```
### 关联规则
我们统计挖掘出的关联项及其支持度、置信度如下
```c
-------------------------------Rules------------------------------
R 1:201304000000 (Permit_Number) ==> 8 (Permit Type)  |support: 0.541, confident: 0.781, lift: 0.43
R 2:201405000000 (Permit_Number) ==> 8 (Permit Type)  |support: 0.667, confident: 0.842, lift: 0.46
R 3:1420130000000 (Record_ID) ==> 8 (Permit Type)  |support: 0.903, confident: 0.903, lift: 0.49
R 4:201303000000 (Permit_Number) ==> 1420130000000 (Record_ID)  |support: 0.571, confident: 0.874, lift: 0.87
R 5:201304000000 (Permit_Number) ==> 1420130000000 (Record_ID)  |support: 0.587, confident: 0.847, lift: 0.85
R 6:201405000000 (Permit_Number) ==> 1420130000000 (Record_ID)  |support: 0.737, confident: 0.930, lift: 0.93
R 7:1420130000000 (Record_ID) ==> 201405000000 (Permit_Number)  |support: 0.737, confident: 0.737, lift: 0.93
R 8:8 (Permit Type), 5 (Permit Type) ==> 1420130000000 (Record_ID)  |support: 0.531, confident: 1.000, lift: 1.00
R 9:5 (Permit Type), 1420130000000 (Record_ID) ==> 8 (Permit Type)  |support: 0.531, confident: 0.882, lift: 0.48
R10:8 (Permit Type), 1 (Permit Type) ==> 1420130000000 (Record_ID)  |support: 0.573, confident: 1.000, lift: 1.00
R11:1 (Permit Type), 1420130000000 (Record_ID) ==> 8 (Permit Type)  |support: 0.573, confident: 0.917, lift: 0.50
R12:8 (Permit Type), 201301000000 (Permit_Number) ==> 1420130000000 (Record_ID)  |support: 0.585, confident: 1.000, lift: 1.00
R13:201301000000 (Permit_Number), 1420130000000 (Record_ID) ==> 8 (Permit Type)  |support: 0.585, confident: 0.904, lift: 0.49
R14:201304000000 (Permit_Number) ==> 8 (Permit Type), 1420130000000 (Record_ID)  |support: 0.541, confident: 0.781, lift: 0.86
R15:8 (Permit Type), 201304000000 (Permit_Number) ==> 1420130000000 (Record_ID)  |support: 0.541, confident: 1.000, lift: 1.00
R16:201304000000 (Permit_Number), 1420130000000 (Record_ID) ==> 8 (Permit Type)  |support: 0.541, confident: 0.922, lift: 0.50
R17:8 (Permit Type), 201309000000 (Permit_Number) ==> 1420130000000 (Record_ID)  |support: 0.605, confident: 1.000, lift: 1.00
R18:201309000000 (Permit_Number), 1420130000000 (Record_ID) ==> 8 (Permit Type)  |support: 0.605, confident: 0.917, lift: 0.50
R19:201405000000 (Permit_Number) ==> 8 (Permit Type), 1420130000000 (Record_ID)  |support: 0.667, confident: 0.842, lift: 0.93
R20:8 (Permit Type), 201405000000 (Permit_Number) ==> 1420130000000 (Record_ID)  |support: 0.667, confident: 1.000, lift: 1.00
R21:8 (Permit Type), 1420130000000 (Record_ID) ==> 201405000000 (Permit_Number)  |support: 0.667, confident: 0.738, lift: 0.93
R22:201405000000 (Permit_Number), 1420130000000 (Record_ID) ==> 8 (Permit Type)  |support: 0.667, confident: 0.905, lift: 0.49  
```
从上面的数据可以看出，关联项的6,7,8,10,12,15,17,19,20,21虽然是强规则，但其的相关系数均大于0.9，说明他们实际上是独立的，不是正确的关联项。
