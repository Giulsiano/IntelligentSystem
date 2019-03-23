function [tests ] = test_arrange_data
tests = functiontests(localfunctions);
end

function test_output_size(tc)
test_data = [1 2 3;
             4 5 6;
             7 8 9;
             1 2 3;
             4 5 6;
             7 8 9
             ];
test_chunk_size = [3 4 5];
exp_size = [1 numel(test_chunk_size)];
act_size = size(arrange_data(test_data, test_chunk_size));
verifyEqual(tc, act_size, exp_size);
end

function test_chunk_scalar_value(tc)
test_data = [1 2 3;
             4 5 6;
             7 8 9;
             1 2 3;
             ];
test_chunk_size = 3;
exp_size = [1 1];
act_size = size(arrange_data(test_data, test_chunk_size));
verifyEqual(tc, act_size, exp_size);
end

function test_chunk_array(tc)
test_data = [1 2 3;
             4 5 6;
             7 8 9;
             1 2 3;
             ];
test_chunk_size = [1 2 3];
exp_a_size = [1 3];
exp_a_element_sizes = [4 3; 4 3; 6 3];
act_a = arrange_data(test_data, test_chunk_size);
assert(isequal(size(act_a), exp_a_size));
for i = 1:3
    act_size = size(act_a{1, i});
    verifyEqual(tc, act_size, exp_a_element_sizes(i,:));
end

end
