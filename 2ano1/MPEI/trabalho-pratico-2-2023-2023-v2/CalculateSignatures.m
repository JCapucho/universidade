function [assinaturas] = CalculateSignatures(Set, k)
N = length(Set);

assinaturas = inf(N, k);

h = waitbar(0,"Calculating signatures");

for i=1:N
    waitbar(i/N,h);
    
    items = Set{i};
    
    for item_idx=1:length(items)
        item = num2str(items(item_idx));
        hash = muxDJB31MA(item, 127, k);
        
        assinaturas(i, :) = min(hash, assinaturas(i, :));
    end
end

delete (h)
end

