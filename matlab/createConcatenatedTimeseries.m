function [conc_ts] = createConcatenatedTimeseries(ts)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = size(ts,1);
is = size(ts,2);
conc_ts = zeros(n*is);

j=1;
for i = 1:n
    conc_ts(j:j+is-1) = ts(i,1:is);
    j = j+is-1;
end
end

