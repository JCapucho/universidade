% Ex. 1
[Image, ColorMap] = imread('Parede_8bit.bmp');
imshow(Image, ColorMap);

% Ex. 2
Save8bitImage("ImageSave.sav", Image);

% Ex. 3
[N, M, LoadedImage] = Load8bitImage("ImageSave.sav");
assert (isequal(Image, LoadedImage))

% Ex. 4
RLEOutput = EncodeImage_RLE(Image);

% Ex. 5
Save8bitStream("ImageStream.sav", N, M, RLEOutput);

% Ex. 6
[NewN, NewM, Stream] = Load8bitStream("ImageStream.sav");
assert (NewN == N && NewM == M && isequal(Stream, RLEOutput));

% Ex. 7
DecodedImage = DecodeImage_RLE(N, M, Stream);
assert (isequal(Image, DecodedImage))
