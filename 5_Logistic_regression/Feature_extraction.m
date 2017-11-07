load('data_SFcrime.mat')
%conver Day of week into one hot array
sam_num = numel(DayOfWeek);
Dow_one_hot = zeros(sam_num,7);
Dow_one_hot = sparse(Dow_one_hot);
Dow_one_hot(:,1) = strcmp(DayOfWeek,'Sunday');
Dow_one_hot(:,2) = strcmp(DayOfWeek,'Monday');
Dow_one_hot(:,3) = strcmp(DayOfWeek,'Tuesday');
Dow_one_hot(:,4) = strcmp(DayOfWeek,'Wednesday');
Dow_one_hot(:,5) = strcmp(DayOfWeek,'Thursday');
Dow_one_hot(:,6) = strcmp(DayOfWeek,'Friday');
Dow_one_hot(:,7) = strcmp(DayOfWeek,'Saturday');

%conver police dis into one hot array
Pd_uni = unique(PdDistrict);
Pd_num = numel(Pd_uni);
Pd_onehot = zeros(sam_num,Pd_num);
Pd_onehot = sparse(Pd_onehot);
for i = 1:Pd_num
    Pd_onehot(:,i) = strcmp(PdDistrict,Pd_uni(i));
end

%conver Hour into one hot array
Hour = zeros(sam_num,1);
for i = 1:sam_num
    sam_h = Dates{i};
    Hour(i) = str2double(sam_h(end-4:end-3));
end
Hour_onehot = zeros(sam_num,24);
for i = 1:24
    Hour_onehot(:,i) = Hour == (i-1);
end
Hour_onehot = sparse(Hour_onehot);

Category_uni = unique(Category);
Category_num = numel(Category_uni);
Category_onehot = zeros(sam_num,Category_num);
Category_onehot = sparse(Category_onehot);
for i = 1:Category_num
    Category_onehot(:,i) = strcmp(Category,Category_uni(i));
end

feature_vector = [Hour_onehot Dow_one_hot Pd_onehot];
save('data4plot')
save('data4calculate.mat','feature_vector','Category_onehot','Category_uni')

% debug = full(Dow_one_hot(1:100,:))
% debug = full(Pd_onehot(1:100,:))
% debug = Hour(1:10)
% debug = full(Hour_onehot(1:10,:))
    
