function [randomWalk] = createRandomWalk(ts)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ma = max(ts);
mi = min(ts);
movement =  10;

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

