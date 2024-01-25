function [keys] = rand_keys(N, lenghts,  alphabet, lenghts_probs, probs)
arguments
	N {mustBeInteger, mustBeNonnegative}
	lenghts (1, :) {mustBeInteger, mustBeNonnegative}
	alphabet (1, :)
	lenghts_probs (:, 1) = ones(length(lenghts), 1) / length(lenghts)
	% If the probabilities aren't passed to the function assume a uniform distribution
	probs (:, 1) = ones(length(alphabet), 1) / length(alphabet)
end
% Helper function for generating N unique random strings that use the provided
% alphabet with the probability distribution specified in probs and have lengths
% as defined in the `lenghts` parameter which follows the probability distribution
% specified in `length_probs`.

% Pre allocate the result cell array
keys = cell(1, N);

% Do a first pass generating the N keys
for i=1:N
	keys{i} = generate_one_key(lenghts, lenghts_probs, alphabet, probs);
end

% Filter out duplicate keys
keys = unique(keys);

% Generate unique keys until the size of the cell array equals N
while length(keys) ~= N
	key = generate_one_key(lenghts, lenghts_probs, alphabet, probs);
	if ~ismember(key, keys)
		keys{length(keys) + 1} = key;
	end
end
end

function [key] = generate_one_key(lenghts, lenghts_probs, alphabet, probs)
% Helper function to generate a random key

% Randomize the key size
U = rand();
i = 1 + sum(U  > cumsum(lenghts_probs));
tamanho = lenghts(i);

% Generate random indices for the alphabet array based on the probabilities
U = rand(1, tamanho);
positions = 1 + sum(U > cumsum(probs));

key = alphabet(positions);
end
