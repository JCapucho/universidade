function [SimbolosOrdenados, Codigos] = HuffmanCoding(Simbolos, Frequencia)
    [~, idxs] = sort(Frequencia);
    SimbolosOrdenados = Simbolos(idxs);
end

