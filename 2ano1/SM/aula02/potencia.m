function [p] = potencia(x, T_a, T)
    N = T/T_a;
    p = sum(x(1:N).^2)/N;
end

