% a)
sides = 6;
tries = 2;

N = 1e5;

lancamentos = randi(sides, tries, N);

A = sum(lancamentos) == 9;
B = rem(lancamentos(2,:), 2) == 0;
C = sum(lancamentos == 5) >= 1;
D = sum(lancamentos == 1) == 0;

A_prob = sum(A)/N;
B_prob = sum(B)/N;
C_prob = sum(C)/N;
D_prob = sum(D)/N;

fprintf("P(A) = %f | P(B) = %f | P(C) = %f | P(D) = %f\n", ...
    A_prob, B_prob, C_prob, D_prob);

% b)
% P(A) = 4/36 = 1/9
% P(B) = 1/2
% - `P(AB)`: Probabilidade da soma dos dois valores ser 9
%            e o segundo valor ser possivel, casos possiveis:
%              3 6 | 5 4
% P(AB) = 1/18 = 1/2 * 1/9 = P(A)P(B)

% c)
% P(C) = 11/36
% P(D) = 25/36
% - `P(CD)`: Probabilidade de pelo menos um dos valores ser
%            5 e nenhum dos valores ser 1.
% P(CD) = 9/36 != P(A)P(B) = 11/36 * 25/36 = 275/1296