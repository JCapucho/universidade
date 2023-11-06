T_a = 0.01;
t5 = 0:T_a:5;

hold on
x = 2 * sin(4 * pi * t5);
plot(t5, x, "r");

y = cos(10 * pi * t5);
plot(t5, y, "b--", "LineWidth", 2);

z = x .* y;
plot(t5, z, "-g.");

t10 = 0:T_a:10;

w = 3 * sin(pi * t10) + 2 * sin(6 * pi * t10);
plot(t10, w, "y", "LineWidth", 2);

title(sprintf("Sampling rate @ %f s", T_a));
hold off