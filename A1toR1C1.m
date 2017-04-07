function [row, col] = A1toR1C1( a1_cell )
%A1toR1C1 Converts A1 notation to R1C1
%   The function accept a string in the famous excel's A1 format that identifies
%   cell coordinates in the excel file and translate it to a R1C1 format by
%   writing on row the row index and in col the column index translated.
%
% Example:
%   idx = A1toR1C1('h1')

%% The A1 format
% A1 means 'column A row 1', that is the format is separated in two part, the
% former is composed only by letters which identify the column and the latter is
% the row number.
% The interesting part being translated is the first. The character which
% defines the name of the column are coefficient of a polynom which uses the
% ascii alphabet instead of numbers, that is 'ABC2' means that:
%               row = 2;
%               column = A*26^2 + B*26^1 + C*26^0;
%
% A, B and C are translated to a number by using the position of the letter
% inside the English alphabet, so A = 1, B = 2, C = 3 and so on and so forth.
% This function get the input, extracts the row number and then applies the
% translation formula written above for computing the column index.

%% INPUT:
% * a1_cell: a string in A1 format, such as 'H1' or 'AZFG300'. It doesn't matter the
% string is capital or lower case but it must not have spaces between
% characters, i.e. a1_cell can be 'A5678' but not 'A 5678' or 'A 567 8'. The user
% can pass also only a string without numbers. The row output parameter will be
% NaN in this case

%% OUTPUT:
% * [row col]: if the input is a string this row and col are two double that
% identifies the data by row and column. If the input is a cell array, row and
% col are two row array which column specifies the R1C1 format for each string
% inside the cell array a1_cell. There could be some NaN values inside row,
% when this happens it means the a1_cell contains some string in A1 format but
% without the row index, that is the couple [row, col] which corresponds to that
% cell of the a1_cell identifies only the column index but not the row index.
% Example:
%   [row, col] = A1toR1C1({'a1', 'b'}); row = [ 1 NaN ] col = [ 1 2 ].
    
% input checking
str_trim = strtrim(a1_cell);
if (isempty(str_trim)),
    error('Matlab:A1toR1C1:input_error', 'input parameter is empty');
end

if (iscell(a1_cell)),
    [row, col] = cellfun(@R1C1from, a1_cell);

elseif (isa(a1_cell, 'char')),
    [row, col] = R1C1from(a1_cell);
    
else
     error('Matlab:A1toR1C1:input_error', 'a1_cell isn''t a cell array or a string');
end

end


function [row, col] = R1C1from( a1_str )
str_trim = upper(strtrim(a1_str));
alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
base = numel(alphabet);
row = str2double(str_trim(regexp(str_trim, '\d')));
col = 0;

% compute the column from A1 format
pol_char_coeff = char(regexp(str_trim, '\D', 'match'));
char_coeff_num = length(pol_char_coeff);
for i = 1:char_coeff_num,
    idx = strfind(alphabet, pol_char_coeff(i));
    col = col + (idx * base ^ (char_coeff_num - i));
end

end
