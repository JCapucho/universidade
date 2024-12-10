load Guitar03.mat;

R=0.9;
theta=2*pi*(5000/fa);

xr=x+ 0.6*cos(theta * (0:length(x)-1)' + 0.1*pi);

num=[1 -2*cos(theta) 1];
den=[1 -2*R*cos(teta) R^2];

[H, f] = respfreq(num, den, fa);

y = filter(num, den, x);

subplot(2, 2, 1)
spectrogram(xr, 1024, 512, 1024, fa, "yaxis");
subplot(2, 2, 2)
plot(f, H);
subplot(2, 2, 3)
spectrogram(y, 1024, 512, 1024, fa, "yaxis");

%soundsc(xr, fa);