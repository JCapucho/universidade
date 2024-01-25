function [probSimulacao] = probCoinToss(probCara, numLancamentos, numCaras, numExperiencias)
    lancamentos = rand(numLancamentos, numExperiencias) > (1 - probCara);
    sucessos= sum(lancamentos) == numCaras;
    probSimulacao= sum(sucessos) / numExperiencias;
end