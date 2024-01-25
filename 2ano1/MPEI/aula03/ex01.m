% a)
lados = [1 2 3 4 5 6];
probs = zeros(length(lados), 1) + 1/length(lados);

subplot(2, 1, 1);
bar(probs);
title("Funcao massa probabilidade");
xlabel("lado");
ylabel("p(x)");

% b)
accum_probs = cumsum(probs);

subplot(2, 1, 2);
stairs(accum_probs);
title("Funcao distribuicao acumulada");
xlabel("lado");
ylabel("F(x)");
xlim([0 7]);
ylim([0 1.1]);