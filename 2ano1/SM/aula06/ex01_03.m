%% Parte 1
load Guitar03.mat;

T_a = 1/fa;
[X, f] = Espetro(x, T_a);

W = zeros(length(X), 1);
W(f >= 100 & f <= 400) = X(f >= 100 & f <= 400);
W(f <= -100 & f >= -400) = X(f <= -100 & f >= -400);

plot(f, abs(W));

[w, ~] = Reconstroi(W, f);
%sound(w, fa);

%% Parte 2
load Guitar03.mat;

T_a = 1/fa;
[X, f] = Espetro(x, T_a);

W = zeros(length(X), 1);

W(f >= 400 & f <= 600) = X(f >= 400 & f <= 600);
W(f <= -400 & f >= -600) = X(f <= -400 & f >= -600);

plot(f, abs(W));

[w, ~] = Reconstroi(W, f);
sound(w, fa);

%% Parte 3
load Guitar03.mat;

T_a = 1/fa;
[X, f] = Espetro(x, T_a);

W = zeros(length(X), 1);

W(f >= 600 & f <= 1200) = X(f >= 600 & f <= 1200);
W(f <= -600 & f >= -1200) = X(f <= -600 & f >= -1200);

plot(f, abs(W));

[w, ~] = Reconstroi(W, f);
sound(w, fa);