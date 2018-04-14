clear;close all;
format long g;
%data=importdata('data/pbp_2017.csv');
data=importdata('data/NFL Play by Play 2009-2017 (v4).csv');
attribute_index=1;
pre_index=1;
%get string cell format variable:total_data
attribute= data.textdata(1,:);

data.textdata(1,:)=[];
total_data=data.textdata;
total_data(:,102)=num2cell(data.data);
%数值属性ATTRIBUTES_Number
ATTRIBUTES_Number = {'TimeUnder'; 'TimeSecs'; 'PlayTimeDiff'; 'yrdln'; 'yrdline100'; 'ydstogo';'ydsnet';'Yards.Gained';'AirYards';...
    'YardsAfterCatch';'FieldGoalDistance';'Penalty.Yards';'PosTeamScore';'DefTeamScore';'ScoreDiff';'AbsScoreDiff';...
    'posteam_timeouts_pre';'HomeTimeouts_Remaining_Pre';'AwayTimeouts_Remaining_Pre';'HomeTimeouts_Remaining_Post';...
    'AwayTimeouts_Remaining_Post';'No_Score_Prob';'Opp_Field_Goal_Prob';'Opp_Safety_Prob';'Opp_Touchdown_Prob';'Field_Goal_Prob';...
    'Safety_Prob';'Touchdown_Prob';'ExPoint_Prob';'TwoPoint_Prob';'ExpPts';'EPA';'airEPA';'yacEPA';'Home_WP_pre';'Away_WP_pre';...
    'Home_WP_post';'Away_WP_post';'Win_Prob';'WPA';'airWPA';'yacWPA'};
%标称属性1：只有字符串标识的类ATTRIBUTES_Nominal_without_Category_Label
ATTRIBUTES_Nominal={' Date';'GameID';'Drive';'qtr';'down';'time';'SideofField';'GoalToGo';'FirstDown';'posteam';'DefensiveTeam';...
    'desc';'PlayAttempted';'sp';'Touchdown';'ExPointResult';'TwoPointConv';'DefTwoPoint';'Safety';'Onsidekick';'PuntResult';...
    'PlayType';'Passer';'Passer_ID';'PassAttempt';'PassOutcome';'PassLength';'QBHit';'PassLocation';'InterceptionThrown';...
    'Interceptor';'Rusher';'Rusher_ID';'RushAttempt';'RunLocation';'RunGap';'Receiver';'Receiver_ID';'Reception';'ReturnResult';...
    'Returner';'BlockingPlayer';'Tackler1';'Tackler2';'FieldGoalResult';'Fumble';'RecFumbTeam';'RecFumbPlayer';'Sack';...
    'Challenge.Replay';'ChalReplayResult';'Accepted.Penalty';'PenalizedTeam';'PenaltyType';'PenalizedPlayer';'HomeTeam';...
    'AwayTeam';'Timeout_Indicator';'Timeout_Team';'Season'};

%total_attribute_number所有的属性均用数字表示，便于后面根据相似性填充缺失的值
if ~exist('processed_permits.mat','file')
    total_attribute_number=NaN*ones(size(total_data));
else
    load('processed_permits.mat');
end
%unique----find(strcmp())----length()
%%
%dealing with Nominal Attribute without category labels
for i=1:length(ATTRIBUTES_Nominal)
%数据处理
    current_attribute_index=find(strcmp(attribute,ATTRIBUTES_Nominal{i}));
    current_attribute=total_data(:,current_attribute_index);
    raw_current_attribute=current_attribute;
    if isa (current_attribute{1},'double')
        current_attribute=cell2mat(current_attribute);
        current_attribute=num2str(current_attribute);
        [row,col]=size(current_attribute);
        current_attribute=mat2cell(current_attribute,ones(row,1),[col]);
    end
    %delete empty
    current_attribute(strcmp(current_attribute,'NA'))=[];
    unique_current_attribute=unique(current_attribute);
    save(['data/Nominal_Label/',ATTRIBUTES_Nominal{i},'.mat'],'unique_current_attribute')
    unique_current_attribute_num=zeros(length(unique_current_attribute),1);
%根据unique_current_attribute标识标称属性的字符串表示以及数字类别的对应
    if length(unique_current_attribute)>1000 || length(unique_current_attribute) ==2
        continue;
    end
    
    for j=1:length(unique_current_attribute)
        unique_current_attribute_num(j)=length(find(strcmp(current_attribute,unique_current_attribute(j))));
        if ~exist('processed_permits.mat','file')
            total_attribute_number(strcmp(raw_current_attribute,unique_current_attribute{j}),current_attribute_index)=j;
        end
        fprintf('Task1:i=%d,j=%d,totali=%d,totalj=%d\n',i,j,length(ATTRIBUTES_Nominal),length(unique_current_attribute))
    end
    total_num=sum(unique_current_attribute_num);
%输出统计量
    if ~exist('result/Nominal/','dir')
        mkdir('result/Nominal/');
    end
    file_name=ATTRIBUTES_Nominal{i};
    fid = fopen(['result/Nominal/',file_name,'.txt'],'w');
    fprintf(fid,'frequence of %s attribute\n',file_name);
    fprintf(fid,'%20s      %20s      %20s\n','Type Description','Count','Percent');
    for j=1:length(unique_current_attribute)
    fprintf(fid,'%20s      %20d      %20.2f%%\n',unique_current_attribute{j},unique_current_attribute_num(j),100*unique_current_attribute_num(j)/total_num);
    end
    fclose(fid);
    fprintf('%d,%s\n',i,file_name);
