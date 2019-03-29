function m = flatten_cell(cell)
%FLATTEN_CELL Return a matrix containing all the data into cell
%concatenated by column
%   It takes the cell argument and try to put every matrix inside its
%   element into the output argument n
nel = numel(cell);
nrows = size(cell{1}, 1);
ncols = 0;
for i = 1:nel
    [temp_rows, temp_cols] = size(cell{i});
    check_rows = nrows == temp_rows;
    if ~check_rows
        throw(MException('ISP:ArgumentException', 'cell elements must have same numnber of rows'));
    end
    ncols = ncols + temp_cols;
end

m = zeros(nrows, ncols);
col_start = 1;
for i = 1:nel
    col_end = col_start + size(cell{i}, 2) - 1;
    m(:, col_start:col_end) = cell{i};
    col_start = col_end + 1;
end

end

