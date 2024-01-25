% Regra prática: n > 20 e np <= 7
function [dist_prob] = Poisson(lambda, k)
    dist_prob = (lambda.^k) ./ factorial(k) .* exp(-lambda);
end