clear All
clc

n = 100;
r = 3;
ks = [3 5 7 11];
ws = [8 16 32];

ts = readmatrix('../data/spx_daily_11-21.csv');
ts = transpose(ts(:,2));

rw = createRandomWalk(ts);
    


meaningfulness_sts = zeros(length(ks)*length(ws),3);
meaningfulness_whole = zeros(length(ks)*length(ws),3);

disp("n: "+n+", r: "+r)

i = 1;
for k = 1:length(ks)
    for w = 1:length(ws)
        [sts,whole] = calculateKMeansMeaningfulness(ts,rw,n,ks(k),ws(w),r,@euklideanDistance,normMethods(1));
        meaningfulness_sts(i,:) = [ws(w) ks(k) sts];
        meaningfulness_whole(i,:) = [ws(w) ks(k) whole];
        i = i+1;
        disp("k="+ks(k)+", w="+ws(w)+" -- STS-meaning: "+sts+", Whole-meaning: "+whole+"");
    end
end