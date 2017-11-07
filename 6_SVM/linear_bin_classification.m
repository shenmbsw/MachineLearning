clear
load loaddataset.mat;

% relabel and selete 
s = RandStream('mt19937ar','Seed',1);
train_twoclass_idx = (train_label==1|train_label==20);
test_twoclass_idx = (test_label==1|test_label==20);
train_mat = train_mat(train_twoclass_idx,:);
train_label = train_label(train_twoclass_idx);
train_label(train_label==20) = -1;
test_mat = test_mat(test_twoclass_idx,:);
test_label = test_label(test_twoclass_idx);
test_label(test_label==20) = -1;
train_sam_num = numel(train_label);
test_sam_num = numel(test_label);

% split the data into 5
split_idx = randperm(s,train_sam_num);
split_num = ceil(train_sam_num/5);
split_train_data = {};
split_train_label = {};
split_tmp = split_idx(1:split_num);
split_train_data{1} = train_mat(split_tmp,:);
split_train_label{1} = train_label(split_tmp);
split_tmp = split_idx(split_num+1:2*split_num);
split_train_data{2} = train_mat(split_tmp,:);
split_train_label{2} = train_label(split_tmp);
split_tmp = split_idx(2*split_num+1:3*split_num);
split_train_data{3} = train_mat(split_tmp,:);
split_train_label{3} = train_label(split_tmp);
split_tmp = split_idx(3*split_num+1:4*split_num);
split_train_data{4} = train_mat(split_tmp,:);
split_train_label{4} = train_label(split_tmp);
split_tmp = split_idx(4*split_num+1:train_sam_num);
split_train_data{5} = train_mat(split_tmp,:);
split_train_label{5} = train_label(split_tmp);

% train with different C
CCR_list = zeros(19,1);
idx = 1;
for c = -9:10
    C = 2^c
    CCR = zeros(5,1);
    for i = 1:5
        all_set = 1:5;
        train_set = all_set(all_set~=i);
        s_train_x = [];
        s_train_y = [];
        for j = 1:4
            k = train_set(j);
            s_train_x = [s_train_x ; split_train_data{k}];
            s_train_y = [s_train_y ; split_train_label{k}];
        end
        s_test_x = split_train_data{i};
        s_test_y = split_train_label{i};
        sam_num = numel(s_test_y);

        Model = svmtrain(s_train_x, s_train_y,'kernel_function','linear','boxconstraint',C,'autoscale','False');
        perdict = svmclassify(Model,s_test_x);
        CCR(i) = sum(perdict == s_test_y)/sam_num;
    end
    avg_CCR = mean(CCR);
    CCR_list(idx) = avg_CCR;
    idx = idx+1; 
end

% plot
plot(CCR_list)
xlabel('log2(c)')
ylabel('vaild CCR')

% test
[~,i] = max(CCR_list);
best_c = 2;
Model = svmtrain(train_mat, train_label,'kernel_function','linear','boxconstraint',best_c,'autoscale','False');
perdict = svmclassify(Model,test_mat);
final_CCR = sum(perdict == test_label)/test_sam_num;