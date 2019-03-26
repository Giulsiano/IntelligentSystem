% Intelligent System Project
% This script contains the code for creating the input targets for the neuronal network to be
% trained

if exist('load_conf.m', 'file') == false
    error('ISP:fileNotFound', ['The project requires load_conf.m to be in the same '...
                               'directory to work properly']);
end

% load configuration variables
load_conf;
out_dir_path = [PROJECT_DIR filesep OUTPUT_DIR filesep];
db_path = [out_dir_path DB_FILE_NAME];

% add to the matlab path the directory needed by this program
old_path = path;
path([PROJECT_DIR filesep 'features'], path);
path(PROJECT_DIR, path);

% create project dirs if they are not present yet
if exist(out_dir_path, 'dir') == false
    fprintf('Creating %s\n', out_dir_path);
    mkdir(out_dir_path);
end

% load data of the positions of the volunteers
data_manipolation;

% create the figures in order to have a view of patterns
produce_figures;

% features extraction and selection
features;

% restore original path
path(old_path);