function [a_k, b_k] = calcCoef(T_a, T_0, x, L)
    t = 0:T_a:T_0 -T_a;

    N = T_0/T_a;
    f_0 = 1/T_0;
    x1 = x(1:N);

    a_k = zeros(1, L + 1);
    b_k  = a_k;
    a_k(1) = mean(x1);
    b_k(1) = 0;

    for k = 2:L + 1
        a_k(k) = (2/N) * sum(x1 .* cos(2*pi*f_0*(k-1)*t));
        b_k(k) = (2/N) * sum(x1 .* sin(2*pi*f_0*(k-1)*t));
    end
end

