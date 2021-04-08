clear all
close all
d = readtable('intel.csv');

%% 2
X = d.Volume;
X_miss = d.VolumeMissing;
Y = log(d.Volume(2:end)) - log(d.Volume(1:end-1));
Y_miss = log(X_miss(2:end)) - log(X_miss(1:end-1));
tList = 1:length(Y_miss);

M = find(isnan(Y_miss));