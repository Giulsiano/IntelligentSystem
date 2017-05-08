function [ smax] = sensor_max( data )
smax = max(data(1:SENSOR:NUM), 'omitnan');

end

