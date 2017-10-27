clear
load('data_iris')
a = randperm(150);
X = X(a,:);
Y = Y(a);
feature_vector = X;
[Category_onehot] = ind2vec(Y.').';

% % saperate the data set into train and test 
X_ext = [feature_vector ones(size(feature_vector,1),1)];
Y_all = vec2ind(Category_onehot.').';
m = size(Category_onehot,2);
[n,dim] = size(X_ext);
train_sam_num = floor(n *0.6);
test_sam_num = n-train_sam_num;
X_train = X_ext(1:train_sam_num,:).';
Y_train = Y_all(1:train_sam_num,:).';
X_test = X_ext(train_sam_num+1:n,:).';
Y_test = Y_all(train_sam_num+1:n,:).';

% % initalization
lambda = 100;
alpha = 1e-5;
w =zeros(dim,m);
max_iter = 500;
NLL_all = zeros(max_iter,1);
log_loss_all = zeros(max_iter,1);
train_CCR_all = zeros(max_iter,1);
test_CCR_all = zeros(max_iter,1);
ytest_bin = ind2vec(Y_test);

% % apply GD to find w, calculate result 
for t = 1:max_iter
    w = w - alpha * d_loss(X_train,Y_train,w,lambda);
    NLL_all(t) = loss_f(X_train,Y_train,w,lambda);    
    [~,trian_y_pred] = max(w.'*X_train,[],1);
    train_ccr(t) = sum(trian_y_pred == Y_train)/train_sam_num;
    [~,test_y_pred] = max(w.'*X_test,[],1);
    test_ccr(t) = sum(test_y_pred == Y_test)/test_sam_num;
    p = softmax(w.'*X_test);
    ext_small_idx = p<1e-10;
    p(ext_small_idx) = 1e-10;
    log_loss_all(t) = -1/test_sam_num * sum(log(p(ytest_bin==1)));
end

plot(1:max_iter,train_ccr,1:max_iter,test_ccr)