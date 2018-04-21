clear;
clc; 
data=importdata('Building_Permits.csv');
load 'processed_permits.mat'
load 'attribute.mat'
total_attribute_number(:,21)=-total_attribute_number(:,21);
total_attribute_number(:,22)=-total_attribute_number(:,22);
total_attribute_number(:,26)=-total_attribute_number(:,26);
total_attribute_number(:,27)=-total_attribute_number(:,27);
total_attribute_number(:,29)=-total_attribute_number(:,29);
total_attribute_number(:,31)=-total_attribute_number(:,31);
total_attribute_number(:,2)=-total_attribute_number(:,2);
total_attribute_number(:,3)=-total_attribute_number(:,3);
total_attribute_number(:,34)=-total_attribute_number(:,34);
total_attribute_number(:,35)=-total_attribute_number(:,35);
total_attribute_number(:,36)=-total_attribute_number(:,36);
total_attribute_number(:,37)=-total_attribute_number(:,37);
total_attribute_number(total_attribute_number==0)=-1.5;
total_attribute_number(isnan(total_attribute_number)) = 0;
%PrintTransactions(total_attribute_number);%打印出事务
min_sup = 5000;%初始化最小支持度
min_conf = 0.7;%初始化最小置信度
rand_index = randi(size(total_attribute_number,1),10000,1);
temp_attribute_number = total_attribute_number(rand_index,:);
[rules_left, rules_right,eval] = Apriori(temp_attribute_number,rand_index, data,attribute, min_sup, min_conf);%运算Apriori算法
PrintRules(temp_attribute_number,rand_index, data,attribute,rules_left, rules_right,eval);%打印强关联规则
