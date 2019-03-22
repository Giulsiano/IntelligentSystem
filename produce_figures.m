% Giuliano Peraz <giuliano.peraz@gmail.com>
% Make figures of the data and store it if the user wants to

% Exit if no data variable has been loaded into the workspace
if exist('normalized_data', 'var') ~= 1
    throw(MException('ISP:VariableNotFound', '%s can''t run without normalized_data variable', mfilename));
end

% divide the data into chunks
chunk_size = 5;
