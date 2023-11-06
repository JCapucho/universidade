function [X, f] = Espetro(x, T_a)
    N = length(x);
    f_a = 1/T_a;

    x1 = fft(x);
    X = fftshift(x1);


    if rem(N, 2) == 0
        f = (-N/2:N/2 - 1)*(f_a/N);
    else
        f = (-(N-1)/2:(N-1)/2)*(f_a/N);
    end
end

