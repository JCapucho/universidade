function [N, M, Im] = Load8bitImage(Filename)
fileID = fopen(Filename, 'r');

N = fread(fileID, 1, 'uint16');
M = fread(fileID, 1, 'uint16');
Im = fread(fileID, [N, M], 'uint8=>uint8');

fclose(fileID);
end

