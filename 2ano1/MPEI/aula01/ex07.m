%% Parte a)
probSimulacao = probCoinToss(0.3, 5, 3, 1e4)
probAnalitico = analyticProbCoinToss(0.3, 5, 3)

%% Parte b)

probSimulacao = 0;
probAnalitico = 0;

for k = 0:2
    probSimulacao = probSimulacao + probCoinToss(0.3, 5, k, 1e4)
    probAnalitico = probAnalitico + analyticProbCoinToss(0.3, 5, k)
end

probSimulacao
probAnalitico

%% Parte c)


probSimulacao = zeros(1, 6);

for k = 0:5
    probSimulacao(k + 1) = probCoinToss(0.3, 5, k, 1e4);
end

bar(0:5, probSimulacao)