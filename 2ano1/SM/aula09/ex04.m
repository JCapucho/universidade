Simbolos = ['A', '!', 'L', 'P', 'O'];
Frequencia = [20 5 25 15 35];

% c)
msg = 'OLA!';
[~, idxs] = ismember(msg, Simbolos);
bitstream = arithenco(idxs, Frequencia);

% d)
reverse_idxs = arithdweco(bitstream, Frequencia, length(msg));
reverse = Simbolos(reverse_idxs);