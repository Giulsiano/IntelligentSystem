function interpolated_data = interpolate_nans(m, interval_len, by_cols)
%INTERPOLATE_NANS interpolate ev

if by_cols == false
    data = m';
else
    data = m;
end

if mod(interval_len, 2) == 0
    throw(MException('ISP:InvalidArgument', 'interval_len must7 be odd'));
end

[r, c] = size(data);
interpolated_data = zeros(r, c);
half_interval_len = (interval_len - 1) / 2;
for i = 1:c
    interpolated_data(:, i) = remove_array_nan(data(:, i), half_interval_len);
end

end

