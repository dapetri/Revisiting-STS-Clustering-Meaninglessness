function [dist] = distanceMetric(v,w,metricName)
%Calculates distance between v and w accodring to passed metric.
%    :param v: vector (shape: [m])
%    :param w: vector (shape: [m])
%    :param metricName: name/tag of distance metric to be used for calculation.
%    :return dist: distance between v and w

dist = 0;
if metricName == "eukl"
    dist = norm(v-w);
end
end

