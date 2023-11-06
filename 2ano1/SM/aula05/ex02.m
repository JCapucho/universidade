%% a)
T_a = 0.2;
t = 0:T_a:5 - T_a;
x = sin(2*pi*t);

[y, t_new] = ReconstroiSinal(x, T_a);

plot(t, x, "green");
hold on
plot(t_new, y, "yellow");
x2 = sin(2 * pi * t_new);
plot(t_new, y, "blue");
plot(t_new, x2 - y, "red");
hold off

%% b)
T_a = 0.04;
t = 0:T_a:5 - T_a;
x = sin(10*pi*t) + cos(12*pi*t) + cos(14*pi*t - pi/4);

[y, t_new] = ReconstroiSinal(x, T_a);

plot(t, x, "green");
hold on
plot(t_new, y, "yellow");
x2 = sin(10*pi*t_new) + cos(12*pi*t_new) + cos(14*pi*t_new - pi/4);
plot(t_new, y, "blue");
plot(t_new, x2 - y, "red");
hold off
