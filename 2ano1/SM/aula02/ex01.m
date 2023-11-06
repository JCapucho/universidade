%% a)
% x(t) = 2sin(4pi*t)
% T = 1/2
% f = 1/T = 2
% A = 2
T = 1/2;
T_a = 1/1000;
t = 0:T_a:4*T;
x = 2*sin(4*pi*t);
plot(t, x);

p = potencia(x, T_a, T)

%% b)
% y(t) = sin(10pi*t + pi/2)
% T = 1/5
% f = 1/T = 5
% A = 1

T = 1/5;
T_a = 1/1000;
t = 0:T_a:4*T;
y = sin(10*pi*t + pi/2);
plot(t, y);


%% c)
% p(t) = sin(20pi*t + 70pi/180) + sin(20pi*t + 200pi/180)
% T = 1/10
% f = 1/T = 10

T = 1/10;
T_a = 1/1000;
t = 0:T_a:4*T;
p = sin(20*pi*t + 70*pi/180) + sin(20*pi*t + 200*pi/180);
plot(t, p);

A = max(p)

p = potencia(p, T_a, T)

%% d)
% z(t) = sin(6pi*t) + sin(8pi*t)
% T = ?
% f = 1/T = ?
% A = 1

T = 1; % 1/gcd das sinusoides
T_a = 1/1000;
t = 0:T_a:4*T;
z = sin(6*pi*t) + sin(8*pi*t);

plot(t, z);
grid on

A = max(z)

p = potencia(z, T_a, T)

%% e)
% w(t) = sin(6*pi*t) + sin(8*pi*t + 0.1)
% T = ?
% f = 1/T = ?
% A = 1

T = 1; % 1/gcd das sinusoides
T_a = 1/1000;
t = 0:T_a:4*T;
w = sin(6*pi*t) + sin(8*pi*t + 0.1);

plot(t, w);
grid on

A = max(w)

p = potencia(w, T_a, T)

%% f)
% q(t) = sin(6*pi*t) + sin(7*pi*t) + sin(8*pi*t)
% T = ?
% f = 1/T = ?
% A = 1

T = 2; % 1/gcd das sinusoides
T_a = 1/1000;
t = 0:T_a:4*T;
q = sin(6*pi*t) + sin(7*pi*t) + sin(8*pi*t);

plot(t, q);
grid on

A = max(q)

p = potencia(q, T_a, T)