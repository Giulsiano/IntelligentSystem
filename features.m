% Giuliano Peraz <giuliano.peraz@gmail.com>
global CATEGORIES;

% Exit if no data variable has been loaded into the workspace
if (exist('sensor_data', 'var')) ~= 1
    throw(MException('ISP:VariableNotFound', '%s can''t run without normalized_data variable', mfilename));
end

%% Feature extraction
% Define features and the chunk size of sensor data to take in account for
% features
chunk_size = 5:1:12;
categories_num = numel(CATEGORIES);
chunk_num = numel(chunk_size);
selected_aggr_feat = {@min; @max; @mean; @std};
selected_feat_num = numel(selected_aggr_feat);

% Arrange data in case they are not multiple of any chunk size
arranged_data = cell([size(sensor_data, 1) chunk_num]);
for i = 1:size(arranged_data, 1)
    arranged_data(i, :) = arrange_data(sensor_data{i}, chunk_size);
end

% Compute features for every element of arranged_data
feature_cell = cell([categories_num chunk_num selected_feat_num]);
fig_titles = cell(size(feature_cell));
for i = 1:categories_num
    for j = 1:chunk_num 
        for k = 1:selected_feat_num
            feature_cell{i, j, k} = get_aggr_features(arranged_data{i, j}, selected_aggr_feat{k}, chunk_size(j));
        end
    end
end

% Create and store figures if the user wants it to.
if STORE_FIGURES == 1
    for i = 1:categories_num
        for j = 1:chunk_num 
            for k = 1:selected_feat_num
                % Create titles for figures
                fig_title = sprintf('%s %s', CATEGORIES{i}, func2str(selected_aggr_feat{k}));
                fig_subtitle = sprintf('chunk size = %d', chunk_size(j));
                fig_titles{i, j, k} = {fig_title fig_subtitle};
            end
        end
    end
    produce_figures;
end

%% Feature selection. 
% Create labels for categories
labels = zeros(categories_num, categories_num);
labels(1,end) = 1;
for i = 2:categories_num
    labels(i, :) = circshift(labels(i - 1, :), 1);
end

% Merge feature matrices into one and add a label to it
category_features = cell([categories_num chunk_size]);
for i = 1:categories_num 
    for j = 1:chunk_num
        category_features(i, j) = flatten_cell(feature_cell{i, j, :});
    end
end


criterion = @(xtrain, ytrain, xtest, ytest) sum(ytest ~= classify(xtest, xtrain, ytrain));
[inmodel, history] = sequentialfs(criterion, X, Y);
