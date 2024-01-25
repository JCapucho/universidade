N = 20;
T = rand(N);
T = T ./ sum(T);

% a)
estocastica = all(abs(1 - sum(T)) < 1e-15);
fprintf("a) Estocastica? = %s\n", string(estocastica));

% b)
I = zeros(N, 1);
I(1) = 1;

for k=[2, 5, 10, 100]
    probs = T^k*I;
    fprintf("b) Prob. em %d transicoes: %.5f%%\n", k, probs(20) * 100);
end