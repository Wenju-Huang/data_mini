function PrintRules(temp_attribute_number,rand_index, data, attribute, rules_left, rules_right,eval)%打印关联规则
f2=fopen('rules.txt','w');
f3=fopen('eval.txt','w');
fprintf(f2,'-------------------------------Rules------------------------------\n');
fprintf(f3,'---------------------evalution of rules--------------------------\n');
fprintf(f3,'support  confident lift \n');
for i =1:size(rules_left,1)
    fprintf(f2,'R%2d:',i);
    items = nonzeros(rules_left(i,:));%打印规则左部
    for j=1:size(items,1) 
        [m,k]=find(temp_attribute_number == rules_left(i,j),1);
        if(k~=43)       
            fprintf(f2,'%s (%s)', data.textdata{rand_index(m)+1,k},attribute{1,k});
        else
            fprintf(f2,'%d (%s)', data.data(rand_index(m)+1,1),attribute{1,k});
        end
       if(j == size(items,1))
           fprintf(f2,' ==> ');
       else
           fprintf(f2,', '); 
       end           
    end
    
    items = nonzeros(rules_right(i,:));%打印规则右部
    for j=1:size(items,1)
       [m,k]=find(temp_attribute_number == rules_right(i,j),1);
        if(k~=43)       
            fprintf(f2,'%s (%s)', data.textdata{rand_index(m)+1,k},attribute{1,k});
        else
            fprintf(f2,'%d (%s)', data.data(rand_index(m)+1,1),attribute{1,k});
        end
       %fprintf('%d', rules_right(i, j));
       if(j == size(items,1))
           %fprintf(f2,'|support: %.3f, confident: %.3f, lift: %.2f', eval(i,1),eval(i,2),eval(i,3));
           fprintf(f2,'\n');
           fprintf(f3,'%.3f  %.3f  %.3f \n',eval(i,1),eval(i,2),eval(i,3));
       else
           fprintf(f2,', '); 
       end           
    end
end

fprintf('------------------------------------------------------------------\n\n');
fclose(f2);