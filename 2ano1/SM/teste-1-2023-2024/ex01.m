T_a = 1/256;
T_0 = 1;
t = 0:T_a:4-T_a;
x = square(2*pi*(1/T_0)*t) + 1;

subplot(2, 1, 1);
plot(t, x);
title("Onda quadrada")
xlabel("Tempo (segundos)")
ylabel("y")

[C_k] = calcCoef_complex(T_a, T_0, x, 5);

f_0 = 1/T_0;
start_f = -(length(C_k)-1)/2 * f_0;
end_f = (length(C_k)-1)/2 * f_0;
f = start_f:f_0:end_f;

subplot(2, 1, 2);
stem(f, abs(C_k));
title("Espetro")
xlabel("Frequencia (Hertz)")
ylabel("magnitude")