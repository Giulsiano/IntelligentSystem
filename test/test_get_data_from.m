function [ tests ] = test_get_data_from
tests = functiontests(localfunctions);
end

function setup(testCase)
testCase.TestData.test_path = {'test/Measurements_10_volunteers/Volunteer 5/V5 dorsiflexion.xlsx';
                               'test/Measurements_10_volunteers/Volunteer 4/V4 dorsiflexion.xlsx'};
testCase.TestData.test_col = {'a'; 'B'; 'c'; 'e'};
testCase.TestData.test_ext_data = {'H1'; 'D'; 'F'};
testCase.TestData.test_size_ext_data = [3 2];
testCase.TestData.test_size_data = [2159 4;
                                    2170 4];
end

function test_size(testCase)
[data, extra_data] = get_data_from(testCase.TestData.test_path{1}, ...
                                   testCase.TestData.test_col, ...
                                   testCase.TestData.test_ext_data);
verifyEqual(testCase, size(extra_data), testCase.TestData.test_size_ext_data);
verifyEqual(testCase, size(data), testCase.TestData.test_size_data(1, :));
[data, extra_data] = get_data_from(testCase.TestData.test_path{2}, ...
                                   testCase.TestData.test_col, ...
                                   testCase.TestData.test_ext_data);
verifyEqual(testCase, size(extra_data), testCase.TestData.test_size_ext_data);
verifyEqual(testCase, size(data), testCase.TestData.test_size_data(2, :));
end

function test_transpose(testCase)
[data, extra_data] = get_data_from(testCase.TestData.test_path{1}, ...
                                   (testCase.TestData.test_col)', ...
                                   (testCase.TestData.test_ext_data)');
verifyEqual(testCase, size(extra_data), testCase.TestData.test_size_ext_data);
verifyEqual(testCase, size(data), testCase.TestData.test_size_data(1, :));
[data, extra_data] = get_data_from(testCase.TestData.test_path{2}, ...
                                   (testCase.TestData.test_col)', ...
                                   (testCase.TestData.test_ext_data)');
verifyEqual(testCase, size(extra_data), testCase.TestData.test_size_ext_data);
verifyEqual(testCase, size(data), testCase.TestData.test_size_data(2, :));
end