clc;
clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this script is to read all the data and save it as feature vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
label_name = textread('newsgrouplabels.txt','%s');
all_word = textread('vocabulary.txt','%s');
word_num = numel(all_word);
num_of_class = numel(label_name);

train_label = importdata('train.label');
train_sam_num = numel(train_label);
[train_tid,train_wid,train_wNum] = textread('train.data','%d %d %d');
train_mat = sparse(train_tid, train_wid, train_wNum, train_sam_num, word_num);

test_label = importdata('test.label');
test_sam_num = numel(test_label);
[test_tid,test_wid,test_wNum] = textread('test.data','%d %d %d');
test_mat = sparse(test_tid,test_wid,test_wNum,test_sam_num,word_num);

stop_word = textread('stoplist.txt','%s');
stop_idx = zeros(numel(stop_word),1);
for i = 1:numel(stop_word)
    z = strcmp(all_word,stop_word(i));
    if ~isempty(find(z==1));
        stop_idx(i) = find(z==1);
    end
end

stop_idx = stop_idx(stop_idx>0);
train_mat(:, stop_idx) = [];
test_mat(:,stop_idx) = [];
all_word(stop_idx,:) = [];

clear i stop_idx stop_word z
clear test_tid test_wid test_wNum
clear train_tid train_wid train_wNum

save loaddataset.mat;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

