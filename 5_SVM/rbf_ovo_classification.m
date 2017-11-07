clear
load loaddataset.mat;

for i = 1:20
    hold_train_data{i} = train_mat(train_label==i,:);
    hold_test_data{i} = test_mat(test_label==i,:);
end

hold_svm = cell(20,20);

tic
for i = 1:20
    for j = i+1:20
        tem_train_data = [hold_train_data{i};hold_train_data{j}];        
        % classified as class i would be treat as positive, relabel
        tem_pos_sam_num = sum(train_label==i);
        tem_neg_sam_num = sum(train_label==j);
        tem_train_label = [ones(tem_pos_sam_num,1); -1 * ones(tem_neg_sam_num,1)];
        model = svmtrain(tem_train_data, tem_train_label,'kernel_function','rbf','boxconstraint',16,'rbf_sigma',16,'autoscale','False');
        hold_svm{i,j} = model;
    end
end
toc

predict_mat = zeros(test_sam_num,20);
tic
for i = 1:20
    for j = i+1:20
        model = hold_svm{i,j};
        predict = svmclassify(model,test_mat);

        pos = predict==1;
        neg = predict == -1;
        predict_mat(:,i) = predict_mat(:,i) + pos;
        predict_mat(:,j) = predict_mat(:,j) + neg;
    end
end
toc

result = zeros(test_sam_num,1);
for i = 1:test_sam_num
    [~,ind] = max(predict_mat(i,:));
    result(i) = ind;
end

CCR = sum(result == test_label)/test_sam_num;
conf = confusionmat(result,test_label);

save assignment6_1_f_result.mat;
