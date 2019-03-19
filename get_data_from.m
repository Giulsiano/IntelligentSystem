function [ data, extra_data ] = get_data_from( file_path, column_idx, extra_data_idx)
%get_data_from  Loads the data from xls files supported by Matlab 
%The function is a wrapper for xlsread that loads data in a cleaner way than
%xlsread does by putting data which aren't stored in column with a header in the cell
%array extra_data. 
%   The function will use xlsread for reading file_path, but this function will
%   remove empty column and rows that xlsread create and will put extra data
%   being found on the spreadsheet into the extra_data cell_array which is
%   explained in the OUTPUT ARGUMENTS section.
%
%% SYNTAX
% [ data, extra_data] = get_data_from(file_path, column_idx, extra_data_idx)
%
%% DESCRIPTION
% get_data_from(file_path, column_idx, extra_data_idx) reads the data from the
% file passed by parameter and cleans the empty columns from the data output of
% xlsread and returns only the data of the column specified by the cellarray of
% strings called column_idx and, if the user wants also them, some extra data
% specified by the string in the cell array extra_data_idx.
% column_idx is a row cell array containing the index of the column. The index
% must be in A1 format, that is the format used by excel for indexing its
% column.
% extra_data_idx is a cell array containing the values being requested by the
% user.
% More info in INPUT ARGUMENTS section.
%
%% INPUT ARGUMENTS
% 
%   * file_path: absolute path to the xls file to be read.
%   * column_idx: cell array of strings which tells the function which are
%   the column to be loaded onto the output. A valid column_idx is like the
%   following:
%                   {'A', 'B', 'C', 'AAF'}
%   column_idx is a mandatory argument. Without it the function can't know which
%   data the user wants the script to return.
%   * extra_data_idx: it is a cell array of strings which allows this function
%   to retrieve data specified by the indeces of the cell array. The indeces are
%   in A1 format, like 'H1'. A valid extra_data_idx can be the following: {'A3',
%   'B134', 'AAE6754'}. It is an optional argument.
%
%% OUTPUT ARGUMENTS
%
%   * data: table which has variable names equal to the header of the column or
%   the row and data in columns.
%   * extra_data: cell array of two columns, the former is used to store the
%   index specified on the variable extra_data. I.e. the user calls
%   [_, ED] = get_data_from(_, {'a1', 'b10'}), then ED = {'a1', value_of_a1; ...
%                                                         'b10', value_of b10; ...
%                                                         ... };
%%  Code

if (exist(file_path, 'file') == 0)
    error('Matlab:ISP:fileNotFound', 'File %s not found', file_path);
end
if (nargin < 3)
    extra_data_idx = {};
end
if (nargin < 2)
    error('Matlab:ISP:argsError', 'column_idx is missing.\n');                           
end

% load file into memory
file_data = xlsread(file_path); 

% find the extra data and store them into the proper output
if (~isempty(extra_data_idx))
    extra_data = cell(size(extra_data_idx, 2), 2);
    
    % translate the A1 strings to row and column indeces
    [ed_row, ed_col] = A1toR1C1(extra_data_idx);
    for i = 1:length(ed_row)
        if (isnan(ed_row(i)))
            % the user wants a column in the extra data
            extra_data{i, 1} = extra_data_idx{i};
            extra_data{i, 2} = file_data(:,ed_col(i));
        else
            extra_data{i, 1} = extra_data_idx{i};
            extra_data{i, 2} = file_data(ed_row(i), ed_col(i));
        end
    end
else
    extra_data = {};
end

% get user requested columns from the data inside the file
[~, data_col] = A1toR1C1(column_idx);
data = file_data(:, data_col);

% remove rows containing only nan. This is for cleaning the exceeding rows.
data(all(isnan(data), 2), :) = [];

end
