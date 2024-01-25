% Coluna 1 - Nao esteve presente na anterior
% Coluna 2 - Esteve presente na anterior
% Linha 1 - Nao vai a aula
% Linha 2 - Vai a aula
T = [0.2, 0.3; 0.8, 0.7];

% a)
I = [0; 1];
probs = T^2*I;
fprintf("a) P = %f\n", probs(2));

% b)
I = [1; 0];
probs = T^2*I;
fprintf("b) P = %f\n", probs(2));

% c)
I = [0; 1];
probs = T^30*I;
fprintf("c) P = %f\n", probs(2));

% d)
I = [0.15; 0.85];
x = 0:1:30;

y = zeros(1, length(x));
for i=x
    probs = T^i*I;
    y(i + 1) = probs(1);
end

plot(x, y, "+-", "Color", [0, 0, 1, 0.3]);
