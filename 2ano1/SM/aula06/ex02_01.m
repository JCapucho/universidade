T_a = 1/100;
N = 1/T_a * 10;

[x, t] = GeraSinal(N, T_a);

subplot(1, 2, 1);
plot(t, x);

[X, f] = Espetro(x, T_a);

subplot(1, 2, 2);
plot(f, abs(X));