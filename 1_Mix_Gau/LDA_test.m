function [Y_predict] = LDA_test(X_test, LDAmodel, numofClass)
%
% Testing for LDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_test : test data matrix, each row is a test data point
% numofClass : number of classes 
% LDAmodel : the parameters of LDA classifier which has the follwoing fields
% LDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% LDAmodel.Sigmapooled : D * D  covariance matrix
% LDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i
%
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% Y_predict predicted labels for all the testing data points in X_test


[sam,dim] = size(X_test);
yprob = zeros(sam,numofClass);
mu = LDAmodel.Mu;
pi = LDAmodel.Pi;
sig = LDAmodel.Sigmapooled;  

for i = 1:numofClass
    beta_y = mu(i,:)*inv(sig).';                                   %beta for y == i
    gama_y = -0.5 * mu(i,:)*inv(sig).'*mu(i,:).' + log(pi(i));     %gama for y == i
    yprob(:,i) = X_test*beta_y.' + gama_y;
end
[y_min,y_pred] = max(yprob.');

Y_predict = y_pred.';

end