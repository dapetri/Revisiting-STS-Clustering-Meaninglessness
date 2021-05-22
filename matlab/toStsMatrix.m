function [sts] = toStsMatrix(ts, w)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
 sts = zeros(length(ts)-w+1, w);
 for i = 1: length(sts)
     sts(i,1:w) = ts(i:i+w-1);
 end
end

