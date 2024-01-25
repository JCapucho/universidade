function [assinaturas] = CalculateMinHash(Set, Nl, k)
assinaturas = inf(Nl, k);

for u=1:Nl
    items = Set(u, :);
    
    for item_idx=1:length(items)
        item = items{item_idx};
        
        for hashFuncN=1:k
            hash = hf24(item, hashFuncN);
            assinaturas(u, hashFuncN) = min(hash, assinaturas(u, hashFuncN));
        end
    end
end
end

