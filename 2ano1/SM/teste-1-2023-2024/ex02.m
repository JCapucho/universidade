[S, Fa] = exame(9, 1);

% a)
% 1) 0.1 segundos
% 2) 1 segundo
% 3) 30 Hz, 50 Hz, 80 Hz

% b)
N = length(S);

% c)
t = (0:N - 1)*(1/Fa);

if rem(N, 2) == 0
    f = (-N/2:N/2 - 1)*(Fa/N);
else
    f = (-(N-1)/2:(N-1)/2)*(Fa/N);
end

y = 1 * cos(2*pi*30*t) + 0.5 * cos(2*pi*50*t) + 0.25 * cos(2*pi*80*t);

figure;
sgtitle("2.c) Figura reconstruida")

subplot(2, 1, 1);
plot(t, y);
title("Sinal gerado")
xlabel("Tempo (segundos)")
ylabel("y")

subplot(2, 1, 2);
stem(f, abs(S) / N);
title("Espetro")
xlabel("Frequencia (Hertz)")
ylabel("magnitude")

%subplot(2, 1, 2);
%plot(t, y - ifft(ifftshift(S)), "r")
%title("Erro face ao sinal reconstruido")
%xlabel("Tempo (segundos)")
%ylabel("Erro")

% d)
% Modificamos C_0 ou seja o componente DC do sinal atribuindo-lhe o valor N
% que ira corresponder uma amplitude de 1. Isto causa com que o nosso sinal
% sofra uma translacao vertical de uma unidade.
New_S = S;
New_S(N/2 + 1) = N;

reconstruido = ifft(ifftshift(New_S));

figure;
sgtitle("2.d) C_0 modificado")

subplot(2, 1, 1);
plot(t, reconstruido);
title("Sinal modificado")
xlabel("Tempo (segundos)")
ylabel("y")

subplot(2, 1, 2);
stem(f, abs(New_S) / N);
title("Espetro")
xlabel("Frequencia (Hertz)")
ylabel("magnitude")

% e)
% Se removermos uma componente sinusoidal o periodo mantem-se, porque a
% frequencia fundamental tambem se mantem, visto que o maximo divisor comum
% e igual para qualquer combinacao de duas componentes sinusoidais.

% f)
S(abs(f) == 30) = 0;
S(abs(f) == 80) = 0;

reconstruido = ifft(ifftshift(S));

figure;
sgtitle("2.f) Tom puro")

subplot(2, 1, 1);
plot(t, reconstruido);
title("Tom puro 50Hz")
xlabel("Tempo (segundos)")
ylabel("y")

subplot(2, 1, 2);
stem(f, abs(S) / N);
title("Espetro")
xlabel("Frequencia (Hertz)")
ylabel("magnitude")

%subplot(2, 1, 2);
%plot(t, reconstruido - 0.5*cos(2*pi*50*t), "r");
%title("Erro face ao tom puro")
%xlabel("Tempo (segundos")
%ylabel("Erro")
