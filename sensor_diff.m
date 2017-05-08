function [ sd ] = sensor_diff (data)
% compute diff along the column direction
data_diff = diff(data(:, 1:end-1), [], 1);
if isempty(data_diff)
    sd = [];
else
    sd = [data_diff data(1:end - 1, end)];
end
end

