clear;
format long g;
data=importdata('Building_Permits.csv');
attribute_index=1;
pre_index=1;
%get string cell format variable:total_data
attribute_total= data.textdata{1,1};
for j=1:length(attribute_total)
    if attribute_total(j) == ','
        attribute{attribute_index}=attribute_total(pre_index:j-1);
        pre_index=j+1;
        attribute_index=attribute_index+1;
    end
end
attribute{attribute_index}=attribute_total(pre_index:end);
data.textdata(1,:)=[];
total_data=cell(198900,43);
total_data(:,1:42)=data.textdata;
total_data(:,43)=num2cell(data.data);
%��ֵ����ATTRIBUTES_Number
ATTRIBUTES_Number = {'Number of Existing Stories'; 'Number of Proposed Stories'; 'Estimated Cost'; 'Revised Cost'; 'Existing Units'; 'Proposed Units'}; 
%�������1��ֻ���ַ�����ʶ����ATTRIBUTES_Nominal_without_Category_Label
ATTRIBUTES_Nominal_without_Category_Label = {'Permit Number'; 'Permit Creation Date'; 'Block'; 'Lot'; 'Street Number'; 'Street Number Suffix';'Street Name';'Street Suffix';'Unit';'Unit Suffix';'Description';'Current Status';'Current Status Date';'Filed Date';'Issued Date';'Completed Date';'First Construction Document Date';'Structural Notification';'Voluntary Soft-Story Retrofit';'Fire Only Permit';'Permit Expiration Date';'Existing Use';'Proposed Use';'Plansets';'TIDF Compliance';'Site Permit';'Supervisor District';'Neighborhoods - Analysis Boundaries';'Zipcode';'Location';'Record ID'}; 
%�������2���������ַ�����ʶ����ATTRIBUTES_Nominal_Category_Label���������ֱ�ǩATTRIBUTES_Nominal_with_Category_Label
ATTRIBUTES_Nominal_with_Category_Label = {'Permit Type'; 'Existing Construction Type'; 'Proposed Construction Type'}; 
ATTRIBUTES_Nominal_Category_Label = {'Permit Type Definition'; 'Existing Construction Type Description'; 'Proposed Construction Type Description'}; 
%total_attribute_number���е����Ծ������ֱ�ʾ�����ں���������������ȱʧ��ֵ
if ~exist('processed_permits.mat','file')
    total_attribute_number=NaN*ones(198900,43);
else
    load('processed_permits.mat');
