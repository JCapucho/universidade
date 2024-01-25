%
%                       | Oceano | Floresta | Deserto | Urbano |
%                       |        |          |         |        |
%   P(passar Oceano)    |   0.1  |   0.25   |   0.2   |  0.25  |
%                       |        |          |         |        |
%   P(passar Floresta)  |   0.3  |   0.25   |   0.2   |  0.25  |
%                       |        |          |         |        |
%   P(passar Deserto)   |   0.3  |   0.25   |   0.4   |  0.25  |
%                       |        |          |         |        |
%   P(passar Urbano)    |   0.3  |   0.25   |   0.2   |  0.25  |
%                       |        |          |         |        |

M = [0.1 0.25 0.2 0.25; 0.3 0.25 0.2 0.25; 0.3 0.25 0.4 0.25; 0.3 0.25 0.2 0.25];
fprintf("Matriz de Markov:\n");
disp(M);
estado_inicial = [0.25 0.25 0.25 0.25]';

%% c)

setima_sessao = M^6 * estado_inicial;
fprintf("c) Na setima sessao, a probabilidade do jogo ser no estado Floresta e %f\n", setima_sessao(2));

%% d)

% Calculo do steady-state vector:

T = [M - eye(4); ones(1,4)];
u = T\[0 0 0 0 1]';

fprintf("d) A probabilidade limite de do cenario escolhido ser floresta e %f\n", u(2));

%% e)

estado_1 = estado_inicial;
estado_2 = M * [0 0 1 0]'; % Sabemos que o estado anterior foi Deserto;
estado_4 = M * estado_2;    % As probabilidades do estado 3 sao iguais as do estado 2;
estado_5 = M * [0 0 0 1]';  % Sabemos que o estado anterior foi Urbano;

prob_final = estado_1(3) * estado_2(3) * estado_4(4) * estado_5(4);
fprintf("A probabilidade das sessoes serem Deserto - Deserto - X - Urbano - Urbano e %f.\n", prob_final);