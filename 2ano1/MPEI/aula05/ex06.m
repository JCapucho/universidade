% a)
% Coluna - Estado anterior
% Linha - Estado atual
% Estados: 1 2 4 3 5
%          Estados absorventes no final
T = [0.8 0   0.3 0   0;
     0.2 0.6 0.2 0   0;
     0   0.1 0.4 0   0;
     0   0.3 0   1   0;
     0   0   0.1 0   1];

estocastica = all(abs(1 - sum(T)) < 1e-15);
fprintf("a) Estocastica? = %s\n", string(estocastica));

% b)
fprintf("b) grafico 1\n");
x = 1:100;
y = zeros(1, length(x));

inicial = [1 0 0 0 0]';

for k=x
    estado = T^k * inicial;
    y(k) = estado(2);
end

plot(x, y)

% c)
fprintf("c) grafico 2\n");
x = 1:100;
y1 = zeros(1, length(x));
y2 = zeros(1, length(x));

inicial = [1 0 0 0 0]';

for k=x
    estado = T^k * inicial;
    y1(k) = estado(4);
    y2(k) = estado(5);
end

figure
plot(x, y1, "red")
hold on
plot(x, y2, "blue")
hold off

% d)
fprintf("d)\n");
Q = T(1:3, 1:3)

% e)
fprintf("e)\n");
F = (eye(length(Q)) - Q)^-1

% f)
fprintf("f)\n");
t = F' * ones(length(F), 1)

% g)
fprintf("g)\n");

R = T(4:5, 1:3);
B = R * F;

fprintf("Prob. absorcacao 1 -> 3: %f\n", B(1, 1))
fprintf("Prob. absorcacao 1 -> 5: %f\n", B(2, 1))