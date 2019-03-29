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
arranged_data = arrange_data(sensor_data, chunk_size);

% Compute features for every element of arranged_data
feature_cell = cell([numel(selected_feat) numel(chunk_size)]);
for i = 1:size(feature_cell, 1)
    for j = 1:numel(chunk_size) 
        feature_cell{i, j} = get_aggr_features(arranged_data{j}, selected_feat{i}, chunk_size(j));
    end
end

