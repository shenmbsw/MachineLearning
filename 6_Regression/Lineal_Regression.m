clear
load linear_data

scatter(xData,yData,3,'blue','*')
hold on
xext = [ones(18,1),xData];
beta = inv(xext'*xext) * xext' * yData;
pred = beta(1)+beta(2)*xData;
MSE_OLS = mean((yData-pred).^2)
MAE_OLS = mean(abs(yData-pred))
plot (xData,pred)

brob = {}
y_pred = {}

brob{1} = robustfit(xData,yData,'cauchy');
y_pred{1} = brob{1}(1)+brob{1}(2)*xData;
MSE_cau = mean((yData-y_pred{1}).^2)
MAE_cau = mean(abs(yData-y_pred{1}))

brob{2} = robustfit(xData,yData,'fair');
y_pred{2} = brob{2}(1)+brob{2}(2)*xData;
MSE_fair = mean((yData-y_pred{2}).^2)
MAE_fair = mean(abs(yData-y_pred{2}))

brob{3} = robustfit(xData,yData,'huber');
y_pred{3} = brob{3}(1)+brob{3}(2)*xData;
MSE_hub = mean((yData-y_pred{3}).^2)
MAE_hub = mean(abs(yData-y_pred{3}))

brob{4} = robustfit(xData,yData,'talwar');
y_pred{4} = brob{4}(1)+brob{4}(2)*xData;
MSE_tal = mean((yData-y_pred{4}).^2)
MAE_tal = mean(abs(yData-y_pred{4}))


for i = 1:4
    model = brob{i}
    plot(xData,model(1)+model(2)*xData)
end

legend('scatter','OLS','cauchy','fair','huber','talwar','Location','NorthEastOutside')