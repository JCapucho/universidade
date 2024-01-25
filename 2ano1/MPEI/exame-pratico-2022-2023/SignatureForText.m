function [assinatura] = SignatureForText(text, k_hashes)
assinatura = inf(1, k_hashes);

k_grams = 3;

text_length = length(text);

% If the text is smaller than the shingle size, then consider the
% full text as a shingle, there are some titles that are only 1 char
% long, so independent of `k_grams` (except for 1) we need this.
if text_length < k_grams
	for hashFuncN=1:k_hashes
		hash = hf1(text, hashFuncN);
		assinatura(hashFuncN) = min(hash, assinatura(hashFuncN));
	end
end

for shingle_start=1:(text_length - k_grams + 1)
	shingle_end = shingle_start + k_grams - 1;
	shingle = text(shingle_start:shingle_end);
	
	for hashFuncN=1:k_hashes
		hash = hf1(shingle, hashFuncN);
		assinatura(hashFuncN) = min(hash, assinatura(hashFuncN));
	end
end
end

