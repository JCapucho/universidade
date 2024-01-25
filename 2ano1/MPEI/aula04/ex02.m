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
caixa_sem_defeito = sum(defeito) == 0;
prob = sum(caixa_sem_defeito) / N;
fprintf("Probabilidade evento B: %f\n", prob);

% b)
teorico = ((1-p_1) * (1 - p_2) * (1 - p_a))^8;
fprintf("Probabilidade evento B (teorico): %f\n", teorico);

% c)
x = 2:20;
y = ((1-p_1) * (1 - p_2) * (1 - p_a)).^x;
plot(x, y, "-o");

% d)
maximo = find(y >= 0.9, 1, 'last') + 1;
fprintf("Tamanho maximo caixa: %d\n", maximo);