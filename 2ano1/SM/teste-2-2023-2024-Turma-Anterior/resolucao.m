[x, t, num, den] = exame2(2999, 2);
a = diff(t);

% Exercício 1
% `a` corresponde as diferenças entre os instantes de amostragem em relação ao
% seguinte, ou seja, `a` representa os deltas entre os instantes ou seja os períodos
% de amostragem.

fa = 1 / mean(a); % Frequência de amostragem

% Exercício 2
% O sinal filtrado apresenta as frequências: 40Hz, 80Hz e 120Hz
[X, f] = Espetro(x, 1/fa);


subplot(2, 1, 1)
stem(f, abs(X));
title("Espetro do sinal original");
xlabel("Frequencia (Hertz)")
ylabel("magnitude")

y = filter(num, den, x);
[Y, ~] = Espetro(y, 1/fa);

subplot(2, 1, 2)
stem(f, abs(Y));
title("Espetro do sinal filtrado");
xlabel("Frequencia (Hertz)")
ylabel("magnitude")

% Exercício 3
% A resposta em frequência do filtro mostra que este mantêm quase iguais as
% frequências entre 0 e ~70Hz e todas as frequências maiores que 70Hz são
% atenuadas (sendo atenuadas quanto maiores forem). Isto explica porque o
% sinal filtrado anterior aprsenta a frequência de 40Hz com um magnitude
% em que quase nada foi alterada enquanto que 80hz e 120Hz foram bastante
% atenuadas (120Hz quase que desaparece) e as outras frequências maiores
% nem estão presentes.
[H, f] = respfreq(num, den, fa);
figure
plot(f, H);
% plot(f, 20*log10(H));
title("Resposta em frequência");
xlabel('Frequency (Hz)')
ylabel('Magnitude')
% ylabel('Magnitude (dB)')

%% Exercício 3
a = 0.99;
cos_w = cos(2*pi*80/fa);
num = [1 -2*cos_w 1];
denom = [1 -2*a*cos_w a^2];

K = (1 - 2*a*cos_w + a^2)/(2 - 2*cos_w);

[H, f] = respfreq(K * num, denom, fa);

figure
plot(f, 20*log10(H));
title("Resposta em frequência");
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
