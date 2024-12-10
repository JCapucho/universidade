function [H, f] = respfreq(num, den, fa)
    [H1, f1] = freqz(num, den, 1024, fa, 'whole');
    H = abs(fftshift(H1));
    f = f1 - fa/2;
end

