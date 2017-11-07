% clear
% load('data4plot.mat')
close all

figure
subplot(2,2,1);
histogram(Hour)
title('Hour Histogram')
xlim([-0.5,23.5])
xlabel('hour')
ylabel('appear time')

% figure
subplot(2,2,2)
[Dow_ind,~] = vec2ind(Dow_one_hot.');
histogram(Dow_ind)
title('Day of week Histogram')
xlim([0.5,7.5])
xticks(1:7)
xticklabels({'Sun','Mon','Tue','Wed','Thu','Fri','Sat'})
ylabel('appear time')

% figure
subplot(2,2,3)
[Pd_ind,~] = vec2ind(Pd_onehot.');
histogram(Pd_ind)
title('Police District Histogram')
xlim([0.5,10.5])
xticks(1:10)
xticklabels(Pd_uni.')
xtickangle(45)
ylabel('appear time')

% figure
subplot(2,2,4)
[Category_ind,~] = vec2ind(Category_onehot.');
histogram(Category_ind)
title('Crime type Histogram')
xlim([0.5,39.5])
xticks(1:39)
xticklabels(Category_uni.')
xtickangle(45)
ylabel('appear time')


% close all
ML_hour = zeros(39,1);
for i = 1:39
    idx = Category_ind == i;
    ith_hour = Hour(idx);
    ML_hour(i) = mode(ith_hour);
end
    
ML_crime = zeros(10,1);
for i = 1:10
    idx = Pd_ind == i;
    ith_pd = Category_ind(idx);
    ML_crime(i) = mode(ith_pd);
end

UC = unique(Category);
an = UC(ML_crime)

% {'DRUG/NARCOTIC'} is index 8
% {'LARCENY/THEFT'} is index 17
% {'ROBBERY'} is index 26

DRUG_NARCOTIC = Category_ind.' == 8;
LARCENY_THEFT =  Category_ind.' == 17;
ROBBERY = Category_ind.' == 26;

figure
dx = X(DRUG_NARCOTIC);
dy = Y(DRUG_NARCOTIC);
plot(dx,dy,'.r','MarkerSize',3)
title('DRUG NARCOTIC')
xlim([min(dx)-0.01,max(dx)+0.01])
ylim([min(dy)-0.01,max(dy)+0.01])
plot_google_map


figure
lx = X(LARCENY_THEFT);
ly = Y(LARCENY_THEFT);
plot(lx,ly,'.r','MarkerSize',3)
xlim([min(dx)-0.01,max(dx)+0.01])
ylim([min(dy)-0.01,max(dy)+0.01])
title('LARCENY THEFT')
plot_google_map

rx = X(DRUG_NARCOTIC);
ry = Y(DRUG_NARCOTIC);
figure

plot(rx,ry,'.r','MarkerSize',3)
xlim([min(dx)-0.01,max(dx)+0.01])
ylim([min(dy)-0.01,max(dy)+0.01])
title('ROBBERY')
plot_google_map
