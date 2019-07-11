% Giuliano Peraz <giuliano.peraz@gmail.com>
global configuration;

% Exit if there is no configuration variable that stores everything needed
% for this program to run
if ~exist('configuration', 'var')
    error('ISP:configurationNotFound', 'The project requires configuration variable to work properly');
end

% Exit if no data variable has been loaded into the workspace
if ~exist('normalized_data', 'var')
    throw(MException('ISP:VariableNotFound', '%s can''t run without normalized_data variable', mfilename));
end

%% Feature extraction
% Define features and the chunk size of sensor data to take in account for
% features

chunkslen = configuration.CHUNKS_TO_ANALYZE;
ncategories = numel(configuration.CATEGORIES);
nchunks = numel(chunkslen);
featfun = {@min; @max; @mean; @std; @skewness; @kurtosis};  % Feature function
nfeatfun = numel(featfun);

% Arrange data in case they are not multiple of any chunk size
fprintf("--> Make data multiple of chunk size\n");
arranged_data = cellfun(@(x) arrange_data(x, chunkslen), normalized_data, 'UniformOutput', false);

% Compute features for every element of arranged_data
fprintf("--> Compute features per each chunk\n");
feature_cell = cell([nfeatfun 1]);
chunkslen_cell = num2cell(chunkslen);
for i = 1:nfeatfun
    feature_cell{i} = cellfun(@(x) cellfun(@(data, chunklen) compute_chunk_features(data, featfun{i}, chunklen), x, chunkslen_cell, ...
                                           'UniformOutput', false), ...
                              arranged_data, 'UniformOutput', false);
end

% Merge matrices of same features together
fprintf("--> Merge feature matrices for each position\n");
merged_feature = cell([nfeatfun ncategories]);
for i = 1:nfeatfun
    for j = 1:ncategories
        % Merge matrix of volunteer's data for each element of the feature_cell's rows
        merged_feature{i, j} = fold(@(a, el) cellfun(@vertcat, a, el, 'UniformOutput', false), feature_cell{i}(j, :));
    end
end

% Create the training set, category labels and feature data
fprintf("--> Building training set\n");
X = cell([nchunks 1]);
Y = cell([nchunks 1]);
for k = 1:nchunks
    X{k} = [];
    for i = 1:nfeatfun
        tempx = [];
        tempy = [];
        merged_row = merged_feature(i, :);
        for j = 1:ncategories
            training_set = merged_row{j}{k};
            nrows = size(training_set, 1);
            label = full(ind2vec(j, ncategories))'; % vector like [1 0 0 0]
            tempx = vertcat(tempx, training_set);
            tempy = vertcat(tempy, repmat(label, nrows, 1));
        end
        X{k} = horzcat(X{k}, tempx);
    end
    Y{k} = tempy;
end

% Permutate the whole test set because it is ordered and can cause problem
% during training
ndataseries = size(normalized_data, 2);
for i = 1:nchunks
    oldtrainingset = [X{i} Y{i}];
    nrows = size(oldtrainingset, 1)/ndataseries/ncategories;
    newtrainingset = [];
    newtargets = [];
    halfrows = nrows/2;
    
    % Create the dataset by putting bottom half rows of X{i} near the top
    % ones and remove Y{i}'s rows consequently (since there are half the
    % values
    startoffset = 0;
    categoryoffset = ndataseries * nrows;
    for k = 0:ndataseries - 1
        for  j = 0:ncategories - 1
            startchunk = j * categoryoffset + 1 + k * nrows;
            endchunk = startchunk + nrows - 1;
            tempx = oldtrainingset(startchunk:endchunk, 1:end - ncategories);
            tempy = oldtrainingset(startchunk:endchunk, end - ncategories + 1:end);

            % double the features
            if mod(halfrows, 1) == 0
                tempx = [tempx(1:halfrows, :), tempx(halfrows + 1:end, :)];
                tempy = tempy(1:halfrows, :);
            else
                tempx = [tempx(1:floor(halfrows) + 1, :), tempx(ceil(halfrows):end, :)];
                tempy = tempy(1:floor(halfrows) + 1, :);
            end
            newtrainingset = vertcat(newtrainingset, [tempx tempy]);
        end
    end
    X{i} = newtrainingset(:, 1:end - ncategories);
    Y{i} = newtrainingset(:, end - ncategories + 1:end);
end

% Do feature selection for each chunk
fprintf("--> Make feature selection\n");
inmodels = cell([nchunks 1]);
histories = cell([nchunks 1]);
parfor i = 1:nchunks
    fprintf("----> Chunk length = %d\n", chunkslen(i));
    [inmodels{i}, histories{i}] = sequentialfs(@fscriterion, X{i}, Y{i});
end

% For each chunk select only the needed feature for training
X = cellfun(@(x, y) x(:, y), X, inmodels, "UniformOutput", false);
