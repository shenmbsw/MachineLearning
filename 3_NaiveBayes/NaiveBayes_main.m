% clc;
% clear;
% load loaddataset.mat;

[ test_pred ] = Naive_Bayes(train_mat,train_label,test_mat,num_of_class )

x_axis = 1:20;
figure
scatter(x_axis,p_c,'r','filled')
title('P(Y=c) for each group')
xlabel('class')
ylabel('P(Y=c) ')
Non_zero_pwc = sum(sum(p_w_c ~= 0))

CCR = sum(test_pred == test_label.')/test_sam_num
prob_zero = sum(sum(pred.' == -inf) == 20)
confusionmat(test_pred,test_label);