function [C_k] = calcCoef_complex(T_a, T_0, x, K)
    t = 0:T_a:T_0 -T_a;

    N = T_0/T_a;
    f_0 = 1/T_0;
    x1 = x(1:N);

    C_k = zeros(1, K + 1);

    for k = 1:K + 1
        C_k(k) = (1/N) * sum(x1 .* exp(-1j * 2 * pi * (k - 1) * f_0 * t));
    end
end
