function save_dataset

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
save loaddataset.mat;


end

