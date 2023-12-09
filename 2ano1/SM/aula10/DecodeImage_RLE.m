function Image = DecodeImage_RLE(N, M, Stream)
% Inicialização do resultado como a matriz com as dimensões
% transpostas do resultado final.
Image = zeros(M, N, 'uint8');

% Indíce onde começar a escrever no resultado
StartIndex = 1;

% Iteração dos valores da `Stream` dois a dois
for idx=1:2:length(Stream)
    % Conversão do tipo da contagem para um inteiro (32 bits), isto previne
    % erros mais tarde nas contas, caso contrário o Matlab decide promover de um
    % `double` para um `uint8` quando se faz `StartIndex + count`.
    count = uint32(Stream(idx));
    value = Stream(idx + 1);
    
    % Escrever o valor no intervalo [StartIndex, StartIndex + count[
    % (`count` vezes)
    Image(StartIndex:StartIndex + count - 1) = value;
    
    StartIndex = StartIndex + count;
end

% Transpor o resultado para obter a ordem e dimensões corretas.
Image = Image';
end

