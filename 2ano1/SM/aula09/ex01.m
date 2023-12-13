Simbolos = ['A', 'B', 'C', 'D', 'E'];
Frequencia = [14 64 5 10 7] / 100;

% a)
Entropia = -sum(Frequencia .* log2(Frequencia));

% b)
dicionario = huffmandict(1:5, Frequencia);

num_bits = cellfun(@length, dicionario(:, 2))';

% c)
numero_medio_por_simbolo = sum(num_bits .* Frequencia);
numero_medio_bits = numero_medio_por_simbolo * 1000;
