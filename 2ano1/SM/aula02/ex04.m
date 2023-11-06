T_a = 1/1000;
T = 1/10;

freq = [10; 20; 30];
phase = 2*pi*rand(length(freq),1) - pi;

t = 0:T_a:4*T;

x = sum(sin(2*pi*freq*t + phase));

plot(t, x);

p = potencia(x, T_a, T)