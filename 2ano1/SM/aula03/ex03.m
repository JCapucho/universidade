T_a = 1/256;
T_0 = 1;
t = 0:T_a:4-T_a;
x = square(2*pi*(1/T_0)*t) + 1;

plot(t, x);

[a_k, b_k] = calcCoef(T_a, T_0, x, 50);

%figure;
%subplot(1, 2, 1);
%stem(0:length(a_k) - 1, a_k, "g");

%subplot(1, 2, 2);
%stem(0:length(b_k) - 1, b_k, "r");

[C_k] = calcCoef_complex(T_a, T_0, x, 5);

figure;
stem(abs(C_k));