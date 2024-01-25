lambda = 15;
% a)
dist_prob0 = Poisson(15, 0)

% b)
k = 11;
dist_prob11 = 0;
while true
    k_prob = Poisson(15, k);
    dist_prob11 = dist_prob11 + k_prob;
    if k_prob < 1/1e5
        break
    end
    k = k + 1;
end

dist_prob11