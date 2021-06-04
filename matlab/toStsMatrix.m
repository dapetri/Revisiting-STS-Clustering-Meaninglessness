function [sts] = toStsMatrix(ts, w)
% Create STS matrix of time series.
%   :param ts: time series sts matrix should be created from (shape: [m])
%   :param w: sliding window length
%   :return sts: sts matrix (shape: [m-w+1,w])
 sts = zeros(length(ts)-w+1, w);
 for i = 1: length(sts)
     sts(i,1:w) = ts(i:i+w-1);
 end
end

