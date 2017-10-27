function [ w ] = logistic_regression(X_train,Y_train, lambda ,alpha, max_iter)
    w =zeros(dim,m);
for t = 1:max_iter
    w = w - alpha * d_loss(X_train,Y_train,w,lambda);
end

end

