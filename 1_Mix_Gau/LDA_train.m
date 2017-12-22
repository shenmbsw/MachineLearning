function [LDAmodel] = LDA_train(X_train, Y_train, numofClass)
%
% Training LDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_train : training data matrix, each row is a training data point
% Y_train : training labels for rows of X_train
% numofClass : number of classes
%
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% LDAmodel : the parameters of LDA classifier which has the following fields
% LDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% LDAmodel.Sigmapooled : D * D  covariance matrix
% LDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i


    [sam,dim] = size(X_train);
    y_onehot = zeros(numofClass,sam);
    for i = 1:numofClass
        rows = Y_train == i;
        y_onehot(i,:) = rows;
    end
    y_onehot*X_train;
    class_acc = sum(y_onehot,2);
    mu = y_onehot*X_train ./ repmat(class_acc,1,dim);
    pi = class_acc / sam;

    sample_mu = zeros(sam,dim);
    for i = 1:sam
        sample_mu(i,:) = mu(Y_train(i),:);
    end    
    
    var_mat = zeros(dim,dim);
    subt = (X_train - sample_mu);
    for i = 1:sam
        var_mat = var_mat + (subt(i,:).' * subt(i,:));
    end
    var_mat = var_mat/(sam-numofClass);

    LDAmodel.Mu = mu;
    LDAmodel.Pi = pi;
    LDAmodel.Sigmapooled = var_mat;

end
