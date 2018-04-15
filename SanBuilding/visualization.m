%%
%visualization
function visualization(totaldata,attribute)
%VISUALIZATION ���ӻ����ݡ����dataδ��Ԥ�������NaN�����Ҫ�ȿ����޳�NaN��������ٷֱ���ӻ���
%   ����7�����Ե�ֱ��ͼ��QQͼ����ͼ

figure; % �½�ֱ��ͼ����

ATTRIBUTES_Number = {'Number of Existing Stories'; 'Number of Proposed Stories'; 'Estimated Cost'; 'Revised Cost'; 'Existing Units'; 'Proposed Units'}; 
data=zeros(198900,length(ATTRIBUTES_Number));
for m=1:length(ATTRIBUTES_Number)
    data(:,m)=totaldata(:,find(strcmp(attribute,ATTRIBUTES_Number(m))));
end
for i = 1:length(ATTRIBUTES_Number)
    % ɾ������NaN����
    temp_data = data(:,i);
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line,:) = [];
    % �������Ե�ֱ��ͼ
    subplot(2,3, i);
    histogram(temp_data,50);
    title(ATTRIBUTES_Number(i));
end

figure; % �½�QQͼ���ڣ���Ϊ��֪����ô��subplot�ŵ���ͬfigure��ֻ����дһ��
for i = 1:length(ATTRIBUTES_Number)
    % ɾ������NaN����
    temp_data = data(:,i);
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = [];
    % �������Ե�QQͼ
    subplot(2, 3, i);
    qqplot(temp_data);
    title(ATTRIBUTES_Number(i));
    set(gca, 'xlabel', [], 'ylabel', []); % ȡ����������
end


figure; % �½���ͼ����
for i = 1:length(ATTRIBUTES_Number)
    % ɾ������NaN����
    temp_data = data(:,i);
    [NaN_line, ~] = find(isnan(temp_data) == 1);
    temp_data(NaN_line, :) = [];
    % �������Եĺ�ͼ
    subplot(2, 3, i);
    boxplot(temp_data);
    title(ATTRIBUTES_Number(i));
    set(gca, 'xticklabel', []); % ȡ��������
end

end
