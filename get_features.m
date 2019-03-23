% Giuliano Peraz <giuliano.peraz@gmail.com>

function feats = get_features(data, chunk_size, selected_features)
%GET_FEATURES Returns a cell array containing computed features for data
%   Giving the selected features cell array this function is in charge of
%   getting data input (a matrix containing all data the user wants this
%   function to compute the feat for), dividing it by every chunk_size
%   specified and then it will apply every features inside
%   selected_features to the input to produce a cell array organized in
%   this way:
%   { 'feature1 name', matrix of features 1; 
%     'feature2 name', matrix of features 2;
%     ...;
%   }
%%

feats = cell([numel(selected_features) numel(chunk_size)]);

% Arrange data in case they are not multiple of any chunk size
arranged_data = arrange_data(data, chunk_size);

end

