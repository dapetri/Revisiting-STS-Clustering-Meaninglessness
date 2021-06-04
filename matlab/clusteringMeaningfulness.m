function [meaning] = clusteringMeaningfulness(X,Y,distM)
%Calculate cluster meaningfulness (as defined by Keogh)
%    :param Y: set of cluster centers derived with the same clustering method (shape: [k,w,n])
%    :param y: set of cluster centers derived with the same but different clustering method as x (shape: [k,w,n])
%    :param distM: name/tag of distance metric to be used for distance calculation
%    :return meaning: clustering meaningfulness as a quotient ofwithin set distance of x and between set distance between x and y
meaning = withinSetDistance(X,distM) / betweenSetDistance(X,Y,distM);
end

