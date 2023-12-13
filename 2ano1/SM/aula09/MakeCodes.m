function [Codigos] = MakeCodes(Texto)
    [Simbolos, ~] = Alfabeto2(Texto);

    N = length(Simbolos);

    Codigos = cell(N, 1);

    for k=1:length(Simbolos)
        Codigos{k} = [repmat('1', 1, k - 1) '0'];
    end
end