function a = remove_array_nan(raw_data, interval_half_len)
% Function which checks if any NaN is present into the data passed by
% parameter, if any Nan has been found then interpolate the data with its
% neighbour in order to have an appropriate value

% Find nans and try to substitute them with the mean of x neigh_num values
data = raw_data;
nan_idx = find(isnan(data));
data_len = numel(data);
for j = 1:numel(nan_idx)
    value_idx = nan_idx(j);
    
    % Compute the mean of [interval_half_len:nan_value[
    switch value_idx
        case 1
            % in this case we have no left mean
            left_idx = value_idx + 1;
            right_idx = value_idx + interval_half_len;
            right_mean = mean(data(left_idx:right_idx));
            left_mean = right_mean;
            
        case data_len
            % in this case we have no right mean
            left_idx = value_idx - interval_half_len;
            right_idx = value_idx - 1;
            left_mean = mean(data(left_idx:right_idx));
            right_mean = left_mean;
            
        otherwise
            % Compute the left mean, that is the interval to the left of
            % the NaN value
            left_idx = value_idx - interval_half_len;
            right_idx = value_idx - 1;
            left_mean = mean(data(left_idx:right_idx));
            
            % Compute the right mean, that is the interval to the right of
            % the NaN value
            left_idx = value_idx + 1;
            right_idx = value_idx + interval_half_len;
            right_mean = mean(data(left_idx:right_idx));
    end
    
    % Substitute the NaN value with the mean of all values around it
    data(value_idx) = mean([left_mean, right_mean]);
end

a = data;

end

