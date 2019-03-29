function [ tests ] = test_flatten_cell
tests = functiontests(localfunctions);
end

function test_different_matrices(tc)
test_cell = {[1 2; 3 4; 5 6] [7 8; 9 10]};
exp_err = 'ISP:ArgumentException';
verifyError(tc, @() flatten_cell(test_cell), exp_err);
end

function test_merge_2_matrices(tc)
test_cell = {[1 2; 3 4; 5 6] [7 8; 9 10; 11 12]};
exp_m = [1 2 7 8; 3 4 9 10; 5 6 11 12];
act_m = flatten_cell(test_cell);
verifyEqual(tc, act_m, exp_m);
end

function test_merge_4_matrices(tc)
test_cell = {[1 2; 3 4; 5 6] [7 8; 9 10; 11 12] ...
             [1 2; 3 4; 5 6] [7 8; 9 10; 11 12]};
exp_m = [1     2     7     8     1     2     7     8;
     3     4     9    10     3     4     9    10;
     5     6    11    12     5     6    11    12];
act_m = flatten_cell(test_cell);
verifyEqual(tc, act_m, exp_m);
end