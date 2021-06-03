clear All
clc

n = 1;
r = 3;
ks = [3 5 7 11];
ws = [8 16 32];

spx_short = readmatrix('../data/spx_daily_11-21.csv');
spx_short = transpose(spx_short(:,2));

spx_long = readmatrix('../data/spx_monthly_alltime.csv');
spx_long = transpose(spx_long(:,2));

min_daily_temp = readmatrix('../data/daily-minimum-temperatures-in-melbourne.csv');
min_daily_temp = transpose(min_daily_temp(:,2));

bip_de = readmatrix('../data/bip_de_preisbereinigt.csv');
bip_de = transpose(bip_de(:,2));

dax = readmatrix('../data/dax.csv');
dax = transpose(dax(:,2));

dax_alltime = readmatrix('../data/dax_alltime.csv');
dax_alltime = transpose(dax_alltime(:,2));

bitcoin_alltime = readmatrix('../data/bitcoin_alltime.csv');
bitcoin_alltime = transpose(bitcoin_alltime(:,2));
for i=2:length(bitcoin_alltime)
    if isnan(bitcoin_alltime(i))
        bitcoin_alltime(i) = bitcoin_alltime(i-1);
    end
end


normMethods = ["none" "zscore" "norm" "scale" "range" "medianiqr"];
distMetrics = ["eukl" ""];
clusterAlgos = ["kmeans" "agglo" "gmm"];
% timeSeries = [spx_short spx_long min_daily_temp bip_de dax dax_alltime bitcoin_alltime]

currentNorm = normMethods(2);
% used clustering algorithm
currentClusterAlgo = clusterAlgos(2);
% used time series
currentTs = spx_short;


currentDistMetric = distMetrics(1);

%opposingTs = createRandomWalk(currentTs);
% Instead of a random walk we could also pass any opposing time series
opposingTs = bitcoin_alltime;

% reduces de sampling size of the random sampled subsequences that are used for whole clustering
% if false the random samples matrix has the same height as the sts matrix
reducedSamplingSize = true;
dimRed = true;

meaningfulness_sts = zeros(length(ks)*length(ws),3);
meaningfulness_whole = zeros(length(ks)*length(ws),3);

disp("n: "+n+", r: "+r)

i = 1;
for k = 1:length(ks)
    for w = 1:length(ws)
        [sts,whole] = calculateMeaningfulness(currentTs,opposingTs,n,ks(k),ws(w),r,currentDistMetric,currentNorm,currentClusterAlgo,reducedSamplingSize,dimRed);
        meaningfulness_sts(i,:) = [ws(w) ks(k) sts];
        meaningfulness_whole(i,:) = [ws(w) ks(k) whole];
        i = i+1;
        disp("k="+ks(k)+", w="+ws(w)+" -- STS-meaning: "+sts+", Whole-meaning: "+whole+"");
    end
end