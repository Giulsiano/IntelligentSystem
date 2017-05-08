function [ peaks ] = find_peaks(x, y)
%find_peaks Find the picks of the function y = f(x)
%   y is an array of the same size of x. Peaks are a matrix nx2 where n is the
%   number of the peaks, the first column is the value of that peak while the
%   second is the x value which corresponds to the peak.
if (size(y) == 1),
    peaks = [y x];
    return;
end
len_y = length(y);
peaks = zeros(size([y x]));
j = 1;
for i = 1:len_y,
    try
        prev_y = y(i - 1);
    catch
        prev_y = y(1);
    end
    try
        next_y = y(i + 1);
    catch
        next_y = y(end);
    end
    if (y(i) > prev_y && y(i) > next_y),
        peaks(j, 1) = y(i);
        peaks(j, 2) = x(i);
        j = j + 1;
    end
end

peaks(~any(peaks, 2), :) = [];

end