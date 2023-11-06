T_a = 1/100;
N = 1/T_a * 10;

[x, t] = GeraSinal(N, T_a);
[X, f] = Espetro(x, T_a);

W = zeros(1, length(X));
W(f == 1 | f == -1) = X(f == 1 | f == -1);

[x1, ~] = Reconstroi(W, f);

plot(t, x);
hold on
plot(t, x1, "LineWidth", 2);
hold off