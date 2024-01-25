%% a)
p = 0.3;
N = 1e5;

lancamentos = rand(5, N);
defeituosas = sum(lancamentos < p);

[gc, grps] = groupcounts(defeituosas');

probs = gc/N;

subplot(2, 2, 1);
stem(grps, probs);
title("Funcao massa probabilidade");
xlabel("defeituosas");
ylabel("p(x)");

fprintf("a)\ni)\n");

for i = 1:length(grps)
    fprintf("\tp(%d) = %f\n", grps(i), probs(i))
end

accum_probs = cumsum(probs);

subplot(2, 2, 3);
stairs([-1; grps; 6], [0; accum_probs; 1]);
ylim([0 1.1]);
title("Funcao distribuicao acumulada");
xlabel("defeituosas");
ylabel("F(x)");

idx2 = find(grps == 2, 1);

max_2_prob = sum(probs(1:idx2));

fprintf("iii)\n");
fprintf("\tprobabilidade de, no maximo, 2 das pecas de uma amostra serem defeituosas = %f\n", max_2_prob)

%% b)
p = 0.3;
n = 5;
fprintf("b)\ni)\n");

dist_probs = zeros(1, n + 1);

for k=0:n
    dist_prob = nchoosek(n, k) * p^k * (1-p)^(n-k);
    dist_probs(k + 1) = dist_prob;
    fprintf("\tp(%d) = %f\n", k, dist_prob);
end

subplot(2, 2, 2);
stem(0:n, dist_probs);
title("Funcao massa probabilidade (analitico)");
xlabel("defeituosas");
ylabel("p(x)");

accum_dist_probs = cumsum(dist_probs);

subplot(2, 2, 4);
stairs([-1 0:n 6], [0 accum_dist_probs 1]);
ylim([0 1.1]);
title("Funcao distribuicao acumulada (analitico)");
xlabel("defeituosas");
ylabel("F(x)");

max_2_dist_prob = sum(dist_probs(1:3));

fprintf("ii)\n");
fprintf("\tprobabilidade de, no maximo, 2 das pecas de uma amostra serem defeituosas = %f\n", max_2_dist_prob)