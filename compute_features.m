function [ features ] = compute_features(data, feat_func)
%compute_features Applies each function of feat_func to data input
%   The function gets in input a cell array of function handles and apply each function to the data
%   input parameters. It will return a cell array containing the results of each applied function.
%   feat_func is an optional argument, if it is not passed by the user then this function will apply
%   the following default functions to the data set:
%
%   *   min;
%   *   max;
%   *   mean;
%   *   std;
%   *   diff;
%
%   Results are ordered by the number of the function, that is, supposing default feature has been
%   computed, the first result is the min, the second is the max and so on and so forth.
% set computing default features for the data set given

if nargin < 2
    feat_func = {@min, @max, @mean, @std, @diff};
end

features = cell(size(data));

for i = 1:numel(feat_func)
    features(:, :, i) = cellfun(@(x) feat_func{i}(x), ...
                                data, ...
                                'UniformOutput', false, ...
                                'ErrorHandler', @error_h);
end

end

function result = error_h (S, varargin)
   warning(S.identifier, S.message);
   result = [];
end