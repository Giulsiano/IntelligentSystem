% Giuliano Peraz  <giuliano.peraz@gmail.com>

% Where the database containing the data of the volunteers can be stored
if ~exist('configuration', 'var')
    error('ISP:configurationNotFound', 'The project requires configuration variable to work properly');
end

global configuration;

% Create project dirs if they are not present yet
if exist(configuration.out_dir_path, 'dir') == false
    fprintf('--> Creating %s\n', configuration.out_dir_path);
    mkdir(configuration.out_dir_path);
end

% Load the raw data from spreadsheets
if exist(configuration.db_path, 'file') == false || configuration.DELETE_DATA == true
    fprintf('--> Loading data from files...\n');
    loaded_data = load_data(configuration.DATA_DIRS, configuration.FILE_PATTERN); 

    % Make all data matrix to have the same number of rows for each one
    min_sizes = cellfun(@(x) size(x, 1), loaded_data);
    nrows = fold(@(acc, el) min(acc, el), reshape(min_sizes, [], 1));
    truncated_data = cellfun(@(x) x(1:nrows,:), loaded_data, 'UniformOutput', false);
    
    % Interpolate NaNs numbers and do the normalization required
    fprintf('--> Interpolate and normalize data...\n');
    cleaned_data = cellfun(@(x) interpolate_nans(x, 3, true), truncated_data, 'UniformOutput', false); 
    normalized_data = cellfun(@(x) normalize_data(x(:, 1:configuration.SENSOR_NUM), configuration.SENSOR_NUM), ...
                                                    cleaned_data, 'UniformOutput', false);
    % Save manipulated sensors' data into the database
    fprintf('--> Saving data to %s...\n', configuration.db_path);
    save(configuration.db_path, 'normalized_data');
    
elseif configuration.DELETE_DATA == 0
    % Directly load data from the database stored into the output directory
    fprintf('--> Loading data from %s...\n', configuration.db_path);
    load(configuration.db_path, 'normalized_data');
end
