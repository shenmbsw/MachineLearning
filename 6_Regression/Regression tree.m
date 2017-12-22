clear
load housing_data

t = classregtree(Xtrain,ytrain,'names',feature_names,'minleaf',20);
view(t)

fit_data = [5,18,2.31,1,0.544,2,64,3.7,1,300,15,390,10];
tree_pred = eval(t,fit_data)

train_MAE = zeros(25,1);
test_MAE = zeros(25,1);

for i = 1:25
    t = classregtree(Xtrain,ytrain,'names',feature_names,'minleaf',i);
    train_pred = eval(t,Xtrain);
    test_pred = eval(t,Xtest);
    train_MAE(i) = mean(abs(ytrain-train_pred));
    test_MAE(i) = mean(abs(ytest-test_pred));
end
x_axis = 1:25;
plot (x_axis,train_MAE,x_axis,test_MAE)
legend('train MAE','test MAE')
xlabel('minleaf num')
ylabel('MAE')
