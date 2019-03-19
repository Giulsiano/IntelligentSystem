function norm_data = normalize_data(raw_data, cols)
%NORMALIZE_DATA Normalize cols number of columns of raw_data
%   It is a wrapper for normalize to compute the z-score only on cols
%   number of column of the raw_data. It is a generalized normalize()
%   function that computes only the z-score.

norm_columns = normalize(raw_data(:, 1:cols));
norm_data = raw_data;
norm_data(:,1:cols) = norm_columns;
end

