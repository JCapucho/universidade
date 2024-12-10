load Guitar03.mat

[X, f] = Espetro(x, 1/fa);
stem(f, abs(X));
figure
spectrogram(x, 1024, 512, 1024, fa, "yaxis");
colorbar;

%soundsc(x, fa);