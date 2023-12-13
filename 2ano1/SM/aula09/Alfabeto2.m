function [Simbolos, Frequencia] = Alfabeto2(Texto)
    [Frequencia, Simbolos] = groupcounts(Texto');
    Frequencia = Frequencia / sum(Frequencia);
end