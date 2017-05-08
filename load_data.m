function [ data ] = load_data (dirs, pattern)
%load_data Load data from xlsx file in dirs according to pattern
%

% if dirs is a string, put it in a cell array
if isa(dirs, 'char'), 
    dirs = {dirs}; 
end

% create output data structure
dirs_len = numel(dirs);
pattern_len = numel(pattern);
column = {'A', 'B', 'C', 'D'};
data = {};

% load data from files that matches pattern which are located in the directory
for i = 1:pattern_len
    cur_pattern = pattern{i};
    data_idx = 0;
    for j = 1:dirs_len,
        cur_dir = dirs{j};
        if (exist(cur_dir, 'dir') == false),
            fprintf('%s does not exist', cur_dir);
            continue;
        end
        file_list = dir([cur_dir filesep cur_pattern]);
        if (isempty(file_list)),
            fprintf('Pattern %s have found no files in %s\n', cur_pattern, cur_dir);
            continue;
        end
        fl_len = length(file_list);
        for k = 1:fl_len,
            % jump over directories that matches pattern
            if (file_list(k).isdir == true), continue; end
            
            % load the data inside the database
            data_idx = data_idx + 1;
            file_path = [cur_dir, filesep, file_list(k).name];
            [xls_data] = get_data_from(file_path, column);
            data{i, data_idx} = xls_data;
        end
    end
end

end

