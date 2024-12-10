load Mensagem.mat;

[Simbolos, Frequencia] = Alfabeto2(Mensagem);

num_bits = ceil(log2(length(Simbolos)));
repr = int2bit(0:length(Simbolos) - 1, num_bits)';