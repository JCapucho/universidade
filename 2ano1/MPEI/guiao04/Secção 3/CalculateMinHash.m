function [assinaturas] = CalculateMinHash(Set, Nu, k)
assinaturas = inf(Nu, k);

h = waitbar(0,"Calculating signatures");

for u=1:Nu
    waitbar(u/Nu,h);
    
    items = Set{u};
    
    for item_idx=1:length(items)
        item = items(item_idx);
        hash = muxDJB31MA(item, 127, k);
        
        assinaturas(u, :) = min(hash, assinaturas(u, :));
    end
end

delete (h)
end

