function [assinaturas] = CalculateSignaturesWithShingles(Corpus, k_hashes, k_grams)
N = length(Corpus);

assinaturas = inf(N, k_hashes);

h = waitbar(0,"Calculating signatures (with shingles)");

for i=1:N
    waitbar(i/N,h);
    
    % Make the string lower cased
    text = lower(Corpus{i});
    % Remove punctuation from the string
    text(isstrprop(text, 'punct')) = '';
    % Fold space in string
    text = regexprep(text, '\s+', ' ');
    % Trim spaces at the beginning and end
    text = strtrim(text);
    
    text_length = length(text);
    
    for shingle_start=1:(text_length - k_grams + 1)
        shingle_end = shingle_start + k_grams - 1;
        shingle = text(shingle_start:shingle_end);
        
        hash = muxDJB31MA(shingle, 127, k_hashes);
        
        assinaturas(i, :) = min(hash, assinaturas(i, :));
    end
end

delete (h)
end

