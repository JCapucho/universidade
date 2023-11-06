T_a = 0.01;
t = 0:T_a:5 - T_a;
x = sin(2*pi*t);

n_bits_array = [2, 3, 4];

for k=1:length(n_bits_array)
    n_bits = n_bits_array(k);
    delta = 2/2^n_bits;
    
    partitions = -1 + delta:delta:1 - delta;
    codebook = -1 + delta/2:delta:1 - delta/2;
    
    [index, quants] = quantiz(x, partitions, codebook);

    figure;
    sgtitle(sprintf("N_{bits} = %d", n_bits));
    subplot(2, 2, 1);
    plot(t, x);
    subplot(2, 2, 2);
    plot(t, quants);
    subplot(2, 2, 3);
    [X, f] = Espetro(quants, T_a);
    plot(f, abs(X));
    subplot(2, 2, 4);
    [y, t_reconstruido] = ReconstroiSinal(quants, T_a);
    plot(t_reconstruido, y);
end