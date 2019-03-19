function [tests ] = test_remove_array_nan
tests = functiontests(localfunctions);
end

function test_central_nan_1_neigh (tc)
test_mat = [1 ;
            NaN;
            3 ];
exp_mat = [1; 2; 3];

act_mat = remove_array_nan(test_mat, 1);
verifyEqual(tc, act_mat, exp_mat);
end

function test_left_border_nan_1_neigh(tc)
test_mat = [NaN; 2 ; 3];
exp_mat = [2; 2; 3];
act_mat = remove_array_nan(test_mat, 1);
verifyEqual(tc, act_mat, exp_mat);
end


function test_right_border_nan_1_neigh(tc)
test_mat = [1; 2 ; NaN];
exp_mat = [1; 2; 2];
act_mat = remove_array_nan(test_mat, 1);
verifyEqual(tc, act_mat, exp_mat);
end

function test_consecutive_nan_1_neigh(tc)
test_mat = [1; 2 ; NaN];
exp_mat = [1; 2; 2];
act_mat = remove_array_nan(test_mat, 1);
verifyEqual(tc, act_mat, exp_mat);
end