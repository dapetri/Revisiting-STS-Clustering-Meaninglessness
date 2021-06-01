function [meaning] = clusteringMeaningfulness(X,Y,distM)

meaning = withinSetDistance(X,distM) / betweenSetDistance(X,Y,distM);
end

