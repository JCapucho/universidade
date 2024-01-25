load L.mat;

% a)
N = length(L);
dead_ends = find(sum(L) == 0);

% b)
links_saida = sum(L);
H = L./links_saida;
H(:, dead_ends) = 0;

% c)
H_no_dead_end = H;
H_no_dead_end(:, dead_ends) = ones(N, length(dead_ends))/N;

beta = 0.8;
A = beta*H_no_dead_end + (1-beta)*(ones(N)/N);

% d)
I = ones(N, 1);
I = I/sum(I);

passos = 1;
prev_P = I;
ranking = A*prev_P;

while any(abs(ranking - prev_P) > 1e-4)
    prev_P = ranking;
    ranking = A*prev_P;

    passos = passos + 1;
end

% e)
for i=dead_ends
    fprintf("pagerank pagina %d = %f\n", i, ranking(i));
end