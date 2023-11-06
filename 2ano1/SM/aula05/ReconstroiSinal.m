function [y, t] = ReconstroiSinal(x, T_a)
    N = length(x);
    f_a = 1/T_a;
    n = 0:N-1;

    T_a_new = T_a/100;
    t = 0:T_a_new:N*T_a - T_a_new;
    y = sum(x' .* sinc(f_a*(t - n'*T_a)));
end

