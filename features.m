% Giuliano Peraz <giuliano.peraz@gmail.com>

% Exit if no data variable has been loaded into the workspace
if (exist('normalized_data', 'var')) ~= 1
    throw(MException('ISP:VariableNotFound', '%s can''t run without normalized_data variable', mfilename));
end

% Put all sensors' data together into a single matrix per position
sensor_data = cell([size(normalized_data, 1) 1]);
for i = 1:size(normalized_data, 1)
    sensor_data{i} = zip_data(normalized_data{i, :});
end

% Define features and the chunk size of sensor data to take in account for
% features
chunk_size = [5 6 7 8];
selected_feat = {@min; @max; @mean; @std};

% Arrange data in case they are not multiple of any chunk size
arranged_data = arrange_data(sensor_data, chunk_size);

% Compute features for every element of arranged_data
feature_cell = cell([numel(selected_feat) numel(chunk_size)]);
for i = 1:size(feature_cell, 1)
    for j = 1:numel(chunk_size) 
        feature_cell{i, j} = get_aggr_features(arranged_data{j}, selected_feat{i}, chunk_size(j));
    end
end

