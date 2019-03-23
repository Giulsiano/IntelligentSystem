% Giuliano Peraz <giuliano.peraz@gmail.com>

% Exit if no data variable has been loaded into the workspace
if (exist('normalized_data', 'var')) ~= 1
    throw(MException('ISP:VariableNotFound', '%s can''t run without normalized_data variable', mfilename));
end
global SENSOR_NUM;

% Put all sensors' data together into a single matrix
sensor_data = reshape_normalized_data(normalize_data);

% Define features and the chunk size of sensor data to take in account for
% features
chunk_size = [5 6 7 8];
selected_feat = {'min', @(x) min(x(:, 1:SENSOR_NUM));
            'max', @(x) max(x(:, 1:SENSOR_NUM));
            'mean', @(x) mean(x(:, 1:SENSOR_NUM));
            'std', @(x) std(x(:, 1:SENSOR_NUM));
            'diff', @sensor_diff;
            };

% Compute all features 
feats = get_features(sensor_data, chunk_size, selected_feat);

