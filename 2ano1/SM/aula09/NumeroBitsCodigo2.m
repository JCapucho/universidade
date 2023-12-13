function [NumBits, mensagem] = NumeroBitsCodigo2(Texto)
    [Simbolos, ~] = Alfabeto2(Texto);
    
    Codigos = MakeCodes(Texto);

    [~, indexes] = ismember(Texto, Simbolos);

    mensagem = [];
    for idx=indexes
        mensagem = [mensagem Codigos{idx}];
    end

    NumBits = length(mensagem);
end