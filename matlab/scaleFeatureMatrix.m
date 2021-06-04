function [scaledFeatureMatrix] = scaleFeatureMatrix(featureMatrix,typ)
%Scales feature matrix.
%    :param featureMatrix: feature matrix (shape: [n,w])
%    :param typ: name/tag of sclaer to be used.
%    :return scaledFeatureMatrix: scaled feature matrix (shape: [n,w])
if typ == "none"
    scaledFeatureMatrix = featureMatrix;
else
    scaledFeatureMatrix = normalize(featureMatrix,2,typ);
end
end

