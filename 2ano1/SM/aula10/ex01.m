msg = 'LALAALAILAILAI';

% O dicionário inicial é construído através de todos os símbolos únicos, o
% resultado é uma matriz, mas a função precisa de um cell array, logo usamos a
% função `num2cell` para converter entre os dois.
initial = num2cell(unique(msg));

% `output` vai conter a mensagem codificada
[output, dict] = lzwEncode(initial, msg);

% Cálculo do rácio de compressão
compressio_ratio = length(msg) / length(output)
savings_ratio = 1 - length(output) / length(msg)

original = lzwDecode(initial, output);

assert(strcmp(msg, original))
