function [] = Save8bitImage(Filename, Image)
fileID = fopen(Filename, 'w');

fwrite(fileID, size(Image), 'uint16');
fwrite(fileID, Image);

fclose(fileID);
end

