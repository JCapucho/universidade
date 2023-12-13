load Text.mat;

[Simbolos, Frequencia] = Alfabeto2(Text);

entropia = Entropia(Text);

Codigos = MakeCodes(Text);

numero_medio_bits = sum(Frequencia .* cellfun(@length, Codigos));

numero_medio_bits_1000 = 1000 * numero_medio_bits;

fprintf("O numero medio de bits para 1000 caracteres seria %f\n", numero_medio_bits_1000);