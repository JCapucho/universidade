% a)
p = 0.5;
N = 1e5;

lancamentos = rand(4, N);
coroas = sum(lancamentos < p);

[gc, grps] = groupcounts(coroas');

probs = gc/N;

stem(grps, probs);
title("Funcao massa probabilidade");
xlabel("coroas");
ylabel("p(x)");

fprintf("a)\n");

for i = 1:length(grps)
    fprintf("\tp(%d) = %f\n", grps(i), probs(i))
end

% b)
esperado = sum(probs .* grps);
variancia = sum((grps - esperado).^2 .* probs);
desvio = sqrt(variancia);

fprintf("b)\n");

fprintf("\tMedia = %f\n", esperado);
fprintf("\tVariancia = %f\n", variancia);
fprintf("\tDesvio = %f\n", desvio);

% c)

n = max(grps);
fprintf("c)\n");
fprintf("\tDistribuicao binomial p=%f e n=%d\n", p, n);

% d)

fprintf("d)\n")

dist_probs = zeros(1, n + 1);

for k=0:n
    dist_prob = nchoosek(n, k) * p^k * (1-p)^(n-k);
    dist_probs(k + 1) = dist_prob;
    fprintf("\tp(%d) = %f\n", k, dist_prob);
end

% e)

grps = 0:n;
esperado = sum(dist_probs .* grps);
variancia = sum((grps - esperado).^2 .* dist_probs);
desvio = sqrt(variancia);

fprintf("e)\n");

fprintf("\tMedia = %f\n", esperado);
fprintf("\tVariancia = %f\n", variancia);
fprintf("\tDesvio = %f\n", desvio);

% f)

caso_i = sum(dist_probs(3:end));
caso_ii = sum(dist_probs(1:2));
caso_iii = sum(dist_probs(2:4));

fprintf("f)\n");

fprintf("\ti. a probabilidade de obter pelo menos 2 coroas = %f\n", caso_i);
fprintf("\tii. a probabilidade de obter at´e 1 coroa = %f\n", caso_ii);
fprintf("\tiii. a probabilidade de obter entre 1 e 3 coroas = %f\n", caso_iii);

