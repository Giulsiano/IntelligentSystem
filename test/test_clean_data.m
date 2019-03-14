function [tests ] = test_clean_data
tests = functiontests(localfunctions);
end

function test_no_nan_little_matrix (tc)
test_mat = [1 2 3; 
            4 NaN 5; 
            NaN 6 NaN; 
            8 9 0;
            10 11 NaN];
exp_mat = [1 2 3;
           4 4 5;
           6 6 2.5;
           10 11 0;];

act_mat = clean_data(test_mat, 1);
verifyEqual(tc, act_mat, exp_mat);
end

