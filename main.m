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
global SENSOR_NUM;

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
if exist(db_path, 'file') == false || DELETE_DATA == 1
    fprintf('Loading data from files...');
    time_data = load_data(DATA_DIRS, FILE_PATTERN);
    fprintf(' done\n');
    
    % Interpolate NaNs numbers
    cleaned_data = cellfun(@(x) interpolate_nans(x, 3, true), time_data, 'UniformOutput', false);
    
    
    fprintf('Saving data to %s...', db_path);
    save(db_path, 'time_data');
    fprintf(' done\n');
    
elseif DELETE_DATA == 0
    fprintf('Loading data from %s...', db_path);
    load(db_path, 'time_data');
    fprintf(' done\n');
end

% compute fourier transform of whole sensors data
fprintf('Compute fourier transform...');
freq_data = cellfun(@freq_transform, cleaned_data, 'UniformOutput', false);
fprintf(' done\n');

% compute selected feature for whole patterns
features = {'min', @(x) min(x(:, 1:SENSOR_NUM));
            'max', @(x) max(x(:, 1:SENSOR_NUM));
            'mean', @(x) mean(x(:, 1:SENSOR_NUM));
            'std', @(x) std(x(:, 1:SENSOR_NUM));
            'diff', @sensor_diff;
            };
def_time_feat = compute_features(cleaned_data, features(:, 2));
def_freq_feat = compute_features(freq_data, features(:, 2));

% make figures of each computed features
pattern_name = regexprep(FILE_PATTERN, '\*|\..*', '');
pattern_num = size(FILE_PATTERN);
for i = 1:numel(features(:, 1))
    def_time_feat_figures = plot_feature(def_time_feat(:, :, i));
    
    for j = 1:SENSOR_NUM
        for k = 1:pattern_num
            figure(def_time_feat_figures{k, j});
            fig_title = sprintf('%s sensor %d %s time', features{i, 1}, j, pattern_name{k});
            title(fig_title);
            ylabel(features{i, 1});
        end
    end
end

% restore original path
path(old_path);