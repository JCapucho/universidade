Simbolos = ['A', '!', 'L', 'P', 'O'];
Frequencia = [0.2 0.05 0.25 0.15 0.35];

% a)
dicionario = huffmandict(1:length(Simbolos), Frequencia);

% b)
entropia = -sum(Frequencia .* log2(Frequencia));
num_bits = cellfun(@length, dicionario(:, 2))';

numero_medio_bits = sum(num_bits .* Frequencia);

% c)
msg = 'OLA!';
[~, idxs] = ismember(msg, Simbolos);
bitstream = huffmanenco(idxs, dicionario);

% d)
reverse_idxs = huffmandeco(bitstream, dicionario);
reverse = Simbolos(reverse_idxs);
