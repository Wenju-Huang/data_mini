function cluster_DBSCAN(xCtrl, yCtrl)
    
    [~,projData] = LDA(xCtrl,yCtrl,[0,1],2);
    [~, score] = pca(xCtrl);
    %xCtrl = normalize( xCtrl);
    
    
    IDX = DBSCAN(xCtrl,6,5);
    yPre = ones(size(xCtrl,1),1);
    yPre(IDX == 0) = 0;
    accurary = mean(yPre == yCtrl);
    disp(['accurary of dbscan: ',num2str(accurary)]);
    
    f = figure;
    plot(projData(yPre==0,1),projData(yPre==0,2),'r*');
    hold on
    plot(projData(yPre==1,1),projData(yPre==1,2),'g*');
    legend('unSurvived','Survived');
    title('Result of DBSCAN - LDA');
    saveas(f,'result/dbscan_lda.jpg');
    
    f = figure;
    plot(score(yPre==0,1),score(yPre==0,2),'r*');
    hold on
    plot(score(yPre==1,1),score(yPre==1,2),'g*');
    legend('unSurvived','Survived');
    title('Result of DBSCAN - PCA');
    saveas(f,'result/dbscan_pca.jpg');