function [ tests ] = test_reshape_normalized_data
tests = functiontests(localfunctions);
end

function test_throw_exception(tc)
test_data = {[1 2 3 4; 
               4 5 6 5; 
               7 8 9 6] 
             [1 2 3; 
               4 5 6; 
               7 8 9]
             [1 2 3; 
               4 5 6; 
               7 8 9]
            };
verifyError(tc, @() reshape_normalized_data(test_data), 'ISP:InputArgumentException');
end

function test_size_m(tc)
test_data = {[1 2 3; 
               4 5 6; 
               7 8 9] 
             [1 2 3; 
               4 5 6; 
               7 8 9]
             [1 2 3; 
               4 5 6; 
               7 8 9]
            };
exp_res = [9 3];
act_res = size(reshape_normalized_data(test_data));
verifyEqual(tc, act_res, exp_res);
end

function test_put_all_together(tc)
test_data = {[1 2 3; 
               4 5 6; 
               7 8 9] 
             [1 2 3; 
               4 5 6; 
               7 8 9] 
             [1 2 3; 
               4 5 6; 
               7 8 9]};
exp_m = [1 2 3; 
         4 5 6; 
         7 8 9; 
         1 2 3; 
         4 5 6; 
         7 8 9;
         1 2 3; 
         4 5 6; 
         7 8 9];
act_m = reshape_normalized_data(test_data);
verifyEqual(tc, act_m, exp_m);
end