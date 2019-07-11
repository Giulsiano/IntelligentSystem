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
    save(configuration.db_path, 'normalized_data', '-append');
    fprintf('\n');
else 
    % Load data from the file
    fprintf('Find normalized data in %s...\n', configuration.db_path);
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
if ~ismember('X', storage) || ~ismember('Y', storage) || configuration.RUN_SEQUENTIALFS == 1
    fprintf('Feature extraction and selection...\n');
    features;
    fprintf('Saving training set to database...\n');
    save(configuration.db_path, 'X', 'Y', '-append');   % Overwrite existing variables
    fprintf('\n');
else
    fprintf('Loading training set from database...\n');
    load(configuration.db_path, 'X', 'Y');
    chunkslen = configuration.CHUNKS_TO_ANALYZE;
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

%% Fuzzy System training and testing
% Take the chunk with the best neuronal network
chosen_chunk = 0;
previous_best_perf = +Inf;
for i = 1:numel(chunkslen)
    if nnets{i}.performance < previous_best_perf
        chosen_chunk = i;
        previous_best_perf = nnets{i}.performance;
    end
end

% Create the training set from X and Y for plotting features and choose the rules
fuzzyx = X{chosen_chunk};
fuzzyy = Y{chosen_chunk};
tempx = [];
tempy = [];
nfeatures = size(fuzzyx, 2);
features_plot = cell(nfeatures, 1);
cellfun(@(x) [], features_plot, 'UniformOutput', false);
ncategories = numel(configuration.CATEGORIES);
for i = 1:ncategories
    indeces = fuzzyy(:, i) == 1;      
    for j = 1:nfeatures
        features_plot{j} = horzcat(features_plot{j}, fuzzyx(indeces, j));
    end
   
    tempx = vertcat(tempx, fuzzyx(indeces, :));
    tempy = vertcat(tempy, fuzzyy(indeces, :));
end

fuzzyx = tempx;
fuzzyy = tempy;

% Plot each feature to choose the ones we need for fuzzy systems to be
% trained
%fignum = get(gcf, 'Number');
for i = 1:nfeatures
    figure(i);
    bar(sort(features_plot{i})');
    title(sprintf("feature %d", i));
    xticklabels(configuration.CATEGORIES);
    yline(max(max(features_plot{i})));
    yline(min(min(features_plot{i})));
end

% Restore original path
path(old_path);