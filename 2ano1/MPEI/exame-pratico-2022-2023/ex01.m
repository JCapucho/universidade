% Considere um jogo de tabuleiro para crianças muito simples e que envolve 2
% jogadores de cada vez. Neste jogo, cada jogador parte da casa 1 e ganha o que
% chegar mais depressa a casa /Meta/.
%
% O percurso de cada jogador desde a casa 1 até à casa /Meta/ segue o diagrama
% a seguir que indica as casas para onde o jogador se pode mover durante o jogo.
% A escolha do percurso depende do resultado do lançamento de uma moeda ao ar
% que não é equilibrada (moeda diferente em cada casa). O resultado do
% lançamento em cada casa depende de um parâmetro /alpha_i/, sendo /i/ o
% número da casa. Nas alíneas seguintes assuma
alpha = [0.2, 0, 0.3, 0.1, 0.45];

% Parte A

% Coluna - Estado anterior
% Linha - Estado atual
T = [
	0              0 0              0              0              0;
	alpha(1)       0 0              0              0              0;
	0              0 0              alpha(4)       alpha(5)       0;
	0              0 alpha(3)       0              (1 - alpha(5)) 0;
	(1 - alpha(1)) 1 (1 - alpha(3)) 0              0              0;
	0              0 0              (1 - alpha(4)) 0              1;
	];

estocastica = all(abs(1 - sum(T)) < 1e-15);
fprintf("(Sanity Check) Estocastica? = %s\n", string(estocastica));

% Parte B
% O caminho mais curto até a meta é 1 -> 5 -> 4 -> Meta

P = T(5, 1) * T(4, 5) * T(6, 4);
fprintf("b) Probabilidade = %f\n", P);

% Parte C
N_estados_absorventes = 1;
Q = T(1:end-N_estados_absorventes, 1:end-N_estados_absorventes);

F = (eye(length(Q)) - Q)^-1;

% Tempo médio até absorção
t = F' * ones(length(F), 1);

fprintf("c) Número de passos médios até meta = %f\n", t(1) + 1);
