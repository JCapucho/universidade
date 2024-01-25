p = 0.4;
q = 0.6;

% Coluna - Estado anterior
% Linha - Estado atual
% Estados: A B C D
T = [p^2,     0, 0, q^2;
     (1-p)^2, 0, 0, q*(1-q);
     p*(1-p), 0, 0, q*(1-q);
     p*(1-p), 1, 1, (1-q)^2];

% a)
estocastica = all(abs(1 - sum(T)) < 1e-15);
fprintf("a) Estocastica? = %s\n", string(estocastica));

% b)
I = [1; 0; 0; 0];

for k=[5, 10, 100, 200]
    probs = T^k*I;
    fprintf("b) %d transicoes\n", k);
    fprintf("  Prob. estado A: %.5f%%\n", probs(1) * 100);
    fprintf("  Prob. estado B: %.5f%%\n", probs(2) * 100);
    fprintf("  Prob. estado C: %.5f%%\n", probs(3) * 100);
    fprintf("  Prob. estado D: %.5f%%\n", probs(4) * 100);
end

% c)
N = length(T);
M=[T - eye(N); ones(1, N)];
x = [zeros(N, 1); 1];
u = M\x;

fprintf("c)\n");
fprintf("  Prob. estado A: %.5f%%\n", u(1) * 100);
fprintf("  Prob. estado B: %.5f%%\n", u(2) * 100);
fprintf("  Prob. estado C: %.5f%%\n", u(3) * 100);
fprintf("  Prob. estado D: %.5f%%\n", u(4) * 100);