function [x, t] = somafourier(T_a, f_0, N_p, a_k, b_k)
    T_0 = 1/f_0;
    t = 0:T_a:N_p*T_0 - T_a;

    x = 0;

    for k=1:length(a_k)
        x = x + a_k(k) * cos(2 * pi * (k -1) * f_0 * t) + b_k(k) * sin(2 * pi * (k -1) * f_0 * t);
    end
end

