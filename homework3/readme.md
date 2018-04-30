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

<img src="https://github.com/Wenju-Huang/data_mini/raw/master/homework3/result/train.jpg" height="300" width="400" > <img src="https://github.com/Wenju-Huang/data_mini/raw/master/homework3/result/test.jpg" height="300" width="400" > 

## 分类
本实验用了两种分类方法进行挖掘分析，一种是决策树另一种是SVM。
### 决策树
> A decision tree is a decision support tool that uses a tree-like graph or model of decisions and their possible consequences, including chance event outcomes, resource costs, and utility. It is one way to display an algorithm that only contains conditional control statements.
Decision trees are commonly used in operations research, specifically in decision analysis, to help identify a strategy most likely to reach a goal, but are also a popular tool in machine learning.

本实验采用的市cart决策树，用Twoing指标作为分裂准则，然后再用交叉检验进行后剪枝。我们先在训练集构造好决策树，然后再在测试集进行分类测试。测试集的分类结果如图所示。

<img src="https://github.com/Wenju-Huang/data_mini/raw/master/homework3/result/decision_tree.jpg" height="300" width="400" >

对照决策树的分类结果分布和训练集的分布，我们可以看到两者的两个类别的分布大致一样，所以决策树能对大多数测试样本进行正确的分类。
### SVM
> SVM是最大间隔分类器，它能够在训练样本的空间上，找到一个分类平面，使得两类样本直接的最小距离尽可能地大。对于线性不可分的样本，运用核技巧，映射到高维空间，再在高维空间进行划分。
本实验选用rbf核函数，方差默为1的svm，同样先在训练集进行训练然后再在测试集进行测试。测试的结果如下图所示。

<img src="https://github.com/Wenju-Huang/data_mini/raw/master/homework3/result/svm.jpg" height="300" width="400" >

从上图可以看出，相比于决策树，svm的结果分布图更接近于训练集的结果，因此，我们可以初步推断svm在本实验中的分类结果比决策树还要好。

## 聚类
本实验用了两种聚类方法进行挖掘分析，一种是Kmeans, 另一种是分层聚类。
### kmens
> K-means算法是最为经典的基于划分的聚类方法，是十大经典数据挖掘算法之一。K-means算法的基本思想是：以空间中k个点为中心进行聚类，对最靠近他们的对象归类。通过迭代的方法，逐次更新各聚类中心的值，直至得到最好的聚类结果。
本实验中设置K为2，用欧氏距离来度量，得到聚类结果如下图所示

<img src="https://github.com/Wenju-Huang/data_mini/raw/master/homework3/result/kmean.jpg" height="300" width="400" >

从上图可以看到，kmeans聚类的结果和训练的结果相差甚远，这是因为一是样本在欧式空间没有很明显的距离划分，二kmeans聚类对初始中心选取敏感。

### 层次聚类
上面说到，kmeans 初始聚类中心的选取会影响到聚类的结果，而在层次聚类中，这个问题可以很好地被解决。层次聚类就是一层一层的进行聚类，可以由上向下把大的类别（cluster）分割，叫作分裂法；也可以由下向上对小的类别进行聚合，叫作凝聚法；本实验选用的的是由下向上的凝聚方法，实验结果如下图所示。

<img src="https://github.com/Wenju-Huang/data_mini/raw/master/homework3/result/hierarchical.jpg" height="300" width="400" >

从上图可以看到，层次聚类发可以很好地把样本划分成两类，并且结果的分布与训练集很相似。



