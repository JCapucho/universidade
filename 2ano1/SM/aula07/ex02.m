load Guitar03.mat

teta=2*pi*(5000/fa);
xr=x+ 0.6*cos(teta*(0:length(x)-1)'+0.1*pi);

[X, f] = Espetro(xr, 1/fa);
stem(f, abs(X));
figure
spectrogram(xr, 1024, 512, 1024, fa, "yaxis");
colorbar;

%soundsc(xr, fa);