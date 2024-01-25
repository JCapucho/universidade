function [keys] = rand_keys(N, i_min, i_max, alphabet, probs)
arguments
    N {mustBeInteger, mustBeNonnegative}
    i_min {mustBeInteger, mustBeNonnegative}
    i_max {mustBeInteger, mustBeNonnegative, mustBeGreaterThan(i_max, i_min)}
    alphabet (1, :)
    % If the probabilities aren't passed to the function assume a uniform distribution
    probs (:, 1) = ones(length(alphabet), 1) / length(alphabet)
end

% Pre allocate the result cell array
keys = cell(1, N);

% Do a first pass generating the N keys
for i=1:N
    keys{i} = generate_one_key(i_min, i_max, alphabet, probs);
end

% Filter out duplicate keys
keys = unique(keys);

% Generate unique keys until the size of the cell array equals N
while length(keys) ~= N
    key = generate_one_key(i_min, i_max, alphabet, probs);
    if ~ismember(key, keys)
        keys{length(keys) + 1} = key;
    end
end
end

function [key] = generate_one_key(i_min, i_max, alphabet, probs)
% Helper function to generate a random key

% Randomize the key size within the limits
tamanho = randi(i_max - i_min) + i_min;

% Generate random indices for the alphabet array based on the probabilities
U = rand(1, tamanho);
positions = 1 + sum(U > cumsum(probs));

key = alphabet(positions);
end
