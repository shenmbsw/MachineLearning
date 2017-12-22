function [ ytest ] = KNN( Xtrain,ytrain,Xtest,k)
% This function return the perdict result of KNN


train_num = size(Xtrain,1);
test_num = size(Xtest,1);


ytest = zeros(test_num,1);

for i = 1:test_num
    Xi = Xtest(i,:);
    Eu_dis = sum((repmat(Xi,train_num,1) - Xtrain).^2,2);
    [Eu_sorted, Eu_order] = sort(Eu_dis);
    y_sort = ytrain(Eu_order,:);
    Knn_label = y_sort(1:k);
    
    ytest(i) = mode(Knn_label);
    
end

end

