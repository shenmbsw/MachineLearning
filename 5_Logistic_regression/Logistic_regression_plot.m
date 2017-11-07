clear
load LR_res
close all

x_axis = 1:max_iter;

figure
subplot(2,2,1)
plot(x_axis,NLL_all)
title('Negative log likelihood')
xlabel('iter')
ylabel('NLL')

subplot(2,2,2)
plot(x_axis,train_ccr)
title('train CCR')
xlabel('iter')
ylabel('train CCR')

subplot(2,2,3)
plot(x_axis,test_ccr)
title('test CCR')
xlabel('iter')
ylabel('test CCR')

subplot(2,2,4)
plot(x_axis,log_loss_all)
title('test log loss')
xlabel('iter')
ylabel('test log loss')


figure
histogram(test_y_pred)
xlim([0.5,39.5])
title('all predict result')
xticks(1:39)
xticklabels(Category_uni.')
xtickangle(45)
ylabel('sample in group')


correct_idx = test_y_pred==Y_test;
y_correct_only = test_y_pred(correct_idx);
figure
histogram(y_correct_only)
xlim([0.5,39.5])
title('correct predict result')
xticks(1:39)
xticklabels(Category_uni.')
xtickangle(45)
ylabel('sample in group')
