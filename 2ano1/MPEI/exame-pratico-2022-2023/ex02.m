%% Parte A

% P_fp ≈ (1 - e^(-km/n))^k
k = 1;
m = 300;

P_fp = @(n) (1 - exp(-k*m ./ n)) .^ k;

n = round(fzero(@(n) P_fp(n) - 0.03, [100, 10000]));

fprintf("a) Número de elementos N = %f\n", n);

% Manualmente
% n = -m / ln(1 - P_fp) (para k = 1)

%% Parte B

words = rand_keys(10000, [5 8], 'a':'z', [0.4, 0.6]);

filter = BloomFilter(n, k, @(key, size) mod(string2hash(key), size));

for i=1:m
	filter.insert(words{i});
end

false_positives = 0;
test_words = (m + 1):length(words);
for i=test_words
	if filter.contains(words{i})
		false_positives = false_positives + 1;
	end
end

false_positive_rate = false_positives / length(test_words);

fprintf("b) Taxa de falsos positivos = %f\n", false_positive_rate);
