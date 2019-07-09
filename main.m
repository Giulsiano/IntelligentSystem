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

% Load data of the positions of the volunteers and make some manipolation
% like normalization and unify data from all sensor into one
fprintf('Manipolate data...\n');
data_manipolation;
fprintf('\n');

% Features extraction and selection
fprintf('Feature extraction and selection...\n');
features;
fprintf('\n');

% Run the neuronal network
fprintf('Train neuronal networks\n');
nn_train;
fprintf('\n');

% Run the fuzzy system

% Restore original path
path(old_path);