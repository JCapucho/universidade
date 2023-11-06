load Guitar03.mat;

% [X, f] = Espetro(x, 1/fa);
% plot(f, abs(X));

spectrogram(x, 1024, 512, 1024, fa, "yaxis");
colorbar;