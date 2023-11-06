T_a = 1/100;
t = 0:T_a:1 - T_a;
N = length(t);
y = 10 + 14*cos(20*pi*t - pi/3) + 8*cos(40*pi*t+pi/2);

x = fft(y);


subplot(1, 2, 1);
plot(t, y);
subplot(1, 2, 2);
f = (0:N-1)/(T_a*N);
stem(f, abs(x)/N);