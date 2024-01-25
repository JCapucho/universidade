% setup
load RandKeys_A.mat
% For exercise 4
% load RandKeys_B.mat

% Hash functions to be used
functions = {
    {"string2hash (djb2)", @(key, size) mod(string2hash(key, "djb2"), size)};
    {"string2hash (sdbm)", @(key, size) mod(string2hash(key, "sdbm"), size)};
    {"hashstring", @(key, size) hashstring(key, size)};
    {"DJB31MA", @(key, size) mod(DJB31MA(key, 127), size)}
    };

for f = 1:length(functions)
    % Hashtable sizes
    sizes = [5e5, 1e6, 2e6];
    
    for j=1:length(sizes)
        size = sizes(j);
        
        fprintf("Running for hashtable of size %d using %s\n", size, functions{f}{1});
        
        hashes = zeros(length(keys), 1);
        
        tic
        
        % Generate the hashes
        for i=1:length(keys)
            key = keys{i};
            hashes(i) = functions{f}{2}(key, size);
        end
        
        time = toc;
        
        % Alínea C
        fprintf("   Took %f seconds\n", time);
        
        % Alínea B
        slots = length(unique(hashes));
        collisions = length(keys) - slots;
        
        fprintf("   Colisões=%d\n", collisions);
        
        % Calculate the maximum number of insertions
        [GC, GR] = groupcounts(hashes);
        [max_insert, idx] = max(GC);
        max_insert_pos = GR(idx);
        
        fprintf("   Número máximo de inserções=%d (Posição %d)\n", max_insert, max_insert_pos);
        
        % Alínea A.i: plot the histogram
        index = (j - 1) * length(functions) + f;
        subplot(length(sizes), length(functions), index);
        histogram(hashes, 100);
        title(sprintf("%s with %d", functions{f}{1}, size));
        
        % Alínea A.ii: Determine the moments
        for momento=[2, 5, 10]
            teorico = 1/(momento + 1);
            Hnorm = mean((hashes/size) .^ momento);
            
            fprintf("   Momento %d: teorico=%f; momento=%f\n", momento, teorico, Hnorm);
        end
    end
end
