% setup
load RandKeys_A.mat
% For exercise 4
% load RandKeys_B.mat

% tables
for size=[5e5, 1e6, 2e6]
    functions = {
        {"string2hash (djb2)", @(key) mod(string2hash(key, "djb2"), size)};
        {"string2hash (sdbm)", @(key) mod(string2hash(key, "sdbm"), size)};
        {"hashstring", @(key) hashstring(key, size)};
        {"DJB31MA", @(key) mod(DJB31MA(key, 0), size)}
        };
    
    for f = 1:length(functions)
        hashes = zeros(1, length(keys));
        
        fprintf("Running for hashtable of size %d using %s\n", size, functions{f}{1});
        
        % Alínea D
        tic
        
        % Alínea A
        for i=1:length(keys)
            key = keys{i};
            hashes(i) = functions{f}{2}(key);
        end
        
        % Alínea B
        slots = length(unique(hashes));
        
        % Alínea C
        collisions = length(keys) - slots;
        
        % Alínea D
        time = toc;
        
        fprintf("  Used %d slots\n", slots);
        fprintf("  Registered %d collisions\n", collisions);
        fprintf("  Took %f seconds\n", time);
    end
end
