T_a = 0.01;
t5 = 0:T_a:5;

x = 2 * sin(4 * pi * t5);
subplot(2, 2, 1);
plot(t5, x);

y = cos(10 * pi * t5);
subplot(2, 2, 2);
plot(t5, y);

z = x .* y;
subplot(2, 2, 3);
plot(t5, z);

t10 = 0:T_a:10;

w = 3 * sin(pi * t10) + 2 * sin(6 * pi * t10);
subplot(2, 2, 4);
plot(t10, w);

sgtitle(sprintf("Sampling rate at %f s", T_a));

% End the last figure and start a new figure
figure;

t1 = 0:0.01:5;
t2 = t1';

q = 2 * sin(2 * pi * (2 * t1 + t2));

surf(t1, t2, q);