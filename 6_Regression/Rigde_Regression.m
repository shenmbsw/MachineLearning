clear
close all
load quad_data

% part 1
figure
subplot(2,1,1)
scatter(xtrain,ytrain)
hold on
degree = [2,6,10,14];
for d = degree
    xtrain_poly = [];
    for i = 1:d
        xtrain_poly = [xtrain_poly,xtrain.^i];
    end
    model1 = ridge(ytrain,xtrain_poly,0,0);

    y_pred = model1(1);
    for i = 1:d
        y_pred = y_pred + model1(i+1)*xtrain_poly(:,i);
    end
    plot(xtrain,y_pred)
end
legend('scatter','degree=2','degree=6','degree=10','degree=14','Location','NorthEastOutside')

degree = 1:14;
for d = 1:14
    xtrain_poly = [];
    xtest_poly = [];
    for i = 1:d
        xtrain_poly = [xtrain_poly,xtrain.^i];
        xtest_poly = [xtest_poly,xtest.^i];
    end
    model2 = ridge(ytrain,xtrain_poly,0,0);

    y_pred = model2(1);
    y_test_pred = model2(1);
    for i = 1:d
        y_pred = y_pred + model2(i+1)*xtrain_poly(:,i);
        y_test_pred = y_test_pred + model2(i+1) * xtest_poly(:,i)
    end
    train_MSE(d) = mean((ytrain - y_pred).^2);
    test_MSE(d) = mean((ytest - y_test_pred).^2);
end
subplot(2,1,2)
plot (degree,train_MSE,degree,test_MSE)
xlabel('degree')
ylabel('MSE')
legend('train MSE','test MSE','Location','NorthEastOutside')


% part 2
clear

load quad_data

xtrain_poly = zeros(21,10);
xtest_poly = zeros(201,10);
for i = 1:10
    xtrain_poly(:,i) = xtrain.^i;
    xtest_poly(:,i) = xtest.^i;
end
lambda = -25:1:5;

j = 1;
train_MSE = zeros(size(lambda));
test_MSE = zeros(size(lambda));
for l = lambda
    el = exp(l)
    model3 = ridge(ytrain,xtrain_poly,el,0);
    y_train_pred = model3(1);
    y_test_pred = model3(1);
    for i = 1:10
        y_train_pred = y_train_pred + model3(i+1) * xtrain_poly(:,i);
        y_test_pred  = y_test_pred  + model3(i+1) * xtest_poly(:,i);
    end
    train_MSE(j) = mean((ytrain - y_train_pred).^2);
    test_MSE(j) = mean((ytest - y_test_pred).^2);
    j = j + 1;
end
figure
subplot(2,1,1)
plot (lambda,train_MSE,lambda,test_MSE)
legend('train MSE','test MSE','Location','NorthEastOutside')
xlabel('ln(lambda)')
ylabel('MSE')
best_l = lambda(find(test_MSE == min(test_MSE)))


model4 = ridge(ytrain,xtrain_poly,best_l,0);
y_pred_best_l = model4(1)
for i = 1:10
    y_pred_best_l = y_pred_best_l + model4(i+1) * xtest_poly(:,i);
end

model5 = ridge(ytrain,xtrain_poly,0,0);
y_pred_zero_l = model5(1)
for i = 1:10
    y_pred_zero_l = y_pred_zero_l + model5(i+1)*xtest_poly(:,i);
end

subplot(2,1,2)
scatter(xtest,ytest,5,'*')
hold on
plot(xtest,y_pred_best_l,xtest,y_pred_zero_l)
legend('test data','best lambda','zero lambda','Location','NorthEastOutside')


% part 3
xtrain_poly = [];
xtest_poly = [];
for i = 1:4
    xtrain_poly = [xtrain_poly,xtrain.^i];
    xtest_poly = [xtest_poly,xtest.^i];
end

lambda = -25:1:5;
j = 1;
B_all = zeros(5,31)
for l = lambda
    el = exp(l)
    model6 = ridge(ytrain,xtrain_poly,el,0);
    B_all(:,j) = model6
    j = j+1;
end
figure
hold on
for i = 1:5
    plot(lambda,B_all(i,:))
end
xlabel('ln(lambda)')
legend('b','w1','w2','w3','w4','Location','NorthEastOutside')
