function [x, t] = serie_exponencial(T_a, f_0, N_p, C_k)
    T_0 = 1/f_0;
    t = 0:T_a:N_p*T_0 - T_a;

    K = length(C_k);
    x = 0;

    C_conj_k = conj(C_k);

    % Negative part
    for k=1:(K - 1)
        x = x + C_conj_k(k + 1) * exp(1j * 2 * pi * -k * f_0 * t);
    end

    % Positive part
    for k=1:K
        x = x + C_k(k) * exp(1j * 2 * pi * (k -1) * f_0 * t);
    end
end