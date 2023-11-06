function [x, t] = GeraSinal(N, T_a)
    t = (0:N - 1) * T_a;
    
    phi = randn(2, N) * pi;
    phi_1 = zeros(1, N);
    phi_2 = zeros(1, N);
    for k = 2:N
        phi_1(k) = phi_1(k - 1) + (phi(1, k) + phi(1, k - 1)) * (T_a/2);
        phi_2(k) = phi_2(k - 1) + (phi(2, k) + phi(2, k - 1)) * (T_a/2);
    end
    
    r = 0.5 * sin (20*pi*t + 10 * phi_1) + 0.5 * sin(24*pi*t + 10 * phi_2);
    x = sin(2*pi*t) + r;
end

