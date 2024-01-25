% a)
% Coluna - Estado anterior
% Linha - Estado atual
% Estados: A B C D E F
H = [0 0 0 0 1 0;
     1 0 0 0 1 0;
     0 1 0 1 0 0;
     0 0 1 0 0 0;
     0 1 0 0 0 0;
     0 0 0 0 1 0];

sites = length(H);
links_saida = sum(H);
H = H./(links_saida + (abs(links_saida)<eps));

I = ones(sites, 1);
I = I/sum(I);

P = H^10 * I

% b)
% F e um dead end
% O conjunto C e D e uma spider trap

% c)
dead_ends = find(links_saida == 0);
H(:, dead_ends) = ones(sites, length(dead_ends))/sites;

P_no_dead_end = H^10 * I

% d)
beta = 0.8;
A = beta*H + (1-beta)*(ones(sites)/sites);

P_google = A^10 * I

passos = 1;
prev_P = I;
P = A*prev_P;

while any(abs(P - prev_P) > 1e-4)
    prev_P = P;
    P = A*prev_P;

    passos = passos + 1;
end

% Limite ou vetor estacionario
M=[A - eye(sites); ones(1, sites)];
x = [zeros(sites, 1); 1];
u = M\x;