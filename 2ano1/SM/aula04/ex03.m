%% a)
T_a = 1/100;
t = 2:T_a:100 - T_a;
x = sin(2*pi*t);

[X, f] = Espetro(x, T_a);

stem(f, abs(X));

[Y, t_reconstruido] = Reconstroi(X, f);

figure;
plot(t_reconstruido, Y);
title("Reconstruido");

%% b)
T_a = 1/100;
t = 0:T_a:50 - T_a;
y = sin(10*pi*t) + cos(12 * pi * t) + cos(14 * pi * t - pi/4);

[X, f] = Espetro(y, T_a);

stem(f, abs(X));

[Y, t_reconstruido] = Reconstroi(X, f);

figure;
plot(t_reconstruido, Y);
title("Reconstruido");

%% c)
T_a = 1/100;
t = 0:T_a:10 - T_a;
y = 10 + 14 * cos(20*pi*t - pi/3) + 8*cos(40*pi*t + pi/2);

[X, f] = Espetro(y, T_a);

stem(f, abs(X));

[Y, t_reconstruido] = Reconstroi(X, f);

figure;
plot(t_reconstruido, Y);
title("Reconstruido");

%% d)
T_a = 1/100;
t = 0:T_a:5 - T_a;
z = (square(2*pi*t) + 1) / 2;

[X, f] = Espetro(z, T_a);

stem(f, abs(X));

[Y, t_reconstruido] = Reconstroi(X, f);

figure;
plot(t_reconstruido, Y);
title("Reconstruido");

%% e)
T_a = 1/100;
t = 0:T_a:5 - T_a;
q = sawtooth(2*pi*t, 0.5);

[X, f] = Espetro(q, T_a);

plot(t, q);
% stem(f, abs(X));

[Y, t_reconstruido] = Reconstroi(X, f);

figure;
plot(t_reconstruido, Y);
title("Reconstruido");