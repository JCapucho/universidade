function [x, t] = serie_exponencial2(T_a, f_0, N_p, C_k)
    T_0 = 1/f_0;
    t = 0:T_a:N_p*T_0 - T_a;

    K = length(C_k);

    C_minus_k = conj(C_k(2:end));
    C_k_ext = [fliplr(C_minus_k) C_k];

    k = -(K-1):K-1;

    x = sum(C_k_ext.' .* exp(1j * 2 * pi * f_0 * t .* k'));
end