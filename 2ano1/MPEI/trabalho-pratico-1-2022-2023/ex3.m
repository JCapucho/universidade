%
%               |   T   |   A   |   C   |   O   |   R   |   FIM   |
%               |       |       |       |       |       |         |
%   P(passar T) |   0   |  7/30 |   0   |  7/30 |  7/30 |    0    |
%               |       |       |       |       |       |         |
%   P(passar A) |  0.5  |   0   |  0.5  |   0   |  7/30 |    0    |
%               |       |       |       |       |       |         |
%   P(passar C) |   0   |  7/30 |   0   |  7/30 |   0   |    0    |
%               |       |       |       |       |       |         |
%   P(passar O) |  0.5  |   0   |  0.5  |   0   |  7/30 |    0    |
%               |       |       |       |       |       |         |
%   P(passar R) |   0   |  7/30 |   0   |  7/30 |   0   |    0    |
%               |       |       |       |       |       |         |
%   P(FIM)      |   0   |  0.3  |   0   |  0.3  |  0.3  |    1    |
%               |       |       |       |       |       |         |
%

%% b)

T = [0    7/30 0    7/30 7/30 0;
     0.5  0    0.5  0    7/30 0;
     0    7/30 0    7/30 0    0;
     0.5  0    0.5  0    7/30 0;
     0    7/30 0    7/30 0    0;
     0    0.3  0    0.3  0.3  1
    ];

%% c)
letters = ['T', 'A', 'C', 'O', 'R', 'F'];

final_word = crawl(T, 2, 6);
fprintf("A palavra gerada foi: ")
for i = final_word
    if i == 6
        break;
    end
    fprintf("%s", letters(i));
end
fprintf("\n");

%% d)


N = 1e6;
simulations = cell(1,N);
for i = 1:N
    start_letter = randi(5);
    simulations{i} = crawl(T, start_letter, 6);
end

%% e)

counter = 0;
for i = 1:N
    word = simulations{i};
    if length(word) == 5 & word == [1 2 3 4 6]
        counter = counter + 1;
    end
end

prob_taco_simulada = counter / N;
fprintf("A probabilidade de gerar a palavra TACO e %.5f\n", prob_taco_simulada)

%% f)

% Probabilidade de 1a letra ser T = 0.20
p_1a_letra = 1/5;

% Probabilidade de 2a letra ser A sendo que 1a foi T
p_2a_letra = T * [1 0 0 0 0 0]';

% Probabilidade de 3a letra ser C sendo que 2a foi A
p_3a_letra = T * [0 1 0 0 0 0]';

% Probabilidade de 4a letra ser O sendo que 3a foi C
p_4a_letra = T * [0 0 1 0 0 0]';

% Probabilidade de 5a letra ser FIM sendo que 4a foi O
p_5a_letra = T * [0 0 0 1 0 0]';

prob_taco_algebrica = p_1a_letra * p_2a_letra(2) * p_3a_letra(3) * p_4a_letra(4) * p_5a_letra(6);
fprintf("A probabilidade de gerar a palavra TACO e %.5f\n", prob_taco_algebrica)

%% g)

N_estados_absorventes = 1;
Q = T(1:end-N_estados_absorventes, 1:end-N_estados_absorventes);

F = (eye(length(Q)) - Q)^-1;
t = F' * ones(length(F), 1);

fprintf("O tamanho medio de uma palavra e %f\n", t(1, 1));

R = T(end-N_estados_absorventes+1:end, 1:end - N_estados_absorventes);
B = R * F;

fprintf("Probabilidade de absorcao e %f\n", B(1, 1));

countT = 0;
lengthT = 0;
for i=1:length(simulations)
    if simulations{i}(1) == 1
        countT = countT + 1;
        lengthT = lengthT + length(simulations{i}) - 1;
    end
end

lengthT/countT