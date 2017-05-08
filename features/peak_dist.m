function [ dist ] = peak_dist (data)
%%peak_dist Compute the peak distances of signals
%   Peak distances are the distances computed on the axis x of the signal y = f(x).
%   dist is a cell array which contains as many cell as the column of y which
%   can be a matrix which each column is a measure of a signal

for i = 1:SENSOR_NUM
    peaks = find_peaks(x, y(:, i));
    dist{i} = diff(peaks(:, 2));
end
end