end
%unique----find(strcmp())----length()
%%
%dealing with Nominal Attribute without category labels
for i=1:length(ATTRIBUTES_Nominal_without_Category_Label)
%���ݴ���
    current_attribute_index=find(strcmp(attribute,ATTRIBUTES_Nominal_without_Category_Label{i}));
    current_attribute=total_data(:,current_attribute_index);
    raw_current_attribute=current_attribute;
    if isa (current_attribute{1},'double')
        current_attribute=cell2mat(current_attribute);
        current_attribute=num2str(current_attribute);
        [row,col]=size(current_attribute);
        current_attribute=mat2cell(current_attribute,ones(row,1),[col]);
    end
    %delete empty
    current_attribute(strcmp(current_attribute,''))=[];
    unique_current_attribute=unique(current_attribute);
    save(['Nominal2Category_Label\',ATTRIBUTES_Nominal_without_Category_Label{i},'.mat'],'unique_current_attribute')
    unique_current_attribute_num=zeros(length(unique_current_attribute),1);
%����unique_current_attribute��ʶ������Ե��ַ�����ʾ�Լ��������Ķ�Ӧ
    for j=1:length(unique_current_attribute)
        unique_current_attribute_num(j)=length(find(strcmp(current_attribute,unique_current_attribute(j))));
        if ~exist('processed_permits.mat','file')
            total_attribute_number(strcmp(raw_current_attribute,unique_current_attribute{j}),current_attribute_index)=j;
        end
        fprintf('Task1:i=%d,j=%d,totali=%d,totalj=%d\n',i,j,length(ATTRIBUTES_Nominal_without_Category_Label),length(unique_current_attribute))
    end
    total_num=sum(unique_current_attribute_num);

    if length(unique_current_attribute)>1000
        continue;
    end
%���ͳ����
    file_name=ATTRIBUTES_Nominal_without_Category_Label{i};
    fid = fopen(['ATTRIBUTES_Nominal_without_Category_Label\',file_name,'.txt'],'w');
    fprintf(fid,'frequence of %s attribute\n',file_name);
    fprintf(fid,'%20s      %20s      %20s\n','Type Description','Count','Percent');
    for j=1:length(unique_current_attribute)
    fprintf(fid,'%20s      %20d      %20.2f%%\n',unique_current_attribute{j},unique_current_attribute_num(j),100*unique_current_attribute_num(j)/total_num);
    end
    fclose(fid);
    fprintf('%d,%s\n',i,file_name);
end

%%
%dealing with Nominal Attribute with category labels
for i=1:length(ATTRIBUTES_Nominal_with_Category_Label)
    current_attribute_index=find(strcmp(attribute,ATTRIBUTES_Nominal_with_Category_Label{i}));
    current_attribute_index_type_description=find(strcmp(attribute,ATTRIBUTES_Nominal_Category_Label{i}));
    current_attribute=total_data(:,current_attribute_index);
    current_attribute(strcmp(current_attribute,''))={'nan'};
    raw_current_attribute=current_attribute;
    current_attribute_type_description=total_data(:,current_attribute_index_type_description);
    if isa (current_attribute{1},'double')
        current_attribute=cell2mat(current_attribute);
        current_attribute=num2str(current_attribute);
        [row,col]=size(current_attribute);
        current_attribute=mat2cell(current_attribute,ones(row,1),[col]);
    end
    %delete empty
    current_attribute(strcmp(current_attribute,''))=[];
    unique_current_attribute=unique(current_attribute);
    unique_current_attribute_num=zeros(length(unique_current_attribute),1);

    for j=1:length(unique_current_attribute)
        unique_current_attribute_num(j)=length(find(strcmp(current_attribute,unique_current_attribute(j))));
    end
    if ~exist('processed_permits.mat','file')
        total_attribute_number(:,current_attribute_index)=str2double(current_attribute);
        total_attribute_number(:,current_attribute_index_type_description)=str2double(current_attribute);
    end
    if length(unique_current_attribute)>1000
        continue;
    end
    total_num=sum(unique_current_attribute_num);
    file_name=ATTRIBUTES_Nominal_with_Category_Label{i};
    fid = fopen(['ATTRIBUTES_Nominal_with_Category_Label\',file_name,'.txt'],'w');
    fprintf(fid,'frequence of %s attribute\n',file_name);
    fprintf(fid,'%10s      %40s      %10s      %10s\n','Value','Type Description','Count','Percent');
    for j=1:length(unique_current_attribute)
       index=find(strcmp(raw_current_attribute,unique_current_attribute{j}));
      current_typedefine=current_attribute_type_description{index(1)};
      fprintf(fid,'%10s      %40s      %10d      %10.2f%%\n',unique_current_attribute{j},current_typedefine,unique_current_attribute_num(j),100*unique_current_attribute_num(j)/total_num);
    end
    fclose(fid);
    fprintf('%d,%s\n',i,file_name);
end
%%
%dealing with numeric attributes
%%
%dealing with numeric attributes
for i=1:length(ATTRIBUTES_Number)
    current_attribute_index=find(strcmp(attribute,ATTRIBUTES_Number{i}));
    current_attribute=total_data(:,current_attribute_index);
    current_attribute(strcmp(current_attribute,''))={'nan'};
    current_attribute=str2double(current_attribute);
    if ~exist('processed_permits.mat','file')
        total_attribute_number(:,current_attribute_index)=current_attribute;
    end
    temp_data = current_attribute;
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = [];
    disp(['Data abstract of attribute ', ATTRIBUTES_Number{i}, ':']);
    disp(['  Maximium:     ', num2str(max(temp_data))]); % ���ֵ
    disp(['  Minimium:     ', num2str(min(temp_data))]); % ��Сֵ
    disp(['  Average:      ', num2str(sum(temp_data) / size(temp_data, 1))]); % ƽ��ֵ
    disp(['  Median:       ', num2str(median(temp_data))]); % ��λ��
    disp(['  Quartile:     ', num2str(prctile(temp_data,25)), ', ', num2str(prctile(temp_data,75))]); % �ķ�λ��
    disp(['  Missing data: ', num2str(size(NaN_line, 1))]); % ȱʧֵ����
    disp(' ');
end
%%
if ~exist('processed_permits.mat','file')
    total_attribute_number(:,43)=total_data{:,43};
    save('processed_permits','total_attribute_number');
end
myvisualization(total_attribute_number,attribute);
while(1)
    disp('Choose one way to fill the missing data:');
    disp('(1 - filled by maxium; 2 - filled by attributes; 3 - filled by similarity; any other key - end program)');
    method = input('');
    
    switch(method)
        case 1
            data = mypreprocessing(total_attribute_number, 1);
%             output_file(data, 'building_permits_filled_by_maximium.txt');
            dlmwrite('building_permits_filled_by_maximium.txt', data, 'delimiter', '\t','precision', 6,'newline', 'pc')
            myvisualization(data,attribute);
        case 2
            data = mypreprocessing(total_attribute_number, 2);
%             output_file(data, 'building_permits_filled_by_attribute.txt');
            dlmwrite('building_permits_filled_by_attribute.txt', data, 'delimiter', '\t','precision', 6,'newline', 'pc')
            myvisualization(data);
        case 3
            %trick��������Ҫ����198900*198900�������Ծ��󣬵��ǷŲ��£����ｫ���ݷֳ�300�飬���ݿ��ڲ�����ȱʧֵ
            data3=zeros(198900,43);
            blocksize=300;
            for k=1:blocksize
                disp(k)
                block_total_attribute_number=total_attribute_number((198900/blocksize)*(k-1)+1:(198900/blocksize)*k,:);
                data3((198900/blocksize)*(k-1)+1:(198900/blocksize)*k,:) = mypreprocessing(block_total_attribute_number, 3);
            end
            dlmwrite('building_permits_filled_by_similarity.txt', data3, 'delimiter', '\t','precision', 6,'newline', 'pc')
            myvisualization(data3);
        otherwise
            break;
    end
end

