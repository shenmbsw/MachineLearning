clc;
clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % homework assignment from Shen Shen on course EC503.
% % assignmet 4-1-a load parse and static
% % this part is for loding the dataset, comment it when the word space has
% % already been loaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save_dataset;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load loaddataset.mat;

%number of unique word
uw_train = numel(unique(train_wid))
uw_test = numel(unique(test_wid))
uw_all = numel(unique([train_wid;test_wid]))

%document_lenth
DL_train = full(sum(train_mat,2));
DL_test = full(sum(test_mat,2));

average_DL_train = mean(DL_train)
std_DL_train = std(DL_train)
average_DL_test =  mean(DL_test)
std_DL_test = std(DL_test)

%total number of word appear in test but not train
uw_only_test = uw_all - uw_train

%most frequent word id
word_acc = full(sum(train_mat,1)) + full(sum(test_mat,1));
[freq_word_num, freq_idx] = sort(word_acc,2,'descend');
freq_ten_word_num = freq_word_num(:,1:10)
freq_ten_idx =  freq_idx(:,1:10);
all_word(freq_ten_idx)

%smallest_time, word appear this number and 'od'
smallest_time = min(freq_word_num)
smallest_word_idx = word_acc==smallest_time;
smallest_word_show_time = sum(smallest_word_idx)
smallest_word = all_word(smallest_word_idx);
sw = startsWith(smallest_word,'od','IgnoreCase',true);
smallest_word(sw)
