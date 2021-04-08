clear all
close all
d = readtable('intel.csv');

maxH = 500;
numHtoPlot = 20;
%% 1
X = d.Volume;
X_miss = d.VolumeMissing;
Y = log(d.Volume(2:end)) - log(d.Volume(1:end-1));
Y_miss = log(X_miss(2:end)) - log(X_miss(1:end-1));
tList = 1:length(Y_miss);

[acf, lags, bounds] = autocorr(Y_miss, 'NumLags', maxH);
yyaxis left
subplot(1,2,1)
stem(lags(1:numHtoPlot),acf(1:numHtoPlot),'filled','k')
xlabel('$$h$$', 'Interpreter', 'Latex')
ylabel('$$\hat{\rho_Y}$$','Interpreter','Latex')
% title('$$\hat{\rho_Y}$$','Interpreter','Latex')

N = length(Y);
MSE = zeros(1, maxH + 1);
for h = 0:numHtoPlot5
    acf_subset = acf(h+1:h+1+400);
    pd_sample = fitdist(acf_subset, 'Normal'); % fit normal dist'n to data
    CI_params = pd_sample.paramci;
    CI_mu_width(h+1) = diff(CI_params(1:2,1));
    CI_sigma_width(h+1) = diff(CI_params(1:2,2));
    y_sample = pdf(pd_sample, acf_subset);
    
    % this plots the ACFs alongside expected, step thru to see they don't
    % get much better after h=3
%     [sorted_acf_subset, idx_sorted] = sort(acf_subset); % sorted so we can have line plot
%     sorted_y_expected = normpdf(sorted_acf_subset, 0, sqrt(1/N)); % expected N(mu=0,sigma=sqrt(1/N))
%     scatter(acf_subset,y_sample)
%     hold on
%     plot(sorted_acf_subset, sorted_y_expected)
%     hold off
%     title(['h = ' num2str(h)])
%     xlim([-.15 .15])
    
    y_expected = normpdf(acf_subset, 0, sqrt(1/N));
    MSE(h+1) = immse(y_sample, y_expected);
end
hold on
yyaxis right
plot(0:numHtoPlot,sqrt(MSE(1:numHtoPlot+1)))
ylabel(['RMSE of computed pdf of ACF(h:400+h) to $$N(0, $$N$$^{-1})$$'],'Interpreter','Latex')
hold off

subplot(1,2,2)
yyaxis left
plot(0:numHtoPlot,CI_mu_width(1:numHtoPlot+1))
ylabel('$$\mu$$','interpreter','latex')
yyaxis right
plot(0:numHtoPlot,CI_sigma_width(1:numHtoPlot+1))
ylabel('$$\sigma$$','interpreter','latex')
title('95% Confidence Interval widths')
xlabel('$$h$$','interpreter','latex')
set(gcf,'color','w')
%% 2
