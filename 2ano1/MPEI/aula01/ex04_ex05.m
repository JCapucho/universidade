probSimulacao = 0;

for k = 6:15
    probSimulacao = probSimulacao + probCoinToss(0.5, 15, k, 1e5);
end

fprintf("probSimulacao = %f\n", probSimulacao);