% Giuliano Peraz  <giuliano.peraz@gmail.com>
% Load the configuration for this project
load_conf;

% Where the database containing the data of the volunteers can be stored
output_dir_path = [PROJECT_DIR filesep OUTPUT_DIR filesep];
db_path = [output_dir_path DB_FILE_NAME];

% Add to the matlab path the directory needed by this program
old_path = path;
path([PROJECT_DIR filesep 'features'], path);
path(PROJECT_DIR, path);

% Create project dirs if they are not present yet
if exist(output_dir_path, 'dir') == false
    fprintf('Creating %s\n', output_dir_path);
    mkdir(output_dir_path);
end

% Load the raw data from spreadsheets
if exist(db_path, 'file') == false || DELETE_DATA == true
    fprintf('Loading data from files...');
    time_data = load_data(DATA_DIRS, FILE_PATTERN);
    fprintf(' done\n'); 
    
    % Interpolate NaNs numbers and do the normalization required
    cleaned_data = cellfun(@(x) interpolate_nans(x, 3, true), time_data, 'UniformOutput', false); 
    normalized_data = cellfun(@(x) normalize_data(x, SENSOR_NUM), cleaned_data, 'UniformOutput', false);
    
    % Save the cleaned and normalized data into the database
    fprintf('Saving data to %s...', db_path);
    save(db_path, 'normalized_data');
    fprintf(' done\n');
    
elseif DELETE_DATA == 0
    % Directly load from the database stored into the output directory
    fprintf('Loading data from %s...', db_path);
    load(db_path, 'normalized_data');
    fprintf(' done\n');
end


% Restore the old path
path(old_path);