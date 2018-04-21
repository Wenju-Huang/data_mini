function PrintFrequentItemset(temp_attribute_number,rand_index, data, attribute,L, supports)%打印频繁项集及其相应支持度
f1=fopen('frequent.txt','w');
fprintf(f1,'---------------------Frequent Itemset|Suppoort--------------------\n');

for i =1:size(L,1)
    fprintf(f1,'FI%2d:  ',i);
    items = nonzeros(L(i,:));
    for j=1:size(items,1)
     %  fprintf('%d', L(i, j));
       [m,k]=find(temp_attribute_number == L(i,j),1);
      if(k~=43)       
       fprintf(f1,'%s (%s)', data.textdata{rand_index(m)+1,k},attribute{1,k});
       else
          fprintf(f1,'%d (%s)', data.data(rand_index(m)+1,1),attribute{1,k});
      end
       if(j == size(items,1))
           fprintf(f1,'|support:');
       else
           fprintf(f1,', '); 
       end           
    end
    fprintf(f1,'%d\n', supports(i)); 
end

fprintf(f1,'------------------------------------------------------------------\n\n');
fclose(f1);