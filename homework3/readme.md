# 数据挖掘作业3 分类与聚类
## 问题描述 
[作业描述](https://bitdm.github.io/2018/assignment3/)
## 代码说明
### 环境
* MATLAB2017a
### 代码目录
* data/  
数据集
* result/  
测试结果
* main.m  
主函数
* classify_svm.m  
svm 分类器
* classify_tree.m  
决策树
* cluster_kmean.m  
kmeans 聚类
* cluster_DBSCAN.m  
DBSCAN 聚类
## 实验过程与结果
### 数据集
在本实验中，我们选择的数据集是[titanic](https://www.kaggle.com/c/titanic/data)，titanic 包含了PassengerId, Pclass, Name, Sex,...
    Age, SibSp, Parch, Ticket, Fare, Cabin, Embarked十一个属性和一个二值类别Survived。在十一类别中，PassengerId、Name、Ticket、 Cabin、 Embarked这几个属性明显和Survived无关，我们去掉他们，所以只用Pclass, Sex, Age, SibSp, Parch, Fare这六个属性进行分类和聚类。
### 可视化方法
由于本实验的样本市六维的，在二维或者三维的空间都不能很好地可视化，因此，我们考虑用LDA线性判别模型对原始数据进行投影后再可视化。考虑用LDA而不用PCA是因为我们希望投影后的数据在二维平面上有一定的区分度。对于训练集的数据，我们更加其label(Survived)计算出投影矩阵W，然后再投影；对于测试集的数据，我们直接用训练级的投影矩阵来投影。训练集和测试集数据的可视化如下图所示，左为训练集，右为测试集。
