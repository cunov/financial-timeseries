clear all
close all
d = readtable('intel.csv');

%% 1
X = d.Volume;
X_miss = d.VolumeMissing;
Y = log(d.Volume(2:end)) - log(d.Volume(1:end-1));
Y_miss = log(X_miss(2:end)) - log(X_miss(1:end-1));
tList = 1:length(Y_miss);

[acf, lags, bounds] = autocorr(Y_miss, 'NumLags', 20);
plot(lags, acf)
xlabel('$$h$$', 'Interpreter', 'Latex')
ylabel('$$\hat{\rho_Y}$$','Interpreter','Latex')

% Choose q = 6 ?