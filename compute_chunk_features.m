% Giuliano Peraz <giuliano.peraz@gmail.com>

function feats = compute_chunk_features(data, selected_feature, chunk_size)
%GET_FEATURES Apply selected_feature to data along chunk_size chunks of
%data
%   This function splits the matrix data into chunks of chunk_size length
%   and apply the selected_feature to each chunk returning the result of
%   operation.
[data_rows, data_cols] = size(data);
chunk_num = data_rows / chunk_size;
chunk_start = 1;
feats = zeros([chunk_num data_cols]);
i = 1;
while chunk_start < data_rows
    chunk_end = chunk_start + chunk_size - 1;
    chunk = data(chunk_start:chunk_end, :);
    feats(i, :) = selected_feature(chunk);
    chunk_start = chunk_end + 1;
    i = i + 1;
end

end

