function output = normalize(data)
    [m,n] = size(data);
    d_mean = mean(data,1);
    d_std = std(data,1);
    output = zeros(m,n);
    for i=1:n
        output(:,i) = (data(:,i) - d_mean(:,i)) / d_std(:,i);
    end
        