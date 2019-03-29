% Giuliano Peraz <giuliano.peraz@gmail.com>
% Make figures of the data and store it if the user wants to

% Exit if there is no variable used to make figures
if (exist('feature_cell', 'var')) ~= 1
    throw(MException('ISP:VariableNotFound', '%s can''t run without feature_cell variable', mfilename));
end

% Create figure directory if it is not present yet
if exist(FIG_PATH, 'dir') == false
    fprintf('Creating %s\n', FIG_PATH);
    mkdir(FIG_PATH);
end

for i = 1:numel(feature_cell)
    figure(i);
    if ~exist('fig_titles', 'var')
        fig_title = sprintf('Figure %d', i);
    else
        fig_title = fig_titles{i};
    end
    bar(feature_cell{i});
    title(fig_title);
end
