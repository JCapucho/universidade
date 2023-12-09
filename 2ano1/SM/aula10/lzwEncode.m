function [output, dict] = lzwEncode(initial, msg)
output = [];
dict = initial;
% A string a ser codificada
substring = [];

% O código registado para a substring construída previamente
lastCode = [];

for c=msg
    % Vamos tentar aumentar a string com o símbolo seguinte
    nextStr = [substring c];
    code = find(strcmp(dict, nextStr));
    % Se não for encontrada no dicionário, a string anterior é emitida,
    % a string aumentada é adicionada ao dicionário e o processo recomeça
    % no símbolo.
    if isempty(code)
        output = [output lastCode];
        
        dict = [dict nextStr];
        
        substring = c;
        code = find(strcmp(dict, substring));
    else
        % A string aumentada está no dicionário por isso atualizamos a
        % substring e continuamos o processo sem emitir nada.
        substring = nextStr;
    end
    
    % Atualizar o código associado a substring
    lastCode = code;
end

% A última substring ainda não foi emitida, isso precisa de ser feito agora.
output = [output lastCode];
end
