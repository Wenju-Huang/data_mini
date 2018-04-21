function [rules_left, rules_right,eval] = Apriori(temp_attribute_number,rand_index, data,attribute, min_sup, min_conf)%Apriori算法计算频繁项集以及关联规则

%----------变量----------%
literals = unique(temp_attribute_number);%找出所有的项，包含0
L1 = zeros(0,1);%1-频繁项集
supports = zeros(0,1);%频繁项集对应的支持度
L = zeros(0,size(literals,1));%频繁项集
kborder = zeros(0,2);%记录k-频繁项集在L中的边界
bordercount = 0;%辅助记录kborder

%----------生成L1----------%
for i = 1 : size(literals,1)
    if(literals(i) == 0)%对0项不做处理
        continue;
    end
    index = find(temp_attribute_number == literals(i));%找出包含项litertals(i)事务的下标
    if(size(index,1) >= min_sup)%若大等于最小支持度
        itemtemp = [literals(i),zeros(1, size(literals,1)-1)];
        L = [L; itemtemp];%所有项集
        bordercount = bordercount + 1;
        L1 = [L1; literals(i)];%1-项集
        supports = [supports; size(index,1)];%1-项集对应支持度
    end
end  
kborder(1,:) = [1,bordercount];

%----------迭代计算k-频繁项集----------%
k = 2;%首先利用L1计算L2
while(1)
    KL = L(kborder(k-1,1):kborder(k-1,2),:);%取出Lk-1
    kborder(k,1) = bordercount + 1; %记录下Lk在L中的起始下标
    for i = 1 : size(KL,1) - 1%Lk-1连接运算
        for j = i + 1: size(KL,1)
            if(isequal(KL(i,1:k-2),KL(j,1:k-2)) == 1)%满足连接条件
                itemtemp = sort([KL(i,1:k-2),KL(i,k-1),KL(j,k-1)]);
                if(all(ismember(combnk(itemtemp,k-1),KL(:,1:k-1),'rows')) == 1)%使用apriori性质剪枝--k-频繁项集的所有k-1-项子集都是频繁项集
                    suptemp = CheckSup(temp_attribute_number,itemtemp);%计算该项集的支持度
                    if(suptemp >= min_sup)%满足频繁条件
                        itemtemp = [itemtemp,zeros(1,size(literals,1)-size(itemtemp,2))];%末尾补0
                        L = [L;itemtemp];%加入频繁项集
                        bordercount = bordercount + 1;%Lk的项集个数+1
                        supports = [supports;suptemp];
                    end
                end
            end
        end
    end
    kborder(k,2) = bordercount;
    if(kborder(k,1) > kborder(k,2)) %若Lk为空则终止计算
        break;
    end
    k = k + 1;
end

PrintFrequentItemset(temp_attribute_number,rand_index, data, attribute,L,supports);%打印频繁项集及其对应支持度

%----------产生关联规则----------%
rules_left = zeros(0,size(literals,1) - 1);%产生式左部
rules_right = zeros(0,size(literals,1) - 1);%产生式右部
eval = zeros(0,3); % support,confident,life

for i = kborder(2,1) : size(L,1)%对k>=2-频繁项集的每个项集产生关联规则
    l = nonzeros(L(i,:))';
    sup_l = supports(i);
    for j = 1 : size(l,2) - 1%关联式左部项的个数由1到（项集项数-1）
        l_subset = combnk(l,j);%项集l的j项子集集合
        for k = 1 : size(l_subset,1)
            s = l_subset(k,:);%左部项
            sup_s = FindSup(s, L, supports);%找对应频繁项集的支持度
            if(sup_l / sup_s >= min_conf)%满足强关联条件
                ltemp = [s,zeros(1, size(literals,1)-1-size(s,2))];
                rules_left = [rules_left; ltemp];
                l_s = setdiff(l,s);%右部项，即项集-左部项剩余的项
                rtemp = [l_s,zeros(1, size(literals,1)-1-size(l_s,2))];
                rules_right = [rules_right; rtemp];
                sup_l_s = FindSup(l_s, L, supports);%找对应频繁项集的支持度
                lift = (sup_l*size(temp_attribute_number,1)) / (sup_s*sup_l_s);
                eval = [eval;sup_l/size(temp_attribute_number,1),sup_l / sup_s,lift];
            end
        end
    end
end
    

