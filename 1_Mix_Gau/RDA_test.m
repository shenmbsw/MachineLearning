function [Y_predict] = RDA_test(X_test, RDAmodel, numofClass)
%
% Testing for RDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_test : test data matrix, each row is a test data point
% numofClass : number of classes 
% RDAmodel : the parameters of RDA classifier which has the following fields
% RDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% RDAmodel.Sigmapooled : D * D  covariance matrix 
% RDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i
%
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% Y_predict predicted labels for all the testing data points in X_test


[sam,dim] = size(X_test);
yprob = zeros(sam,numofClass);
mu = RDAmodel.Mu;
pi = RDAmodel.Pi;
sig = RDAmodel.Sigmapooled;  
inv_sig = inv(sig).';

for i = 1:numofClass
    beta_y = mu(i,:)*inv_sig;                                   %beta for y == i
    gama_y = -0.5 * mu(i,:)*inv_sig*mu(i,:).' + log(pi(i));     %gama for y == i
    yprob(:,i) = X_test*beta_y.' + gama_y;
end
[~,y_pred] = max(yprob.');

Y_predict = y_pred.';

end
