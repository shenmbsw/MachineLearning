function [b,w] = shs2016f_Lasso(X,Y,lambda,max_iter)
    [n,dim] = size(X);
    w = zeros(dim,1);
    x = X - repmat(mean(X,1),[n,1]);
    y = Y - repmat(mean(Y),[n,1]);
    for t = 1:max_iter
        for i = 1:dim
            xi = x(:,i);
            a = 2*sum(xi.^2);
            b = y - x*w + xi*w(i);
            c = 2*sum(xi.*b);
            w(i) = shs2016f_SoftThre(c/a,lambda/a);
        end
    end
    b = mean(Y) - mean(X,1)*w;
end

function [ y ] = shs2016f_SoftThre( a,b )
    y = sign(a) * max(0,abs(a)-b);
end

