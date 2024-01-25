
%% c)
notas_5 = 90;
notas_50 = 9;
notas_100 = 1;

total = notas_5 + notas_50 + notas_100;

p5 = notas_5 / total;
p50 = notas_50 / total;
p100 = notas_100 / total;

notas = [0 5 50 100 120];
accum_probs = cumsum([0 p5 p50 p100 0]);

stairs(notas, accum_probs);
ylim([0 1.1])