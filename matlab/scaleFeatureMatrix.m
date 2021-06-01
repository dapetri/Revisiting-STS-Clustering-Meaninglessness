function [scaledFeatureMatrix] = scaleFeatureMatrix(featureMatrix,typ)
%SCALEFEATUREMATRIX Summary of this function goes here
%   Detailed explanation goes here
if typ == "none"
    scaledFeatureMatrix = featureMatrix;
else
    scaledFeatureMatrix = normalize(featureMatrix,2,typ);
end
end

