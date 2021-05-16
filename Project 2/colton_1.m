clear all
close all
V = readtable('dat_intel.csv');
X = log(V.Close(2:end)) - log(V.Close(1:end-1));

newdist = fitdist(X,'Normal');
newdist = ma