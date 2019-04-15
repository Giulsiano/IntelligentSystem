% Giuliano Peraz  <giuliano.peraz@gmail.com>

% Where the database containing the data of the volunteers can be stored
if ~exist('configuration', 'var')
    error('ISP:configurationNotFound', ['The project requires configuration variable to work properly']);
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
    time_data = load_data(configuration.DATA_DIRS, configuration.FILE_PATTERN); 
    
    % Interpolate NaNs numbers and do the normalization required
    cleaned_data = cellfun(@(x) interpolate_nans(x, 3, true), time_data, 'UniformOutput', false); 
    normalized_data = cellfun(@(x) normalize_data(x(:, 1:configuration.SENSOR_NUM), configuration.SENSOR_NUM), ...
                                                    cleaned_data, 'UniformOutput', false);
    
    % Compute frequency transform of sensor data
    [freq_data, freq_domain] = cellfun(@(x) freq_transform(x(:, configuration.SENSOR_NUM), configuration.SAMPLING_TIME), ...
                                                    cleaned_data, 'UniformOutput', false);
    
    % Put all sensors' data together into a single matrix, one matrix for each
    % position
    sensor_data = cell([size(normalized_data, 1) 1]);
    for i = 1:size(normalized_data, 1)
        sensor_data{i} = zip_data(normalized_data(i, :));
    end
    clear normalized_data;
    
    % Save manipulated sensors' data into the database
    fprintf('--> Saving data to %s...\n', configuration.db_path);
    save(configuration.db_path, 'sensor_data', 'freq_data', 'freq_domain');
    
elseif DELETE_DATA == 0
    % Directly load data from the database stored into the output directory
    fprintf('--> Loading data from %s..\n.', configuration.db_path);
    load(configuration.db_path, 'sensor_data', 'freq_data', 'freq_domain');
end
