function [dist_prob] = Binomial(n, k, p)
    dist_prob = nchoosek(n, k) * p^k * (1-p)^(n-k);
end