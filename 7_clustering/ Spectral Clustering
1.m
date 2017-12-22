clear
close all

load('ass8_2_cir.mat')
%load('ass8_2_spiral.mat')

rng(2)
x_axis = 1:1500;
degs = sum(S, 2);
D = sparse(1:size(S, 1), 1:size(S, 2), degs);
L1 = D - S;

degs(degs == 0) = eps;
D = spdiags(1./degs, 0, size(D, 1), size(D, 2));
L3 = D.^0.5 * L1 * D.^0.5;

k = 2;
[V, ~] = eigs(L3, k, eps);
V = V ./ sqrt(sum(V.^2, 2));
Cluster = kmeans(V, k, 'start', 'cluster', ...
                 'EmptyAction', 'singleton');
subplot(1,3,1)
gscatter(data(:,1),data(:,2),Cluster,'rbg');

k = 3;
[V, ~] = eigs(L3, k, eps);
V = V ./ sqrt(sum(V.^2, 2));
Cluster = kmeans(V, k, 'start', 'cluster', ...
                 'EmptyAction', 'singleton');
subplot(1,3,2)
gscatter(data(:,1),data(:,2),Cluster,'rbg');

k = 4;
[V, ~] = eigs(L3, k, eps);
V = V ./ sqrt(sum(V.^2, 2));
Cluster = kmeans(V, k, 'start', 'cluster', ...
                 'EmptyAction', 'singleton');
subplot(1,3,3)
gscatter(data(:,1),data(:,2),Cluster,'rbgk');
