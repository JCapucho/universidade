load Guitar03.mat;
% sound(x, fa);

T_a = 1/fa;

t = (0:length(x) - 1) * T_a;

plot(t, x);