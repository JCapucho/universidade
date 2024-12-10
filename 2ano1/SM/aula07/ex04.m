load Guitar03.mat;

a = 0.9;
D = 34/340 * fa;
D = fa/5;
num = [1 zeros(1,D-1) a];
den = 1;

% a)
% H(e^jw) = 1 + ae^(-j omega D)
%         = 1 + a
[H, f] = respfreq(num, den, fa);

%plot(f, H);

% b)
y = filter(num, den, x);
spectrogram(y, 1024, 512, 1024, fa, "yaxis");
%soundsc(y, fa);

% c)
% Serie geometrica de termo az^-D

% d)
D = 8;
num = 1;
den = [1 zeros(1,D-1) -a];
[H, f] = respfreq(num, den, fa);
plot(f, H);

% e)
D = 0.010 * fa;
num = 1;
den = [1 zeros(1,D-1) -a];
y = filter(num, den, x);
figure
spectrogram(y, 1024, 512, 1024, fa, "yaxis");
soundsc(y, fa);