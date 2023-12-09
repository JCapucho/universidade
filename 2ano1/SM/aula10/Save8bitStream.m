function [] = Save8bitStream(Filename, N, M, Stream)
fileID = fopen(Filename, 'w');

fwrite(fileID, N, 'uint16');
fwrite(fileID, M, 'uint16');
fwrite(fileID, Stream);

fclose(fileID);
end

