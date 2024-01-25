%% setup
i_min = 6;
i_max = 20;
alphabet = ['a':'z', 'A':'Z'];
keys = rand_keys(1e5, i_min, i_max, alphabet);

%% tables
for size=[5e5, 1e6, 2e6]
    functions = {
        {"string2hash (djb2)", @(key) string2hash(key, "djb2")};
        {"string2hash (sdbm)", @(key) string2hash(key, "sdbm")};
        {"hashstring", @(key) hashstring(key, size)};
        {"DJB31MA", @(key) DJB31MA(key, 0)}
        };

    for f = 1:length(functions)
        fun = functions{f}{2};
        table = hashtable(size, fun);

        for i=1:length(keys)
            key = keys{i};
            table.add(key, key);
        end

        fprintf("Finished for hashtable of size %d using %s\n", size, functions{f}{1});
        fprintf("  Registered %d collisions\n", table.get_collisions());
    end
end


%% test
hashes = zeros(1, length(keys));
for i=1:length(keys)
    key = keys{i};
    hashes(i) = hashstring(key, 5e5);
end