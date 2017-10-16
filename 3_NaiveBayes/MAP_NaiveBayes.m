function [ test_pred ] = MAP_NaiveBayes(train_mat,train_label,test_mat,num_of_class,alpha )
% MAP Naive Bayes
%
% Inputs :
% train_mat : training data matrix, a sparse matrix with each cols is the
% frequency a word appears.
% train_label : training labels for rows of train_mat
% num_of_class : number of classes 
% test_mat : test data matrix, a sparse matrix with each cols is the
% frequency a word appears.
% alpha : piror probability of the word.
%
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% test_pred : the prediction from MAP-NB method

[train_sam_num,word_num] = size(train_mat);
test_sam_num = size(test_mat,1);

p_w_c = zeros(word_num,num_of_class);
p_c = zeros(num_of_class,1);
for i = 1:num_of_class
    class_sam = train_label==i;
    p_c(i)  = sum(class_sam)/train_sam_num;
    p_w_c(:,i) = sum(train_mat(class_sam,:),1) + alpha;
    p_w_c(:,i) = p_w_c(:,i) ./ sum(p_w_c(:,i));
end

pred = test_mat * log(p_w_c) + repmat(log(p_c).',test_sam_num,1);
[~,test_pred] = max(pred.');

end

