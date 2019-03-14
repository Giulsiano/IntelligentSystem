function cleaned_data = clean_data (raw_data, neigh_num)
% Function which checks if any NaN is present into the data passed by
% parameter, if any Nan has been found then interpolate the data with its
% neighbour in order to have an appropriate value
idx = find(isnan(raw_data));
point_num = neigh_num;


end