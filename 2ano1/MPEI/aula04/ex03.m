N = 1e5;
n = 16;

p_1 = 0.002;
p_2 = 0.005;
p_a = 0.01;

defeito_1 = rand(n, N) <= p_1;
defeito_2 = rand(n, N) <= p_2;
defeito_a = rand(n, N) <= p_a;

defeito = defeito_1 | defeito_2 | defeito_a;

% a)
[gc, grps] = groupcounts(sum(defeito)');

probs = gc/N;

stem(grps, probs);

% b)
favoraveis = sum((grps >= 2) .* gc);
prob = favoraveis / N;
fprintf("Probabilidade de X >= 2: %f\n", prob);

% c)
esperado = sum(probs .* grps);
variancia = sum((grps - esperado).^2 .* probs);
desvio = sqrt(variancia);

fprintf("Media = %f\n", esperado);
fprintf("Variancia = %f\n", variancia);
fprintf("Desvio = %f\n", desvio);
