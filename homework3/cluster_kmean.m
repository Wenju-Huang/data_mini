function cluster_kmean(xCtrl, yCtrl)

    [~,projData] = LDA(xCtrl,yCtrl,[0,1],2);
    [~, score] = pca(xCtrl);
    %xCtrl = normalize( xCtrl);
    [yPre,~]=kmeans(xCtrl,2);
    yPre = yPre -1;
    accurary = mean(yPre == yCtrl);
    disp(['accurary of kmean: ',num2str(accurary)]);
    f = figure;
    plot(projData(yPre==0,1),projData(yPre==0,2),'r*');
    hold on
    plot(projData(yPre==1,1),projData(yPre==1,2),'g*');
    legend('unSurvived','Survived');
    title('Result of kmean - LDA');
    saveas(f,'result/kmean_lda.jpg');
    
    f = figure;
    plot(score(yPre==0,1),score(yPre==0,2),'r*');
    hold on
    plot(score(yPre==1,1),score(yPre==1,2),'g*');
    legend('unSurvived','Survived');
    title('Result of kmean - PCV');
    saveas(f,'result/kmean_pca.jpg');