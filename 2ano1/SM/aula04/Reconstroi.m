function [Y, t] = Reconstroi(X, f)
    N = length(X);
    dummy = diff(f);
    f_a = N*dummy(1);
    T_a = 1/f_a;

    x1 = ifftshift(X);
    Y = ifft(x1);

    t = (0:N-1)*T_a;
end

