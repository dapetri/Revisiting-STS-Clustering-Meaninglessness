function [meaning] = clusteringMeaningfulness(X,Y,distM)

meaning = within_set_distance(X,distM) / between_set_distance(X,Y,distM);
end

