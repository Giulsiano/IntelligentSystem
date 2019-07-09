function e = fscriterion(xtrain, ytrain, xtest, ytest)
%CRITERION Returns the error given by a classifier as a scalar

inputs = xtrain'; % It expects data on rows
targets = ytrain';

% DEBUG make this number not hardcoded
net = patternnet(10);

% Make divisions for training the network
net.divideParam.trainRatio = 70/100; 
net.divideParam.valRatio = 15/100;  
net.divideParam.testRatio = 15/100;
net.trainParam.showWindow = 0;

% Train the network
[trainedNet, ~] = train(net, inputs, targets);

% Compute error using xtest and ytest as input and validation targets
outputs = trainedNet(xtest');
output_class = vec2ind(outputs);
target_class = vec2ind(ytest');

e = sum(output_class ~= target_class);
end

