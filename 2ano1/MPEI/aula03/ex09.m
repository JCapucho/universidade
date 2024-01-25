N = 1e5;
media = 14;
desvio = 2;

X = desvio * randn(1, N) + media;

% a)
p = sum(X >= 12 & X <= 16) / N;
fprintf("Probabilidade evento A: %f\n", p);
% b)
p = sum(X >= 10 & X <= 18) / N;
fprintf("Probabilidade evento B: %f\n", p);
% c)
p = sum(X >= 10) / N;
fprintf("Probabilidade evento C: %f\n", p);
% d)
pc_A = normcdf(16, media, desvio) - normcdf(12, media, desvio);
fprintf("Correcao evento A: %f\n", pc_A);
pc_B = normcdf(18, media, desvio) - normcdf(10, media, desvio);
fprintf("Correcao evento B: %f\n", pc_B);
pc_C = normcdf(10, media, desvio, 'upper');
fprintf("Correcao evento C: %f\n", pc_C);