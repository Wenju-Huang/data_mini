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
