load input.mat

Np = length(list);
Na = sum(strcmp(list, 'Adão'));

fprintf("a) Número de pessoas no universo = %f\n", Np);
fprintf("a) Número de pessoas chamadas Adão = %f\n", Na);

filter = CountingBloomFilter(500, 4);

for i=1:Np
	filter.insert(list{i});
end

fprintf("a) Número de pessoas chamadas Adão no bloom filter = %f\n", filter.getInsertedAssured('Adão'));

% Parte B

n = [0 0 0 0];

for i=1:length(extra)
	num = filter.getInsertedAssured(extra{i});
	num = min(num, 3) + 1;
	n(num) = n(num) + 1;
end

P = n / length(extra);

fprintf("b) Prob. de 0: = %.5f\n Prob. de 1: = %.5f\n Prob. de 2: = %.5f\n Prob. de 3: = %.5f\n", P);
