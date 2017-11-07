clear
load loaddataset.mat;

s = RandStream('mt19937ar','Seed',1);

train_label(train_label~=7) =-1;
train_label(train_label==7) = 1;

test_label(test_label~=7) = -1;
test_label(test_label==7) = 1;

train_sam_num = numel(train_label);
test_sam_num = numel(test_label);

split = cvpartition(train_label,'k',5);
CCR_list = zeros(5,20);
precision_list = zeros(5,20);
recall_list = zeros(5,20);
F_score_list = zeros(5,20);

for i = 1:5
    s_train_idx = split.training(i);
    s_test_idx = split.test(i);
    idx = 0;
    for c = -9:10
        idx = idx + 1;
        C = 2^c;
        Model = svmtrain(train_mat(s_train_idx,:), train_label(s_train_idx),...
            'kernel_function','linear','boxconstraint',...
            C,'autoscale','False','kernelcachelimit',20000);
        predict = svmclassify(Model,train_mat(s_test_idx,:));
        cf_mat = confusionmat(predict,train_label(s_test_idx));
        CCR_list(i,idx) = sum(predict == train_label(s_test_idx))/sum(s_test_idx);
        precision_list(i,idx) = cf_mat(2,2)/(cf_mat(2,1)+cf_mat(2,2));
        recall_list(i,idx) = cf_mat(2,2)/(cf_mat(1,2)+cf_mat(2,2));
        F_score_list(i,idx) = 0.5 * (precision_list(i,idx) + recall_list(i,idx));
    end
end

% % the training is time consuming so we save breakpoint here, to advoid
% % memory out problem
save assignment6_1_cd_cp.mat
load final_6_2.mat

% calculate the 4 score
final_precision = mean(precision_list,1);
final_CCR = mean(CCR_list,1);
final_recall = mean(recall_list,1);
final_F_score = mean(F_score_list,1);


% plot score change along with C 
x = -9:10;
close all
figure
plot(x,final_CCR)
xlabel('log(c)')
ylabel('CCR')
figure
plot(x,final_recall,x,final_precision,x,final_F_score)
xlabel('log(c)')
legend('recall','precision','Fscore')
 
% % test with C on highest CCR
[~,i] = max(final_CCR);
c1 = 2^x(i)
Model = svmtrain(full(train_mat), train_label,...
        'kernel_function','linear','boxconstraint',...
        c1,'autoscale','False','kernelcachelimit',20000);
perdict = svmclassify(Model,full(test_mat));
cf_mat1 = confusionmat(perdict,test_label)
CCR_test1 =  sum(perdict == test_label)/numel(test_label)

% test with C on highest recall
[~,i] = max(final_recall);
c2 = 2^x(i)
Model = svmtrain(full(train_mat), train_label,...
        'kernel_function','linear','boxconstraint',...
        c2,'autoscale','False','kernelcachelimit',20000);
perdict = svmclassify(Model,full(test_mat));
cf_mat2 = confusionmat(perdict,test_label)
CCR_test2 =  sum(perdict == test_label)/numel(test_label)

% test with C on highest F-score
[~,i] = max(final_F_score);
c3 = 2^x(i)
Model = svmtrain(full(train_mat), train_label,...
        'kernel_function','linear','boxconstraint',...
        c3,'autoscale','False','kernelcachelimit',20000);
perdict = svmclassify(Model,full(test_mat));
cf_mat3 = confusionmat(perdict,test_label)
CCR_test3 =  sum(perdict == test_label)/numel(test_label)

% save final_6_2.mat
