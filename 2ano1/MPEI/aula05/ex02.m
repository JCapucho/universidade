% Coluna - Estado anterior
% Linha - Estado atual
% Linha/Coluna 1 - Grupo A
% Linha/Coluna 2 - Grupo B
% Linha/Coluna 3 - Grupo C
T = [1/3, 1/4, 0;
     1/3, 11/20, 1/2;
     1/3, 1/5, 1/2];

% a)
estocastica = all(sum(T) == [1, 1, 1]);
fprintf("a) Estocastica? = %s\n", string(estocastica));

% b)
alunos = 90;
I = [2/3; 1/6; 1/6];

% c)
dist = T^30*I;
grupos = alunos * dist;

fprintf("c) Grupo A = %f\n", grupos(1));
fprintf("   Grupo B = %f\n", grupos(2));
fprintf("   Grupo C = %f\n", grupos(3));

% d)
I = [1/3; 1/3; 1/3];
dist = T^30*I;
grupos = alunos * dist;

fprintf("d) Grupo A = %f\n", grupos(1));
fprintf("   Grupo B = %f\n", grupos(2));
fprintf("   Grupo C = %f\n", grupos(3));