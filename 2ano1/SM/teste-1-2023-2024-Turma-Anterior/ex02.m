% a)
[s, Fa] = exame(1999, 2);

% a.1)
T=0.2; % (segundos
% a.2) 1.9975s
% a.3) 3: 20Hz, 25Hz, 30Hz

% b)
N = length(s);
fprintf("%d amostras\n", N);
Ta = 1/Fa;
t = (0:(N-1))*Ta;
if rem(N, 2) == 0
    f = (-N/2:N/2 - 1) * (Fa/N);
else
    f = (-(N-1)/2:(N-1)/2) * (Fa/N);
end

% c)
y = 1*sin(20*2*pi*t) + 0.5*sin(25*2*pi*t) + 0.25*sin(30*2*pi*t);
%figure;
%plot(t, y);
%xlabel("segundos");

% d)
% Somar uma constante a um sinal ira provocar uma transalacao vertical no
% grafico do sinal, e o o componente DC sera incrementado com o valor no
% espetro do novo sinal.

[X, f] = Espetro(s, Ta);
%figure;
%plot(f, abs(X) / N);

% e)
% Se f0 e -f0 forem removidos, o periodo nao vai mudar, pois as frequencias
% restantes (25Hz e 30Hz), continuam a ter uma frequencia fundamental de
% 5Hz, o periodo continua entao em 0.2s.
%X(abs(f) == 20) = 0;
%[new_y, new_t] = Reconstroi(X, f);
%figure;
%plot(new_t, new_y);

% f)
% Se f0 e -f0 forem removidos, o periodo nao vai mudar, pois as frequencias
% restantes (25Hz e 30Hz), continuam a ter uma frequencia fundamental de
% 5Hz, o periodo continua entao em 0.2s.
X(abs(f) == 20) = 0;
X(abs(f) == 25) = 0;
[new_y, new_t] = Reconstroi(X, f);
figure;
plot(new_t, new_y);