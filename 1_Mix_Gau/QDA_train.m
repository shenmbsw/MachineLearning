function [QDAmodel]= QDA_train(X_train, Y_train, numofClass)
%
% Training QDA
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
% QDAmodel : the parameters of QDA classifier which has the following fields
% QDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% QDAmodel.Sigma : D * D * numofClass array, Sigma(:,:,i) = covariance matrix of class i
% QDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i


    [sam,dim] = size(X_train);
    y_onehot = zeros(numofClass,sam);
    
    Xgroup = {};
    
    for i = 1:numofClass
        rows = Y_train == i;
        X_y = X_train(rows,:);
        Xgroup{end+1} = X_y;
    end
    
    mu = zeros(numofClass,dim);
    pi = zeros(numofClass,1);
    sig = zeros(dim,dim,numofClass);

    for i = 1:numofClass
        X_y = Xgroup{1,i}.';
        ny = size(X_y,2);
        mu(i,:) = (X_y * ones(ny,1))/ ny;
        pi(i) = ny/sam;
        X_y_bar = X_y * (eye(ny) - 1/ny * ones(ny,1) * ones(1,ny));
        sig(:,:,i) = 1/(ny-1) * X_y_bar * X_y_bar.';
    end
       
    QDAmodel.Mu = mu;
    QDAmodel.Pi = pi;
    QDAmodel.Sigma=sig;
end
