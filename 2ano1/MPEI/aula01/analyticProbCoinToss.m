function [probAnalitica] = analyticProbCoinToss(probCara, numLancamentos, numCaras)
    probAnalitica = nchoosek(numLancamentos, numCaras) * (probCara^numCaras) * (1 - probCara)^(numLancamentos - numCaras);
end