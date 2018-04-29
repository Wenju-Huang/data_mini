function cluster_hierarchical(xCtrl, yCtrl)
    
    [~,projData] = LDA(xCtrl,yCtrl,[0,1],2);
    [~, score] = pca(xCtrl);
    %xCtrl = normalize( xCtrl);
    
    
    dis=pdist(xCtrl(:,[1,2,3]));
    distan=squareform(dis); %distan为距离矩阵
    s=linkage(distan); %产生层次聚类的树结构
    yPre = cluster(s,'maxclust',2);
    yPre = yPre -1;
    
    accurary = mean(yPre == yCtrl);
    sprintf('accurary of svm: %.3f',accurary)
    
    figure,
    plot(projData(yCtrl==0,1),projData(yCtrl==0,2),'r*');
    hold on
    plot(projData(yCtrl==1,1),projData(yCtrl==1,2),'g*');
    legend('unSurvived','Survived');
    title('Visualization of Ground Truth');
    
    figure,
    plot(projData(yPre==0,1),projData(yPre==0,2),'r*');
    hold on
    plot(projData(yPre==1,1),projData(yPre==1,2),'g*');
    legend('unSurvived','Survived');
    title('Result of kmean');
    
    figure,
    plot(score(yPre==0,1),score(yPre==0,2),'r*');
    hold on
    plot(score(yPre==1,1),score(yPre==1,2),'g*');
    legend('unSurvived','Survived');
    title('Result of kmean');
    