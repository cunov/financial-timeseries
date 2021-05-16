clear all
close all
V = readtable('dat_intel.csv');
X = log(V.Close(2:end)) - log(V.Close(1:end-1));

%% 2
% TODO: "partial autocorrelation functions"
%  confirm h=50 for LGQ means 1:50 lags
subplot(2,2,1)
autocorr(X,50)
title('X')
ylim([-.2, 1])

subplot(2,2,3)
autocorr(X.^2,50)
title('X^2')
ylim([-.2, 1])

resX = X - mean(X);
lags = 1:50;
[h, pValue, stat, cValue] = lbqtest(resX, 'lags', 50);
subplot(2,2,2)

p = plot(lags, pValue, 'k');
tmp_x = [p.Parent.XLim(1) p.Parent.XLim(1) p.Parent.XLim(2) p.Parent.XLim(2)];
tmp_y = [p.Parent.YLim(1) .05 .05 p.Parent.YLim(1)];
patch(tmp_x, tmp_y, 'r', 'facealpha', .2)
title('p-values for LGQ-test of X')

resX2 = X.^2 - mean(X.^2);
[h, pValue, stat, cValue] = lbqtest(resX2, 'lags', lags);
subplot(2,2,4)

p = plot(lags, pValue, 'k');
tmp_x = [p.Parent.XLim(1) p.Parent.XLim(1) p.Parent.XLim(2) p.Parent.XLim(2)];
tmp_y = [p.Parent.YLim(1) .05 .05 p.Parent.YLim(1)];
patch(tmp_x, tmp_y, 'r', 'facealpha', .2)
title('p-values for LGQ-test of X^2')