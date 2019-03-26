function m = reshape_normalized_data(data)
%RESHAPE_NORMALIZED_DATA Returns a matrix containing all data from input
    % It expects a cell array of any size which contains matrices having
    % all the same number of cols. This function takes the column at index
    % i and concatenate it with column having the same index of each cell
    % in the data cell array.

% Compute size of m and allocate it
size_m = [0 0];
[~, check_cols] = size(data{1});
num_el = numel(data);
for i = 1:num_el
    [rows, cols] = size(data{i});
    if check_cols ~= cols
        throw(MException('ISP:InputArgumentException', 'Cell array matrix elements don''t have the same size'));
    end
    size_m(1) = size_m(1) + rows;
end
size_m(2) = cols;
m = zeros(size_m);

% Create the matrix which contains all rows from data element together
row_idx_start = 1;
row_idx_end = 0;
for i = 1:num_el
    data_to_add = data{i};
    [rows, ~] = size(data{i});
    row_idx_end = row_idx_end + rows;
    m(row_idx_start:row_idx_end, :) = data_to_add;
    row_idx_start = row_idx_end + 1;
end

end

