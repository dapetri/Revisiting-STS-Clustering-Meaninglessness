function [dist] = distanceMetric(v,w,metricName)
%DISTANCEMETRIX Summary of this function goes here
%   Detailed explanation goes here
dist = 0;
if metricName == "eukl"
    dist = norm(v-w);
end
end

