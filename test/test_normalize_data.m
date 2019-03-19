function [tests] = test_normalize_data
tests = functiontests(localfunctions);
end

function test_normalize_1_cols(tc)
test_mat = [1 2 3; 
            4 5 6; 
            7 8 9];
exp_mat =  [-1    2    3;
             0    5    6;
             1    8    9];
act_mat = normalize_data(test_mat, 1);
verifyEqual(tc, act_mat, exp_mat);
end

function test_normalize_2_cols(tc)
test_mat = [1 2 3; 
            4 5 6; 
            7 8 9];
exp_mat =  [-1   -1    3;
             0    0    6;
             1    1    9];
act_mat = normalize_data(test_mat, 2);
verifyEqual(tc, act_mat, exp_mat);
end

function test_normalize_all_cols(tc)
test_mat = [1 2 3; 
            4 5 6; 
            7 8 9];
exp_mat =  [-1    -1    -1;
             0     0     0;
             1     1     1];
act_mat = normalize_data(test_mat, 3);
verifyEqual(tc, act_mat, exp_mat);
end