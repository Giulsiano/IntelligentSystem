% Intelligent System Project
% This script contains the code for creating the input targets for the neuronal network to be
% trained

if exist('conf.m', 'file') == false
    error('ISP:configurationNotFound', ['The project requires conf.m to be in the same '...
                               'directory to work properly']);
end

% load configuration variables
global configuration;
configuration = load_conf([pwd filesep 'conf.m']);
configuration.out_dir_path = [configuration.PROJECT_DIR filesep configuration.OUTPUT_DIR filesep];
configuration.db_path = [configuration.out_dir_path configuration.DB_FILE_NAME];

% add to the matlab path the directory needed by this program
old_path = path;
path([configuration.PROJECT_DIR filesep 'features'], path);
path(configuration.PROJECT_DIR, path);

% create project dirs if they are not present yet
if exist(configuration.out_dir_path, 'dir') == false
    fprintf('Creating %s...', configuration.out_dir_path);
    mkdir(configuration.out_dir_path);
end

% load data of the positions of the volunteers
data_manipolation;

% create the figures in order to have a view of patterns
produce_figures;

% features extraction and selection
features;

% restore original path
path(old_path);