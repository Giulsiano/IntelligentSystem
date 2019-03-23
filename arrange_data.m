function arranged_data = arrange_data(data, chunk_size)
%ARRANGE_DATA Returns a cell array containing arranged data for each chunk
%size
%   It could happen that numel(data) isn't a multiple of the chunk size, so
%   this function makes it by getting random values from data and append
%   them at the end of the data matrix. This function returns a cell array
%   of matrices, one for each chunk size.
rng('shuffle');
chunk_num = numel(chunk_size);
[data_rows, ~] = size(data);
arranged_data = cell([1 chunk_num]);
for i = 1:chunk_num
    more_rows = mod(data_rows, chunk_size(i));
    if more_rows == 0
        arranged_data{1, i} = data;
    else
        rows_to_add = (chunk_size(i) - more_rows);
        temp_data_size = size(data);
        temp_data_size(1) = temp_data_size(1) + rows_to_add;
        temp_data = zeros(temp_data_size);
        temp_data(1:end - rows_to_add, :) = data;
        random_rows = randi([1 data_rows], 1, rows_to_add);
        temp_data(end - rows_to_add + 1:end, :) = data(random_rows, :);
        arranged_data{1, i} = temp_data;
    end

end

end

