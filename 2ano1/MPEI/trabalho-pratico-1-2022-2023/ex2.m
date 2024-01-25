close all;
clear all;
load("L.mat");
N = size(L);
S = sum(L);

%% a)

fprintf("N = %d\n", N(1));
fprintf("Dead ends:\n");
dead_ends = find(S == 0);
disp(dead_ends);

%% b)

H = zeros(N);

for i = 1:N(2)
    n = sum(L(:, i));
    H(:, i) = L(:,i) / n;
end
fprintf("A matriz H e");
disp(H)

%% c)

for i = dead_ends
    H(:, i) = ones(1, N(1)) / N(1);
end

random = ones(N) / N(1);

google = (H * 0.85) + (random * 0.15);

%% d)

% Para calcular o valor final do pagerank podemos aplicar o "power method"

M=[google - eye(N(1)); ones(1, N(1))];
x = [zeros(N(1), 1); 1];
state = M\x;
fprintf("O pagerank final e:\n");
for p = 1:N(1)
    fprintf(1,'Pagina %d: %.3f \n', p, state(p));
end

%% e)

sorted_state = sort(state, 'descend');
fprintf("1º : Pagina %d -> Pagerank: %.5f\n", find(state == sorted_state(1)), sorted_state(1));
fprintf("2º : Pagina %d -> Pagerank: %.5f\n", find(state == sorted_state(2)), sorted_state(2));
fprintf("3º : Pagina %d -> Pagerank: %.5f\n", find(state == sorted_state(3)), sorted_state(3));
