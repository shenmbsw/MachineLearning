clear
close all

rng(2)
data3 = zeros(1500,2);
[data1,label] = sample_circle(3,[500,500,500]);

%first dim for radiance
[data3(:,1),data3(:,2)] = cart2pol(data1(:,1),data1(:,2));

data3 = (data3- min(data3)) ./ (max(data3) - min(data3));


subplot(1,3,1)
[km2,C2,num2,dis2] =  kmeans(data3,2,'Replicates',20,'Distance','cityblock');
gscatter(data3(:,1),data3(:,2),km2,'rb');
hold on
scatter(C2(:,1),C2(:,2),30,'k','*')
ylabel('rad')
xlabel('ang')
d1 = dis2(km2==1,:);
group1_km2 = sum(d1(:,1))
d2 = dis2(km2==2,:);
group2_km2 = sum(d2(:,2))


subplot(1,3,2)
[km3,C3,num3,dis3] = kmeans(data3,3,'Replicates',20,'Distance','cityblock');
gscatter(data3(:,1),data3(:,2),km3,'rbg');
hold on
scatter(C3(:,1),C3(:,2),30,'k','*')
ylabel('rad')
xlabel('ang')
d1 = dis3(km3==1,:);
group1_km3 = sum(d1(:,1))
d2 = dis3(km3==2,:);
group2_km3 = sum(d2(:,2))
d3 = dis3(km3==3,:);
group3_km3 = sum(d3(:,3))


subplot(1,3,3)
[km4,C4,num4,dis4] = kmeans(data3,4,'Replicates',20,'Distance','cityblock');
gscatter(data3(:,1),data3(:,2),km4,'rbgk');
hold on
scatter(C4(:,1),C4(:,2),30,'k','*')
ylabel('rad')
xlabel('ang')
d1 = dis4(km4==1,:);
group1_km4 = sum(d1(:,1))
d2 = dis4(km4==2,:);
group2_km4 = sum(d2(:,2))
d3 = dis4(km4==3,:);
group3_km4 = sum(d3(:,3))
d4 = dis4(km4==4,:);
group4_km4 = sum(d4(:,4))
