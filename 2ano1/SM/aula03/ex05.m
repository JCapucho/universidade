T_a = 1/1000;
f_0 = 1;
L = 5000;

C_k = zeros(1, L + 1);
%idx = 1:2:L;
%C_k(2:2:end) = -1j*2./(pi*idx);

a_k = zeros(1, L + 1);
b_k = zeros(1, L + 1);
idx = 1:2:L;
b_k(2:2:end) = 4./(pi*idx);

C_k(1) = a_k(1)/2;
C_k(2:end) = (a_k(2:end) - 1j*b_k(2:end))/2;

[sinal, t] = serie_exponencial2(T_a, f_0, 5, C_k);
subplot(2, 1, 1);
plot(t, real(sinal))
ylim([-1.5 1.5])
subplot(2, 1, 2);
plot(t, imag(sinal))

max(imag(sinal))

figure;
[sinal, t] = serie_exponencial(T_a, f_0, 5, C_k);
subplot(2, 1, 1);
plot(t, real(sinal))
title("Correct")
ylim([-1.5 1.5])
subplot(2, 1, 2);
plot(t, imag(sinal))

max(imag(sinal))