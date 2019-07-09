function [freq_data, freq_domain] = freq_transform(data, sampling_time)
% Compute signal length and single side_spectrum of the fft
sig_len = size(data, 1);
double_side_spectrum = abs(fft(data, sig_len)/sig_len);
single_side_spectrum = double_side_spectrum(1:sig_len/2 + 1, :);

% Compute frequency domain and return results to caller
fs = 1/sampling_time;
f = fs/2 * linspace(0, 1, sig_len/2 + 1);
freq_data = single_side_spectrum;
freq_domain = f';
end