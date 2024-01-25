function [dist_prob] = NPPoisson(n, k, p)
    lambda = n * p;
    dist_prob = Poisson(lambda, k);
end