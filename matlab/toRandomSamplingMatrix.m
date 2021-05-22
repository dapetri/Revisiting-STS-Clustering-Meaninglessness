function [dataMatrix] = toRandomSamplingMatrix(ts,w)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

dataMatrix = zeros(length(ts)-w+1, w);
for i = 1: length(dataMatrix)
    r = randi(length(ts)-w);
    dataMatrix(i,1:w) = ts(r:r+w-1);
end
end

