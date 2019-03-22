% Giuliano Peraz <giuliano.peraz@gmail.com>

% Exit if no data variable has been loaded into the workspace
if (exist('normalized_data', 'var')) ~= 1
    throw(MException('ISP:VariableNotFound', '%s can''t run without normalized_data variable', mfilename));
end

% Put all sensors' data together into a single matrix
sensor_data = reshape_normalized_data(normalize_data);

