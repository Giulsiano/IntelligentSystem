function [ sm ] = sensor_min (data)
sm = min(data(:, 1:end - 1), 'omitnan');
end

