% Intelligent System Project

% load configuration variables
if exist('load_conf.m', 'file') == false
    error('ISP:fileNotFound', ['The project requires load_conf.m to be in the same '...
                               'directory to work properly']);
end
load_conf;

% add to the matlab path the directory of this file
old_path = path;
path(PROJECT_DIR, path);

% load data of the positions of the volunteer
data = load_data(DATA_DIRS, FILE_PATTERN);
features = compute_features(data);

% restore original path
path(old_path);