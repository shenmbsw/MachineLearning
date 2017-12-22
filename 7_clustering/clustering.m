% clear
% close all

% load BostonListing.mat
% data = [latitude longitude]
% sam_num = numel(latitude)
% S = zeros(sam_num,sam_num);
% for i = 1:sam_num
%     for j = 1:sam_num
%         dis = sum((data(i,:) - data(j,:)).^2);
%         S(i,j) = exp(-dis/(2*0.01));
%     end
% end
% save('ass8_house.mat')

load ass8_house.mat
nei_name = unique(neighbourhood);
nei_num = numel(nei_name);

nei_code = zeros(sam_num,1);
for i = 1:nei_num
    match_idx = strfind(neighbourhood,nei_name{i});
    k = not(cellfun('isempty', match_idx));
    nei_code(k) = i;
end

degs = sum(S, 2);
D = sparse(1:size(S, 1), 1:size(S, 2), degs);
L1 = D - S;
degs(degs == 0) = eps;
D = spdiags(1./degs, 0, size(D, 1), size(D, 2));
L3 = D.^0.5 * L1 * D.^0.5;

purity = zeros(24,1);
for k = 2:25
    cluster_counter = zeros(k,1);
    [V, ~] = eigs(L3, k, eps);
    V = V ./ sqrt(sum(V.^2, 2));
    Cluster = kmeans(V, k);
    for i = 1:k
        [~,b] = mode(nei_code(Cluster==i));
        cluster_counter(i) = b;
    end
    purity(k-1) = sum(cluster_counter)/sam_num;
end
plot(2:25,purity)
xlabel('k num')
ylabel('purity')

k = 5
[V, ~] = eigs(L3, k, eps);
V = V ./ sqrt(sum(V.^2, 2));
Cluster = kmeans(V, k);


plot(longitude,latitude,'.r','MarkerSize',10)
plot_google_map

hold on
gscatter(longitude,latitude,Cluster)
