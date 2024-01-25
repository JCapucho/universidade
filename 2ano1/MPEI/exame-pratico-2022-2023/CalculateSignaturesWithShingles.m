function [assinaturas] = CalculateSignaturesWithShingles(Corpus, k_hashes)
N = length(Corpus);

assinaturas = zeros(N, k_hashes);

h = waitbar(0,"Calculating signatures (with shingles)");

for i=1:N
    waitbar(i/N,h);
    
    assinaturas(i, :) = SignatureForText(Corpus{i}, k_hashes);
end

delete (h)
end

