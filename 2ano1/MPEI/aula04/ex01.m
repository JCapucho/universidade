N = 1e5;
n = 8;

p_1 = 0.002;
p_2 = 0.005;
p_a = 0.01;

defeito_1 = rand(n, N) <= p_1;
defeito_2 = rand(n, N) <= p_2;
defeito_a = rand(n, N) <= p_a;

defeito = defeito_1 | defeito_2 | defeito_a;

% a)
caixa_defeito = sum(defeito) > 0;
prob = sum(caixa_defeito) / N;
fprintf("Probabilidade evento A: %f\n", prob);

% b)
AB = sum(defeito_a & caixa_defeito);
num_defeito_montagem = sum(AB) / sum(caixa_defeito);
fprintf("Numero medio de defeito na montagem: %f\n", num_defeito_montagem);