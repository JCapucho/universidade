%% a)
f0 = 2.5;
f1 = 3.5;
f = gcd(10*f0, 10*f1)/10;
Ta = 0.01;
T = 1/f;
Np = 20;

T_F = 2; 
N = round(Np*T/Ta);
t = (0:N-1)*Ta;
y = 8*cos(5*pi*t + pi/4) + 6*sin(7*pi*t - pi/5);
tempo_espetro(y, Ta, f, Np, T_F);

%% b)
Ta = 0.01;
f = 4;
T=1/f;
t = 0:Ta:2.5;
Np = 2.5/T;
T_F = 2;
y = 2*square(f*2*pi*t);
tempo_espetro(y,Ta,f,Np,T_F);