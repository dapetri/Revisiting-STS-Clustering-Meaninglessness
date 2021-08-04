function [dataMatrix] = toRandomSamplingMatrix(ts,w,reducedSamplingSize,seed_)
% Create random sampling matrix for whole clustering by extracting random 
% subsequences from ts.
%   :param ts: time series random sampling matrix should be created from (shape: [m])
%   :param w: sliding window length
%   :param reducedSamplingSize: if true, random sampling matrix will have length m//w
%        meaning haveing the same length as whole clustering matrix as in experiment 2 (much smaller)
%   :return dataMatrix: random sampling matrix (shape: [m-w+1,w] or (shape: [m//w,w]))
m = size(ts,2);
if reducedSamplingSize
    numSamples = floor(m/w);
else 
    numSamples = m-w+1;
end

rng(seed_);

dataMatrix = zeros(numSamples, w);
for i = 1: numSamples
    r = randi(m-w);
    dataMatrix(i,1:w) = ts(r:r+w-1);
end
end

