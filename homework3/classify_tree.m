function classify_tree(xTrain,yTrain, xCtrl, yCtrl)
    TrainId = 1:2:size(xTrain,1);
    
    T = fitctree(xTrain(TrainId,:), yTrain(TrainId,:) ,'SplitCriterion','twoing');
    
    [~,~,~,bestlevel] = cvLoss(T,...  
        'SubTrees','All','TreeSize','min') ;
    optimalTree = prune(T,'Level',bestlevel);
    
    yPre = predict(optimalTree, xCtrl);
    
    accurary = mean(yPre == yCtrl);
    disp(['accurary of decision tree: ',num2str(accurary)]);
    [~,projData] = LDA(xCtrl,yCtrl,[0,1],2);
    
    f = figure;
    plot(projData(yPre==0,1),projData(yPre==0,2),'r*');
    hold on
    plot(projData(yPre==1,1),projData(yPre==1,2),'g*');
    legend('unSurvived','Survived');
    title('result of decision tree');
    saveas(f,'result/decision_tree.jpg');