function h_out= muxDJB31MA( chave, seed, k)
len= length(chave);
chave= double(chave);
h= seed;
for i=1:len
    h = mod(31 * h + chave(i), 2^32 -1);
end
h_out = zeros(1,k);
for i = 1:k
    h = mod(31 * h + i, 2^32 -1);
    h_out(i) = h;
end