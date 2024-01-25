%% Codigo 4
N= 1e5; %n´umero de experiˆencias
p = 0.5; %probabilidade de cara
k = 6; %n´umero de caras
n = 15; %n´umero de lanc¸amentos
lancamentos = rand(n,N) > 1-p;
% Pelos menos k lançamentos, o que signficia que
% mais do que k e um caso favoravel.
sucessos= sum(lancamentos)>=k;
probSimulacao= sum(sucessos)/N;

fprintf("probSimulacao = %f\n", probSimulacao);