clear

data = readtable('intel.csv');

dataRange = 1:1:length(data.Volume);

plot(dataRange,data.Volume')
legend('Complete data')
figure()
missingDataPoints = [];
missingDataTime = [];

for i = 1:length(data.VolumeMissing)
    if isnan(data.VolumeMissing(i))
        missingDataPoints(length(missingDataPoints) + 1) = data.Volume(i);
        missingDataTime(length(missingDataTime) + 1) = i;
    end
end

hold on
scatter(dataRange,data.VolumeMissing')
scatter(missingDataTime,missingDataPoints)
legend('Data with missing values','Missing values')
hold off
figure()

sampleMean = mean(data.Volume);

syms k
F1 = symsum(k^2,k,0,10);

AutoCov0=0;
for i = 1:length(data.Volume)
  AutoCov0 = AutoCov0 + (data.Volume(i)-sampleMean).^2;
end
AutoCov0 = AutoCov0/length(data.Volume);

%alternative way of doing it
%AutoCov0 = mean((data.Volume - sampleMean).^2);

sampleMean = 0;

%change data to Yt:= log Xt+1 − log Xt
for i = 1:length(data.Volume)-1
    y(i) = log(data.Volume(i+1))-log(data.Volume(i));
end

AutoCov0=0;
for i = 1:length(y)
  AutoCov0 = AutoCov0 + (y(i)-sampleMean).^2;
end
AutoCov0 = AutoCov0/length(y);

%alternative way of doing it
%AutoCov0 = mean((data.Volume - sampleMean).^2);

AutoCov = [1];
%Trying to do the sample autocorrelation function on my own
for lag = 1:1:20
    AutoCovCurrent = 0;
    for i = lag+1:1:length(y)
    	AutoCovCurrent=AutoCovCurrent+(y(i)-sampleMean)*(y(i-lag)-sampleMean);
    end
    AutoCov(lag+1) = AutoCovCurrent/(length(y)-lag)/AutoCov0;
end
scatter(1:21, AutoCov)
figure()

%Matlab sample autocorrelation function
[acf,lags,bounds] = autocorr(y);
autocorr(y)
