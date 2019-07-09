% Intelligent System Project
% This script contains the code for creating the input targets for the neuronal network to be
% trained

if exist('conf.m', 'file') == false
    error('ISP:configurationNotFound', ['The project requires conf.m to be in the same '...
                               'directory to work properly']);
end

% Load configuration variables
global configuration;
configuration = load_conf([pwd filesep 'conf.m']);
configuration.out_dir_path = [configuration.PROJECT_DIR filesep configuration.OUTPUT_DIR filesep];
configuration.db_path = [configuration.out_dir_path configuration.DB_FILE_NAME];

% Add to the matlab path the directory needed by this program
old_path = path;
path([configuration.PROJECT_DIR filesep 'features'], path);
path(configuration.PROJECT_DIR, path);

% Create project dirs if they are not present yet
if exist(configuration.out_dir_path, 'dir') == false
    fprintf('Creating %s...', configuration.out_dir_path);
    mkdir(configuration.out_dir_path);
end

%% Data preprocessing
% Create the variable 'normalized_data', store it into the database to save
% time the second time this script is run
% Load the variables stored into the db
storage = who('-file', configuration.db_path);
if ~ismember('normalized_data', storage) || configuration.DELETE_DATA == true
    % Make some computation on data, like normalization, null values removal 
    % and things like that
    fprintf('Preprocessing data...\n');
    data_manipolation;
    
    % Save manipulated sensors' data into the database
    fprintf('--> Saving normalized data to %s...\n', configuration.db_path);
    save(configuration.db_path, 'normalized_data');
    fprintf('\n');
else 
    % Load data from the file
    fprintf('--> Loading normalized data from %s...\n', configuration.db_path);
    load(configuration.db_path, 'normalized_data');
end

% Clear variables that are not useful for the rest of the program
if configuration.DEBUG ~= 1
    clear -except normalized_data old_path configuration
end

%% Features extraction and selection
% Make the computation needed to extract features and select them for the
% neuronal networks to work properly. It uses a lot of varuable
% Check only the presence of X since Y is build with it
if ~ismember('X', storage) || ~ismember('Y', storage)
    fprintf('Feature extraction and selection...\n');
    features;
    fprintf('Saving training set to database...\n');
    save(configuration.db_path, 'X', 'Y');
    fprintf('\n');
else
    fprintf('Loading training set from database...\n');
    load(configuration.db_path, 'X', 'Y');
    fprintf('\n');
end

% Clear variables that are not useful for the rest of the program
if configuration.DEBUG ~= 1
    clear -except X Y old_path chunkslen configuration
end

%% Neuronal Network Training

% Run the neuronal networks, one for each chunk
fprintf('Train %d neuronal networks...\n', max(size(chunkslen)));
nn_train;
fprintf('\n');


%% Define fuzzy system

% Restore original path
path(old_path);