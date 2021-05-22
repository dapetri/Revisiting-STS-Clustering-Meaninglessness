clear All
clc

n=30;
k=3;
w=128;

cbf = readmatrix('../data/cbf.csv');
cbf = transpose(cbf(2:w+1,2:3*n+1));

cbf_concat = createConcatenatedTimeseries(cbf);
cbf_sts = toStsMatrix(cbf_concat,w);

[~,C_whole] = kmeans(cbf,k);
[~,C_sts] = kmeans(cbf_sts,k);

ts_C_whole1 = timeseries(C_whole(1,:));
ts_C_whole2 = timeseries(C_whole(2,:));
ts_C_whole3 = timeseries(C_whole(3,:));

ts_C_sts1 = timeseries(C_sts(1,:));
ts_C_sts2 = timeseries(C_sts(2,:));
ts_C_sts3 = timeseries(C_sts(3,:));

hold on
plot(ts_C_whole1);
plot(ts_C_whole2);
plot(ts_C_whole3);

figure
hold on
plot(ts_C_sts1);
plot(ts_C_sts2);
plot(ts_C_sts3);


ts_C_sts = timeseries(C_sts);



