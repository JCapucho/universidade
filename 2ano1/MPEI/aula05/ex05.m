% a)

% Coluna - Estado anterior
% Linha - Estado atual
% Estados: Sol Nuvens Chuva
T = [0.7, 0.2, 0.3;
     0.2, 0.3, 0.3;
     0.1, 0.5, 0.4];

estocastica = all(abs(1 - sum(T)) < 1e-15);
fprintf("a) Estocastica? = %s\n", string(estocastica));

I = [1; 0; 0];
seguinte = T*I;

% b)
prob = seguinte(1)^2;
fprintf("b) Prob. dois dias = %.5f%%\n", prob * 100);

% c)
I_nao_chuva = seguinte;
I_nao_chuva(3) = 0;
I_nao_chuva = I_nao_chuva ./ sum(I_nao_chuva);

nao_chuva_seguinte = T*I_nao_chuva;
prob = (1 - seguinte(3)) * (1 - nao_chuva_seguinte(3));
fprintf("c) Prob. dois dias = %.5f%%\n", prob * 100);

% d)
I = [1; 0; 0];
dias = 31;
medio = I;

for k=1:dias- 1
    x=T^k * I;
    medio = medio + x;
end

fprintf("d)\n");
fprintf("  Medio dias sol = %f\n", medio(1));
fprintf("  Medio dias nuvens = %f\n", medio(2));
fprintf("  Medio dias chuva = %f\n", medio(3));

% e)
I = [0; 0; 1];
dias = 31;
medio = I;

for k=1:dias- 1
    x=T^k * I;
    medio = medio + x;
end

fprintf("e)\n");
fprintf("  Medio dias sol = %f\n", medio(1));
fprintf("  Medio dias nuvens = %f\n", medio(2));
fprintf("  Medio dias chuva = %f\n", medio(3));

% f)
probs = [0.1; 0.3; 0.5];
I_sol = [1; 0; 0];
I_chuva = [0; 0; 1];
dias = 31;
medio_sol = sum(probs .* I_sol);
medio_chuva = sum(probs .* I_chuva);

for k=1:dias- 1
    x_sol = T^k * I_sol;
    medio_sol = medio_sol + sum(probs .* x_sol);
    x_chuva = T^k * I_chuva;
    medio_chuva = medio_chuva + sum(probs .* x_chuva);
end

fprintf("f)\n");
fprintf("  N medio dias com dores, se primeiro dia for sol = %f\n", medio_sol);
fprintf("  N medio dias com dores, se primeiro dia for chuva = %f\n", medio_chuva);