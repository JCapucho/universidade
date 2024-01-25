N = 1e6;
total = 100;

programas = zeros(total, N);

% Andre
programas(1:20, :) = rand(20, N) < 0.01;
% Bruno
programas(21:50, :) = rand(30, N) < 0.05;
% Carlos
programas(51:end, :) = rand(50, N) < 0.001;

select = randi(total, 1, N);

% a)
possiveis = zeros(1, N);
carlos = zeros(1, N);

% b)
andre = zeros(1, N);
bruno = zeros(1, N);

for k=1:N
    idx = select(k);
    defeito = programas(idx, k);
    possiveis(k) = defeito;
    % a)
    carlos(k) = defeito & idx > 50;
    % b)
    andre(k) = defeito & idx < 21;
    bruno(k) = defeito & idx > 20 & idx < 51;
end

prob_carlos = sum(carlos&possiveis)/sum(possiveis);
prob_andre = sum(andre&possiveis)/sum(possiveis);
prob_bruno = sum(bruno&possiveis)/sum(possiveis);

% a)
fprintf("P(C|E) = %f\n", prob_carlos);
% b)
fprintf("P(A|E) = %f\n", prob_andre);
fprintf("P(B|E) = %f\n", prob_bruno);

[~, I] = max([prob_andre, prob_bruno, prob_carlos]);
names = ["Andre", "Bruno", "Carlos"];
worst = names(I);

fprintf("%s e o mais provavel\n", worst);

%% Teorico
% a)
%
% P(E) = P(E|A)P(A) + P(E|B)P(B) + P(E|C)P(C)
%      = 0.01*(1/5) + 0.05*(3/10) + 0.001*(1/2)
%      = 0.0175
%
% P(C&E) = P(E|C)P(C) = 0.001*(1/2) = 0.0005
%
% P(C|E) = P(C&E)/P(E) = 0.0005/0.0175 ~= 0.02857
%
% b)
%
% P(A&E) = P(E|A)P(A) = 0.01*(1/5) = 0.002
% P(A|E) = P(A&E)/P(E) = 0.002/0.0175 ~= 0.11428
%
% P(B&E) = P(E|B)P(B) = 0.05*(3/10) = 0.015
% P(B|E) = P(B&E)/P(E) = 0.015/0.0175 ~= 0.85714
%
% P(C|E) < P(A|E) < P(B|E) - O Bruno e o mais provavel
