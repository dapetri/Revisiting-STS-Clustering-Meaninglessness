function [randomWalk] = createRandomWalk(ts)
% Create same length random walk as times series.
%   :param ts: time series to which length random walk should be equal (shape: [m])
%   :return randomWalk: random walk with same length to ts (shape: [m])
ma = max(ts);
mi = min(ts);
movement =  10;
rng(0)

randomWalk = zeros(1,length(ts));
randomWalk(1) = mi + rand * (ma-mi);
for i = 2: length(ts)
    r = rand * movement;
    if(rand >= 0.5)
        randomWalk(i) = randomWalk(i-1) + r;
    else
        randomWalk(i) = randomWalk(i-1) - r;
    end    
end
  
end

