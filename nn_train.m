% Giuliano Peraz <giuliano.peraz@gmail.com>
%%
% Exit if no data variable has been loaded into the workspace
if (exist('X', 'var') ~= 1) || (exist('Y', 'var') ~= 1) || (exist('chunkslen', 'var') ~= 1)
    throw(MException('ISP:VariableNotFound', '%s can''t run without X, Y and chunkslen variables', mfilename));
end

% Start training the neuronal network
fprintf("--> Training networks for each chunk\n");
nchunks = numel(chunkslen);
ntrain = 30;
nnets = cell([nchunks 1]);
nneurons = 10:30;
parfor i = 1:nchunks
    fprintf("----> chunk len = %d\n", chunkslen(i));
    inputs = X{i}';
    targets = Y{i}';
    previous_net_perf = +Inf;
    for j = nneurons
        % Create a Pattern Recognition Network 
        chunknet = patternnet(j);

        % Set up Division of Data for Training, Validation, Testing 
        chunknet.divideParam.trainRatio = 70/100; 
        chunknet.divideParam.valRatio = 15/100; 
        chunknet.divideParam.testRatio = 15/100;
        chunknet.trainParam.showWindow = 0;
        
        % Train the Network 
        for k = 1:ntrain %ntries
            [chunknet, tr] = train(chunknet, inputs, targets);
            % check performance here, if it is worse than before continue
            % but increment the ntries
        end
        
        % Check if this network is better of the one with less neurons
        outputs = chunknet(inputs);
        errors = gsubtract(outputs, targets);
        performance = perform(chunknet, targets, outputs);
        if performance < previous_net_perf
            net_infos = struct;
            net_infos.net = chunknet;
            net_infos.tr = tr;
            net_infos.outputs = outputs;
            net_infos.targets = targets;
            net_infos.errors = errors;
            net_infos.performance = performance;
            nnets{i} = net_infos;
            previous_net_perf = performance;
        end
    end
end

% %% Plot performance of each network
% for j = 1:numel(nnets)
%     net_infos = nnets{j};
%     figure(j);
%     fig_title = {sprintf("Chunk len = %d", chunkslen(j)), sprintf("# neurons = %d", net_infos.net.layers{1}.size)};
%     
%     % Plot confusion matrix, error histograms, performance and train state
%     % of the net
%     plotconfusion(net_infos.targets, net_infos.outputs);
%     title(fig_title);
%     
% %     title("Performance");
% %     plotperform(net_infos.tr);
% %     
% %     title("Train state");
% %     plottrainstate(net_infos.tr);
% %     
% %     title("Error histogram");
% %     ploterrhist(net_infos.errors);
% end