end

%%
%%
%dealing with numeric attributes
temp_ATTRIBUTES_Number = ATTRIBUTES_Number;
all_NaN_line = [];

if ~exist('result/Number/number_statistics/','dir')
    mkdir('result/Number/number_statistics/');
end
fid = fopen(['result/Number/number_statistics/','Data_abstract_of_attribute.txt'],'w');

fprintf(fid,'%20s    %20s   %20s    %20s    %20s    %20s    %20s\n',...
        'attribute','Maximium','Minimium:','Average', 'Median', 'Quartile', 'Missing data');
for i=1:length(ATTRIBUTES_Number)
    current_attribute_index=find(strcmp(attribute,ATTRIBUTES_Number{i}));
    current_attribute=total_data(:,current_attribute_index);
    current_attribute(strcmp(current_attribute,'NA'))={'nan'};
    current_attribute=str2double(current_attribute);
    if ~exist('processed_permits.mat','file')
        total_attribute_number(:,current_attribute_index)=current_attribute;
    end
    temp_data = current_attribute;
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    if (size(NaN_line, 1)/size(temp_data, 1) >0.1)  %缺失数据超过一半就不统计了
        all_NaN_line = [all_NaN_line;i];
        continue;
    end
    temp_data(NaN_line, :) = [];
    
    disp(['Data abstract of attribute ', ATTRIBUTES_Number{i}, ':']);
    disp(['  Maximium:     ', num2str(max(temp_data))]); % 最大值
    disp(['  Minimium:     ', num2str(min(temp_data))]); % 最小值
    disp(['  Average:      ', num2str(sum(temp_data) / size(temp_data, 1))]); % 平均值
    disp(['  Median:       ', num2str(median(temp_data))]); % 中位数
    disp(['  Quartile:     ', num2str(prctile(temp_data,25)), ', ', num2str(prctile(temp_data,75))]); % 四分位数
    disp(['  Missing data: ', num2str(size(NaN_line, 1))]); % 缺失值个数
    disp(' ');
    file_name=ATTRIBUTES_Number{i};
    fprintf(fid,'statistics of %s attribute\n',file_name);
    fprintf(fid,'%20s:  %.5f         %.5f          %.5f          %.5f, %.5f  %.5f          %.5f\n',...
         file_name, max(temp_data),min(temp_data),mean(temp_data),median(temp_data),prctile(temp_data,25),prctile(temp_data,75),size(NaN_line, 1));
end
fclose(fid);
%%
if ~exist('processed_permits.mat','file')
    total_attribute_number(:,102)=total_data{:,102};
    save('processed_permits','total_attribute_number');
end
temp_ATTRIBUTES_Number(all_NaN_line) = [];
myvisualization('result/Number/number_orignal/',total_attribute_number,attribute,temp_ATTRIBUTES_Number);
% while(1)
%     disp('Choose one way to fill the missing data:');
%     disp('(1 - filled by maxium; 2 - filled by attributes; 3 - filled by similarity; any other key - end program)');
%     method = input('');
%     
for method =1:3
    if method == 1
        data = preprocessing(total_attribute_number, 1);
%             output_file(data, 'building_permits_filled_by_maximium.txt');
        dlmwrite('result/Number/building_permits_filled_by_maximium.txt', data, 'delimiter', '\t','precision', 6,'newline', 'pc')
        %myvisualization(data,attribute);
        visualization('result/Number/number_filledbymaxium/',total_attribute_number,attribute,temp_ATTRIBUTES_Number);
    end
    if method ==2
        data = preprocessing(total_attribute_number, 2);
%             output_file(data, 'building_permits_filled_by_attribute.txt');
        dlmwrite('result/Number/building_permits_filled_by_attribute.txt', data, 'delimiter', '\t','precision', 6,'newline', 'pc')
        %myvisualization(data);
        visualization('result/Number/number_filledbyattributes/',data,attribute,temp_ATTRIBUTES_Number);
    end
    if method ==3
            %trick，本身需要构建198900*198900的相似性矩阵，但是放不下，这里将数据分成300块，根据快内部补充缺失值
        data3=zeros(size(total_attribute_number));
        blocksize=3000;
        for k=1:blocksize
            disp(k)
            block_total_attribute_number=total_attribute_number((size(total_attribute_number,1)/blocksize)*(k-1)+1:(size(total_attribute_number,1)/blocksize)*k,:);
            data3((size(total_attribute_number,1)/blocksize)*(k-1)+1:(size(total_attribute_number,1)/blocksize)*k,:) = preprocessing(block_total_attribute_number, 3);
        end
        dlmwrite('result/Number/building_permits_filled_by_similarity.txt', data3, 'delimiter', '\t','precision', 6,'newline', 'pc')
        %myvisualization(data3);
        visualization('result/Number/number_filledbysimilarity/',data3,attribute,temp_ATTRIBUTES_Number);
    end
end

