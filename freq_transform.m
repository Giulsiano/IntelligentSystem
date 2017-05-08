function [freq_data] = freq_transform(data)
if isempty(data)
    freq_data = [];
    return;
end

% data for this function is project specific
data_val = data(:, 1:3);
time_val = data(:, 4);
sample_time = mean(diff(time_val));
sig_len = size(data_val, 1);
double_side_spectrum = abs(fft(data_val)/sig_len);
single_side_spectrum = double_side_spectrum(1:sig_len/2 + 1, :);
single_side_spectrum(2:end - 1, :) = 2 * single_side_spectrum(2:end - 1, :);

% add the vector of frequencies
fs = 1/sample_time;
f = fs/2 * linspace(0, 1, sig_len/2 + 1);
freq_data = [single_side_spectrum, f'];
end