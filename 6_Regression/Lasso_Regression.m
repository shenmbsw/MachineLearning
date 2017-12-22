clear
load prostateStnd.mat

num_train = size(Xtrain,1);
num_test = size(Xtest,1);

ln_l = -5:10;
para_holder = zeros(16,8);
train_MSE_holder = zeros(16,1);
test_MSE_holder = zeros(16,1);
i = 1;

for l = ln_l
    lambda = exp(l);
    [b,w] = shs2016f_Lasso(Xtrain,ytrain,lambda,100);
    para_holder(i,:) = w;
    ytrain_pred = b + Xtrain*w;
    ytest_pred = b + Xtest*w;
    
    train_MSE_holder(i) = mean((ytrain - ytrain_pred).^2);
    test_MSE_holder(i) = mean((ytest - ytest_pred).^2);    
    
    i = i+1;
end
close all
figure
subplot(2,1,1)
hold on
for j = 1:8
    plot(ln_l,para_holder(:,j))
end
legend(names{1},names{2},names{3},names{4},names{5},names{6},names{7},names{8},'Location','NorthEastOutside')
xlabel('ln(lambda)')
title('Lasso parameter')
subplot(2,1,2)
plot(ln_l,train_MSE_holder,ln_l,test_MSE_holder);
legend('train MSE','test MSE','Location','NorthEastOutside')
title('Lasso MSE')



i = 1;
for l = ln_l
    lambda = exp(l);
    model = ridge(ytrain,Xtrain,lambda,0);
    b = model(1);
    w = model(2:9);
    para_holder(i,:) = w;
    ytrain_pred = b + Xtrain*w;
    ytest_pred = b + Xtest*w;
    
    train_MSE_holder(i) = mean((ytrain - ytrain_pred).^2);
    test_MSE_holder(i) = mean((ytest - ytest_pred).^2);    
    
    i = i+1;
end
figure
subplot(2,1,1)
hold on
for j = 1:8
    plot(ln_l,para_holder(:,j))
end
legend(names{1},names{2},names{3},names{4},names{5},names{6},names{7},names{8},'Location','NorthEastOutside')
title('Ridge parameter')
xlabel('ln(lambda)')

subplot(2,1,2)
plot(ln_l,train_MSE_holder,ln_l,test_MSE_holder);
legend('train MSE','test MSE','Location','NorthEastOutside')
title('Ridge MSE')


