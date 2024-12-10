function tempo_espetro(y, Ta, Fo, Np, T_F)
    if (T_F > 2 || T_F < 0)
        error("T_F devera ter valores de 0,1 e 2")
    end

    N = length(y);

    if T_F == 0 || T_F == 2
        t = (0:N - 1)*Ta;

        if T_F == 2
            subplot(1,2,1);
        end

        plot(t, y);
        xlabel("Tempo (s)");
        ylabel("y");
        grid on;
    end

    if T_F == 1 || T_F == 2
        fa = 1/Ta;
    
        x1 = fft(y);
        X = fftshift(x1) / N;

        if rem(N, 2) == 0
            f = (-N/2:N/2 - 1)*(fa/N);
        else
            f = (-(N-1)/2:(N-1)/2)*(fa/N);
        end

        if T_F == 2
            subplot(1,2,2);
        end

        plot(f, abs(X));
        xlabel("Frequência (Hz)");
        ylabel("Magnitude");
        grid on;
    end
end