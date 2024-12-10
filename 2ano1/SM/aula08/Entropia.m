function [H] = Entropia(Texto)
    [~, Frequencia] = Alfabeto2(Texto);

    H = -sum(Frequencia .* log2(Frequencia));
end

