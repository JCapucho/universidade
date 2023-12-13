function [NumBits, NumBPS] = GeraMensagem(f, CompMesg, nBits)
    % Utilizamos os índices dos símbolos como o alfabeto
    alfabeto = 1:length(f);
    % Geramos a mensagem aleatória como uma matriz (CompMesg x 1) que
    % utiliza as probabilidades que nos foram passadas e o alfabeto que
    % criamos.
    msg = randsrc(CompMesg, 1, [alfabeto; f]);

    NumBits = sum(nBits(msg));
    NumBPS = NumBits / CompMesg;
end

