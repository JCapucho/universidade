T_a = 1/1000;
f_0 = 1;
L = 5000;

a_k = zeros(1, L + 1);
b_k = zeros(1, L + 1);
idx = 1:2:L;
b_k(2:2:end) = 4./(pi*idx);

[sinal, t] = somafourier(T_a, f_0, 5, a_k, b_k);

plot(t, sinal)
ylim([-1.5 1.5])