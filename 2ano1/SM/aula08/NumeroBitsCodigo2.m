function [NumBits, mensagem] = NumeroBitsCodigo2(Texto)
    [Simbolos, ~] = Alfabeto2(Texto);

    N = length(Simbolos);

    Codigos = cell(1, N);

    for k=1:length(Simbolos)
        Codigos{k} = [repmat('1', 1, k - 1) '0'];
    end

    [~, indexes] = ismember(Texto, Simbolos);

    mensagem = [];
    for idx=indexes
        mensagem = [mensagem Codigos{idx}];
    end

    NumBits = length(mensagem);
end