function [ fig_h ] = plot_feature (feature)
%plot_feature Plot the data contained into the cell array passed to this function
%   Feature is a cell array of which each column represent a pattern. plot_feature makes it possible
%   to create a cell array of figure handles which has the same number of rows of features and a
%   number of column equal to the sensor number.
%%
global SENSOR_NUM;
if isempty(feature)
    fig_h = [];
    return;
end

% features can be vectors or matrices which have different graphs
feat_is_vector = isvector(feature{1});

% number of row of feature cell array
pattern_num = size(feature, 1);

% divides data by pattern and by sensor and plot the result
fig_h = cell(pattern_num, SENSOR_NUM);
for i = 1:pattern_num
    pattern_data = feature(i, :);
    for j = 1:SENSOR_NUM
        % plot the result
        y_data = cellfun(@(x) x(:, j), pattern_data, 'UniformOutput', false);
        fig_h{i, j} = figure('NumberTitle', 'off', ...
                             'Visible', 'off');
        if feat_is_vector == true
            y_data = cell2mat(y_data);
            bar(y_data);
        else
            x_data = cellfun(@(x) x(:, end), pattern_data, 'UniformOutput', false);
            hold on;
            cellfun(@(x, y) plot(x, y), x_data, y_data);
            hold off;
        end
    end
end

end


