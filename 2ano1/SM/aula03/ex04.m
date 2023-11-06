T_a = 1/256;
T_0 = 1;
t = 0:T_a:4-T_a;
x = sawtooth(2*pi*(1/T_0)*t + pi/2, 0.5);

plot(t, x);
title("Original");
grid on;

[a_k, b_k] = calcCoef(T_a, T_0, x, 50);

figure;
[sinal, t] = somafourier(T_a, 1/T_0, 4, a_k, b_k);
plot(t, sinal);
title("Reconstruida");
grid on;