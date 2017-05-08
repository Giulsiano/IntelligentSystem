function [ tests ] = test_sensor_diff
tests = functiontests(localfunctions);
end

function test_correct_output (tc)
data = [ 1 2 3 4; 
         4 5 6 5;
         7 8 9 6;
         ];
exp = [ 3 3 3 4;
        3 3 3 5
        ];
act = sensor_diff(data);
verifyEqual(tc, act, exp, 'AbsTol', 0.1);
end

function test_data_is_not_a_matrix (tc)
data = [1 2 3 4];
exp = [];
act = sensor_diff(data);
verifyEqual(tc, act, exp);

data = 1;
act = sensor_diff(data);
verifyEqual(tc, act, exp);
end

