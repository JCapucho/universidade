throws = 20;
probSimulacao20 = zeros(1, throws + 1);
for k = 0:throws
    probSimulacao20(k + 1) = probCoinToss(0.5, throws, k, 1e4);
end

hold on
stem(0:throws, probSimulacao20)
stem(0:throws, arrayfun(@(k) analyticProbCoinToss(0.5, throws, k), 0:throws))
hold off

%%

throws = 40;
probSimulacao40 = zeros(1, throws + 1);
for k = 0:throws
    probSimulacao40(k + 1) = probCoinToss(0.5, throws, k, 1e4);
end

hold on
stem(0:throws, probSimulacao40)
stem(0:throws, arrayfun(@(k) analyticProbCoinToss(0.5, throws, k), 0:throws))
hold off

%%

throws = 100;
probSimulacao100 = zeros(1, throws + 1);
for k = 0:throws
    probSimulacao100(k + 1) = probCoinToss(0.5, throws, k, 1e4);
end

hold on
stem(0:throws, probSimulacao100)
stem(0:throws, arrayfun(@(k) analyticProbCoinToss(0.5, throws, k), 0:throws))
hold off