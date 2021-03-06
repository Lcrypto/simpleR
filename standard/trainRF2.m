function model = trainRF2(x,y)

% function model = trainRF2(x,y)
%
% Train RFs using MATLAB's fitensemble
%
% This will train as many RFs as output variables are (size(y,2)).
% This may take a long time.
%
% NOTE: this is not random forest at all, unless 'Bag' is used (which is
% not). In the current form, this is AdaBoost for regresion

%% fitensemble: has most but not all TreeBagger functionality
t = RegressionTree.template('MinLeaf',1); % MinLeaf makes the difference!
                                          % NVarToSample, default 1/3 for bagging, all for boosting
% t = RegressionTree.template('MinLeaf',1,'NVarToSample','all');

model = cell(1,size(y,2));
for i = 1:length(model)
%    fprintf('  RF on output var %d\n', i);
    model{i} = fitensemble(x, y(:,i), 'LSBoost', 200, t);
    % Train with bagging instead of boosting. It obtained worse results in my tests.
    %model{i} = fitensemble(x, y(:,i), 'Bag', 100, t, 'type', 'r');
end
