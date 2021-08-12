function [redX] = dimReduction(X,mu)
%DIMREDUCTION Summary of this function goes here
%   Detailed explanation goes here
[~,score,~,~,expl] = pca(X);
L = 1;
while mu > 0
    mu = mu - expl(L);
    L = L+1;
end
redX = score(:,1:L);
end

