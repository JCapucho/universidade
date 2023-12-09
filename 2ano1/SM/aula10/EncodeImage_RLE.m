function Stream = EncodeImage_RLE(Image)
% Queremos iterar pelos pixeis linha a linha, logo precisamos de transpor
% a matriz `Image` e depois mudar a sua forma para uma matriz NM x 1.
bytes = reshape(Image', [], 1);

% Inicializar o resultado
Stream = [];

% O último valor visto é inicializado com o primeiro byte da imagem
% e a sua contagem é 1.
lastValue = bytes(1);
count = 1;

for idx=2:length(bytes)
    val = bytes(idx);
    
    % Se o valor for diferente do último visto, a contagem e o último valor
    % são emitidos e a contagem é reiniciada.
    %
    % Também é verifcado que a contagem não vai passar a um valor maior do
    % que se consegue representar com um `uint8`, se isto for o caso, a
    % contagem também é reiniciada.
    if val ~= lastValue || count >= intmax("uint8")
        Stream = [Stream; count; lastValue];
        lastValue = val;
        count = 1;
    else
        count = count + 1;
    end
end

% O último valor ainda não foi emitido, tratamos disso aqui
Stream = [Stream; count; lastValue];
end
