% 103252 - André de Sousa Fernandes
% 113713 - João Pinto Capucho

[x, t, num, den] = exame2(1221,2);
a=diff(t);

%% Exercício 1
% A váriavel a é um vetor com as diferenças entre os instantes de amostragem,
% ou seja representa os períodos de amostragem.
Ta = mean(a);
fa = 1/Ta; % fa = 400Hz

fprintf("A frequência de amostragem é de %f Hz\n", fa);

%% Exercício 2
% O conteúdo de frequência após o filtro é de 5Hz e 20Hz
[X, f] = Espetro(x, Ta);

subplot(2, 1, 1)
stem(f, abs(X));
title("Espetro do sinal original");
xlabel("Frequencia (Hertz)")
ylabel("magnitude")

y = filter(num, den, x);
[Y, ~] = Espetro(y, Ta);

subplot(2, 1, 2)
stem(f, abs(Y));
title("Espetro do sinal filtrado");
xlabel("Frequencia (Hertz)")
ylabel("magnitude")

sgtitle("Exercício 2")

%% Exercício 3
% A resposta em frequência do filtro mostra que este atenua frequências
% maiores que ~40Hz-50Hz e "completamente" elimina as frequências de 143Hz
% e 183Hz.
%
% Isto explica apenas as frequências de 5Hz e 20Hz terem permanecido após a
% aplicação do filtro.
[H, f] = respfreq(num, den, fa);
figure
plot(f, 20*log10(H));
title("Exercício 3: Resposta em frequência");
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')

%% Exercício 4
D = 0.1/Ta; % 100 ms = 0.1 s

z = x;
z(D + 1:end) = x(D + 1:end) - 0.8*x(1:end - D);

figure
plot(t, x, 'b', 'DisplayName', 'original');
title('Exercício 4: Sinal z(n) = x(n) - 0.8 \times x(n-D)');
xlabel('Tempo (s)')
ylabel('Amplitude')
hold on
plot(t, z, 'r', 'DisplayName', 'resultado sistema');
hold off

legend('location', 'best');
