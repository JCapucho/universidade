%% Alínea A
i_min = 6;
i_max = 20;
alphabet = ['a':'z', 'A':'Z'];
keys = rand_keys(1e5, i_min, i_max, alphabet);

save RandKeys_A.mat keys

%% Alínea B
i_min = 6;
i_max = 20;
alphabet = 'a':'z';

fileID = fopen('prob_pt.txt', 'r');
probs = fscanf(fileID, "%f");
fclose(fileID);

keys = rand_keys(1e5, i_min, i_max, alphabet, probs);

save RandKeys_B.mat keys
