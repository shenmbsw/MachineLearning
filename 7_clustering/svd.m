clear
close all

% [data,label] = sample_circle(3,[500,500,500]);
% [data,label] = sample_spiral(3,[500,500,500]);
% S = zeros(1500,1500);
% for i = 1:1500
%     for j = 1:1500
%         dis = sum((data(i,:) - data(j,:)).^2)
%         S(i,j) = exp(-dis/(2*0.04));
%     end
% end
% save('ass8_2_cir.mat')
% save('ass8_2_spi.mat')

%load('ass8_2_cir.mat')
load('ass8_2_spi.mat')

x_axis = 1:1500;
degs = sum(S, 2);
D = sparse(1:size(S, 1), 1:size(S, 2), degs);
L1 = D - S;
E = sort(eig(L1));
subplot(1,3,1)
plot(x_axis,E)

degs(degs == 0) = eps;
D = spdiags(1./degs, 0, size(D, 1), size(D, 2));

L2 = D * L1;
E = sort(eig(L2));
subplot(1,3,2)
plot(x_axis,E)

L3 = D.^0.5 * L1 * D.^0.5;
E = sort(eig(L3));
subplot(1,3,3)
plot(x_axis,E)
