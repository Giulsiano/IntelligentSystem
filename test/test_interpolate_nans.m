function [tests ] = test_interpolate_nans
tests = functiontests(localfunctions);
end

function test_one_central_nan (tc)
test_mat = [1   2 3; 
            NaN 4 5;
            3   6 7];
exp_mat = [1 2 3; 
           2 4 5;  
           3 6 7];

act_mat = interpolate_nans(test_mat, 3, true);
verifyEqual(tc, act_mat, exp_mat);
end

function test_all_nan (tc)
test_mat = [1   NaN 3; 
            NaN 4 5;
            3   6 NaN];
exp_mat = [1 4 3; 
           2 4 5;  
           3 6 5];

act_mat = interpolate_nans(test_mat, 3, true);
verifyEqual(tc, act_mat, exp_mat);
end