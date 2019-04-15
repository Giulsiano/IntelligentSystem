% Giuliano Peraz <giuliano.peraz@gmail.com>
global configuration;

% Exit if no data variable has been loaded into the workspace
if (exist('sensor_data', 'var')) ~= 1
    throw(MException('ISP:VariableNotFound', '%s can''t run without normalized_data variable', mfilename));
end

%% Feature extraction
% Define features and the chunk size of sensor data to take in account for
% features

chunks = 1:12;
ncategories = numel(configuration.CATEGORIES);
nchunk = numel(chunks);
aggr_feat = {@min; @max; @mean; @std; @skewness; @kurtosis};
nselected_feat = numel(aggr_feat);

% % Put all data from all the sensor into one matrix per position
% sensor_data = cell([size(normalized_data, 1) 1]);
% for i = 1:size(normalized_data, 1)
%     sensor_data{i} = zip_data(normalized_data(i, :));
% end

% Arrange data in case they are not multiple of any chunk size
arranged_data = cell([size(sensor_data, 1) nchunk]);
for i = 1:size(arranged_data, 1)
    arranged_data(i, :) = arrange_data(sensor_data{i}, chunks);
end

% Compute features for every element of arranged_data
feature_cell = cell([ncategories nchunk nselected_feat]);
fig_titles = cell(size(feature_cell));
for i = 1:ncategories
    for j = 1:nchunk 
        for k = 1:nselected_feat
            feature_cell{i, j, k} = get_aggr_features(arranged_data{i, j}, aggr_feat{k}, chunks(j));
        end
    end
end

%% Feature selection. 
% Create numerical labels for categories
labels = zeros([ncategories 1]);
for i = 1:ncategories
    labels(i) = i;
end

% Merge feature matrices into one and add a label to it to create X for
% sequentialfs function for each chunk size
category_features = cell([ncategories nchunk]);
for i = 1:ncategories
    for j = 1:nchunk
        category_features{i, j} = flatten_cell(feature_cell(i, j, :));
    end
end

% Create a category matrix for each chunk size
output_category = cell([ncategories nchunk]);
labels_len = numel(configuration.CATEGORIES);
for i = 1:ncategories
    for j = 1:nchunk
        nrows = size(category_features{i, j}, 1);
        category_array = zeros([nrows 1]);
        category_array(:) = labels(i);
        output_category{i, j} = category_array;
    end
end


criterion = @(xtrain, ytrain, xtest, ytest) sum(ytest ~= classify(xtest, xtrain, ytrain));
[inmodel, history] = sequentialfs(criterion, X, Y);
