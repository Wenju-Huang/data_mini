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
关联规则
> - eval.txt  
关联规则评价，包括支持度，置信度和相关性系数lift
* main.m  
主函数
* Apriori.m  
Apriori算法，用以计算属性的关联规则
* PrintFrequentItemset.m  
打印数据的频繁集和支持度
* PrintRules.m  
打印数据的相关规则和对于的支持度，置信度和lift相关性系数
## 挖掘过程
### 数据处理
本实验我们用的是San Francisco Building Permits，包含了198900条记录，没条记录有43个属性，其中数值属性13个，标称属性30个。对于数值属性，我们对其取负作为其标识，对于标称属性，我们给每个标称取个独一的正数字标识。由于数据集包含了19万条记录，过于庞大，全部计算耗时过大，因此我们随机采样10000条用以计算关联规则。
### 挖掘算法
本实验采用的算法关联规则挖掘算法为Apriori。Apriori算法是一种用于关联规则挖掘（Association rule mining）的代表性算法，它根据数据的支持度和置信度来减枝搜索，从而减少搜索空间，提升算法效率。Apriori算法的详细说明可见[数据挖掘十大算法之Apriori详解](https://blog.csdn.net/baimafujinji/article/details/53456931)
### 主要公式
在关联规则挖掘中，我们主要用数据的支持度（support）和置信度（confidence）来度量。支持度（s：Fraction of transactions that contain both X and Y）和置信度（c：How often items in Y appear in transactions that contain X）这两种度量的形式定义如下：  

$$
   f(x) = y
$$

s(X \rightarrow Y) = \frac{\delat (X \cup Y)}{N} 
