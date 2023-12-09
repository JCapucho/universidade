function [N, M, Stream] = Load8bitStream(Filename)
fileID = fopen(Filename, 'r');

N = fread(fileID, 1, 'uint16');
M = fread(fileID, 1, 'uint16');
Stream = fread(fileID, 'uint8=>uint8');

fclose(fileID);
end

