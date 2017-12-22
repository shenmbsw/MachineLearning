clear
close all

load('ass8_2_cir.mat')
%load('ass8_2_spi.mat')
rng(2)

x_axis = 1:1500;
k = 3;

degs = sum(S, 2);
D = sparse(1:size(S, 1), 1:size(S, 2), degs);
L1 = D - S;
[V1, ~] = svd(L1);
V1 = V1(:,1498:1500)
subplot(1,3,1)
V11 = V1(label == 1,:)
scatter3(V11(:,1),V11(:,2),V11(:,3),'filled','r')
hold on
V12 = V1(label == 2,:)
scatter3(V12(:,1),V12(:,2),V12(:,3),'filled','b')
V13 = V1(label == 3,:)
scatter3(V13(:,1),V13(:,2),V13(:,3),'filled','g')

degs(degs == 0) = eps;
D = spdiags(1./degs, 0, size(D, 1), size(D, 2));

L2 = D * L1;
[V2, ~] = svd(L2);
V2 = V2(:,1498:1500)
subplot(1,3,2)
V21 = V2(label == 1,:)
scatter3(V21(:,1),V21(:,2),V21(:,3),'filled','r')
hold on
V22 = V2(label == 2,:)
scatter3(V22(:,1),V22(:,2),V22(:,3),'filled','b')
V23 = V2(label == 3,:)
scatter3(V23(:,1),V23(:,2),V23(:,3),'filled','g')

L3 = D.^0.5 * L1 * D.^0.5;
[V3, ~] = svd(L3);
V3 = V3(:,1498:1500)
V3 = V3 ./ sqrt(sum(V3.^2, 2));
subplot(1,3,3)
V31 = V3(label == 1,:)
scatter3(V31(:,1),V31(:,2),V31(:,3),'filled','r')
hold on
V32 = V3(label == 2,:)
scatter3(V32(:,1),V32(:,2),V32(:,3),'filled','b')
V33 = V3(label == 3,:)
scatter3(V33(:,1),V33(:,2),V33(:,3),'filled','g')