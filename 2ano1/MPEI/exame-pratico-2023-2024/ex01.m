% Parte A
% Coluna - Estado anterior
% Linha - Estado atual
T = [
	0 0   0.8 0 0;
	1 0   0   0 0;
	0 0.9 0   0 0;
	0 0.1 0   1 0;
	0 0   0.2 0 1
	];

estocastica = all(abs(1 - sum(T)) < 1e-15);
fprintf("(Sanity Check) Estocastica? = %s\n", string(estocastica));

% Parte B
P = T^12 * [1 0 0 0 0]';
fprintf("b) Probabilidade = %f\n", P(1));

% Parte C
N_estados_absorventes = 2;
Q = T(1:end-N_estados_absorventes, 1:end-N_estados_absorventes);

F = (eye(length(Q)) - Q)^-1;

% Tempo médio até absorção
t = F' * ones(length(F), 1);

fprintf("c) Número médio de iterações até estado absorvente = %f\n", t(1));

% Parte D
R = T(end - N_estados_absorventes + 1:end, 1:end-N_estados_absorventes);

B = R * F;

fprintf("d) Prob. absorção 1 -> 4 = %f\n", B(1, 1));
