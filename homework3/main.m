clear; close all;

%% ����ѵ����
fid = fopen('data/train.csv');
train = textscan(fid, '%d%d%d%q%s%d%d%d%s%f%s%s', 'delimiter', ',', ...
    'headerLines', 1);
fclose(fid);

varNames = { 'PassengerId', 'Survived', 'Pclass', 'Name', 'Sex',...
    'Age', 'SibSp', 'Parch', 'Ticket', 'Fare', 'Cabin', 'Embarked' };
xNames = { 'Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Fare' };
yNames = { 'Survived' };

trainSet = dataset(train{:});
trainSet.Properties.VarNames = varNames;
trainSet.Sex = grp2idx(cellstr(trainSet.Sex));

xTrain = double(trainSet(:, xNames));
xTrain(isnan(xTrain))=0;
yTrain = double(trainSet(:, yNames));

%% ������Լ�����
fid = fopen('data/test.csv');
test = textscan(fid, '%d%d%q%s%d%d%d%s%f%s%s', 'delimiter', ',', ...
    'headerLines', 1);
fclose(fid);

ctrlSet = dataset(test{:});
ctrlSet.Properties.VarNames = { 'PassengerId', 'Pclass', 'Name', 'Sex',...
    'Age', 'SibSp', 'Parch', 'Ticket', 'Fare', 'Cabin', 'Embarked' };
ctrlSet.Sex = grp2idx(cellstr(ctrlSet.Sex));

xCtrl = double(ctrlSet(:, xNames));
xCtrl(isnan(xCtrl))=0;

%% ������Ա�ǩ
fid = fopen('data/gender_submission.csv');
yCtrl = textscan(fid, '%d%d', 'delimiter', ',', ...
    'headerLines', 1);
fclose(fid);
yCtrl = yCtrl{2};

%% ���ӻ���������
[~,projData] = LDA(xCtrl,yCtrl,[0,1],2);

f = figure(1);
plot(projData(yCtrl==0,1),projData(yCtrl==0,2),'r*');
hold on
plot(projData(yCtrl==1,1),projData(yCtrl==1,2),'g*');
legend('unSurvived','Survived');
title('Visualization of Ground Truth');
saveas(f,'result/Survived.jpg');
%% ����
classify_tree(xTrain,yTrain, xCtrl, yCtrl);
classify_svm(xTrain,yTrain, xCtrl, yCtrl);

%% ����
cluster_kmean(xCtrl, yCtrl);
cluster_DBSCAN(xCtrl, yCtrl)
%%cluster_hierarchical(xCtrl, yCtrl);
