function [Y_predict] = QDA_test(X_test, QDAmodel, numofClass)
%
% Testing for QDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_test : test data matrix, each row is a test data point
% numofClass : number of classes 
% QDAmodel: the parameters of QDA classifier which has the following fields
% QDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% QDAmodel.Sigma : D * D * numofClass array, Sigma(:,:,i) = covariance
% matrix of class i
% QDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i
% 
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% Y_predict predicted labels for all the testing data points in X_test

[sam,dim] = size(X_test);
yprob = zeros(sam,numofClass);
mu = QDAmodel.Mu;
pi = QDAmodel.Pi;
sig = QDAmodel.Sigma;

for i = 1:numofClass
    class_subt = X_test - repmat(mu(i,:),sam,1);
    for j = 1:sam
        quad = 0.5 * class_subt(j,:) * inv(sig(:,:,i)) * class_subt(j,:).';
        scalar = 0.5 * log(det(sig(:,:,i))) - log(pi(i));
        yprob(j,i) = quad + scalar;
    end
end
[y_min,y_pred] = min(yprob.');
Y_predict = y_pred.';
end
