% Estados: A B C D
T = [0.1 0.3 0.25 0.5;
     0.3 0.1 0.25 0.3;
     0.3 0.3 0.1  0.1;
     0.3 0.3 0.4  0.1];

estocastica = all(abs(1 - sum(T)) < 1e-15);
fprintf("Estocastica? = %s\n", string(estocastica));

% c)
I = [0.25 0.25 0.25 0.25]';
P = T^5 * I;

empresa_B = P(2);

fprintf("Probabilidade 7:10 ser a empresa B %f\n", P(2))

% d)
N = length(T);
M=[T - eye(N); ones(1, N)];
x = [zeros(N, 1); 1];
u = M\x;

tempo_medio = u(2) * 60

% e)
p_estado_1 = [0.25 0.25 0.25 0.25]';
p_estado_2 = T * [1 0 0 0]';
p_estado_6 = T^4 * [0 1 0 0]';
p_estado_7 = T * [0 1 0 0]';

p = p_estado_1(1) * p_estado_2(2) * p_estado_6(2) * p_estado_7(1)