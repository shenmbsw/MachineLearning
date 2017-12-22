
Y_all = vec2ind(Category_onehot.').';
m = size(Category_onehot,2);
[n,dim] = size(feature_vector);
train_sam_num = floor(n *0.6);
test_sam_num = n-train_sam_num;
X_train = feature_vector(1:train_sam_num,:).';
Y_train = Y_all(1:train_sam_num,:).';
X_test = feature_vector(train_sam_num+1:n,:).';
Y_test = Y_all(train_sam_num+1:n,:).';

lambda = 100;
alpha = 1e-5;
w =zeros(dim,m);
max_iter = 500;
NLL_all = zeros(max_iter,1);
log_loss_all = zeros(max_iter,1);
train_CCR_all = zeros(max_iter,1);
test_CCR_all = zeros(max_iter,1);
ytest_bin = ind2vec(Y_test);

LDAmodel = LDA_train(X_train.',Y_train.',m);
[train_y_pred] = LDA_test(X_train.', LDAmodel, m);
LDAtrain_ccr = sum(train_y_pred.' == Y_train)/train_sam_num;
[test_y_pred] = LDA_test(X_test.', LDAmodel, m);
LDAtest_ccr = sum(test_y_pred.' == Y_test)/test_sam_num;

[RDAmodel]= RDA_train(X_train.', Y_train.',0.2, m)
[train_y_pred] = RDA_test(X_train.', RDAmodel, m);
RDAtrain_ccr = sum(train_y_pred.' == Y_train)/train_sam_num;
[test_y_pred] = RDA_test(X_test.', RDAmodel, m);
RDAtest_ccr = sum(test_y_pred.' == Y_test)/test_sam_num;