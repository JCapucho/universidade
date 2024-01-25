N = 1e5;

p = logspace(-3, log10(1/2) ,100);

y_aviao2 = zeros(1, length(p));
y_aviao4 = zeros(1, length(p));

for k = 1:length(p)
    prob_falha_aviao2 = rand(2, N);
    falhas_aviao2 = sum(prob_falha_aviao2 < p(k));
    y_aviao2(k) = sum(falhas_aviao2 > 1) / N;
    
    prob_falha_aviao4 = rand(4, N);
    falhas_aviao4 = sum(prob_falha_aviao4 < p(k));
    y_aviao4(k) = sum(falhas_aviao4 > 2) /N;
end

loglog(p, y_aviao2, "r")
hold on
loglog(p, y_aviao4, "g")
hold off