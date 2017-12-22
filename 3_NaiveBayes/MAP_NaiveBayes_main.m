% clc;
% clear;
% load loaddataset.mat;

%alpha is the piror probability, the function shows the result between different piror probability. 

power = -5:0.5:1.5;
CCR_res = zeros(1,numel(power));
for j = 1:numel(power)
    alpha = 10 ^ power(j);
    test_pred = MAP_NaiveBayes(train_mat,train_label,test_mat,num_of_class,alpha );
    CCR_res(j) = sum(test_pred == test_label.')/test_sam_num;
end

plot(power,CCR_res)
title('P(Y=c) for each group')
xlabel('log10(alpha-1)')
ylabel('CCR')
