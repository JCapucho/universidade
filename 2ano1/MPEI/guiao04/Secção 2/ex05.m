words = readlines('wordlist-preao-20201103.txt', 'EmptyLineRule', 'skip')';

% k values from exercise 1 and 5
hashes = 3:10;

teoricos = zeros(1, length(hashes));
praticos = zeros(1, length(hashes));

for k_idx=1:length(hashes)
    k = hashes(k_idx);
    n = 8000;
    
    % Exercise 1: Create the bloom filter
    filter = BloomFilter(n, k, @(key, size) mod(DJB31MA(key, 127), size));
    
    for word=words(1:1000)
        filter.insert(word);
    end
    
    % Exercise 2
    for i=1:1000
        % Verify that there are no false negatives
        assert(filter.contains(words(i)));
    end
    
    % Exercise 3: caculate false postives
    false_positives = 0;
    test_words = words(1001:11000);
    for word=test_words
        if filter.contains(word)
            false_positives = false_positives + 1;
        end
    end
    
    false_positive_rate = false_positives / length(test_words);
    m = filter.get_members();
    % Exercise 4
    teorico = (1 - (1 - 1/n)^(k * m))^k;
    
    praticos(k_idx) = false_positive_rate;
    teoricos(k_idx) = teorico;
end

%%
plot(hashes, praticos, 'b', 'DisplayName', 'Simulação');
title("False positives rate");
xlabel("k-values");
hold on
plot(hashes, teoricos, 'r', 'DisplayName', 'Teóricos');
legend('location', 'best');
hold off
