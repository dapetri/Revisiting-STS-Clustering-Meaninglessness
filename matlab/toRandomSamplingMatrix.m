function [dataMatrix] = toRandomSamplingMatrix(ts,w,reducedSamplingSize)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
m = size(ts,2);
if reducedSamplingSize
    numSamples = floor(m/w);
else 
    numSamples = m-w+1;
end
dataMatrix = zeros(numSamples, w);
for i = 1: numSamples
    r = randi(m-w);
    dataMatrix(i,1:w) = ts(r:r+w-1);
end
end

