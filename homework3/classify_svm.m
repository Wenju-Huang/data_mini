function classify_svm(xTrain,yTrain, xCtrl, yCtrl)

%     xTrain = normalize(xTrain);
%     xCtrl = normalize(xCtrl);
    SVMModel = fitcsvm(xTrain,yTrain,'KernelFunction','rbf','Standardize',true,'ClassNames',[0,1]);
    
    yPre = predict(SVMModel,xCtrl);
    
    accurary = mean(yPre == yCtrl);
    disp(['accurary of svm: ',num2str(accurary)]);
    [~,projData] = LDA(xCtrl,yCtrl,[0,1],2);
    
    f = figure;
    plot(projData(yPre==0,1),projData(yPre==0,2),'r*');
    hold on
    plot(projData(yPre==1,1),projData(yPre==1,2),'g*');
    legend('unSurvived','Survived');
    title('Result of SVM');
    saveas(f,'result/svm.jpg');