%% a)

N = 1e5;
T = 1000;
keys = 10;

distribution = randi(T, keys, N);

A = false(1, N); 

for i=1:N
    diferentes = unique(distribution(:,i));
    A(i) = length(diferentes) < keys;
end

prob = sum(A) / N

%% b)

N = 1e3;
T = 1000;
keys_array = 10:10:1000;

A = false(1, N);

y = zeros(1, length(keys_array));

for x_idx=1:length(keys_array)
    keys = keys_array(x_idx);
    distribution = randi(T, keys, N);
    
    A = false(1, N);

    for i=1:N
        diferentes = unique(distribution(:,i));
        A(i) = length(diferentes) < keys;
    end

    y(x_idx) = sum(A)/N;
end

plot(keys_array, y);

%% c)

N = 1e4;
T_array = 100:100:1000;
keys = 50;

A = false(1, N);

y = zeros(1, length(T_array));

for x_idx=1:length(T_array)
    T = T_array(x_idx);
    distribution = randi(T, keys, N);
    
    A = false(1, N);

    for i=1:N
        diferentes = unique(distribution(:,i));
        A(i) = length(diferentes) < keys;
    end

    y(x_idx) = sum(A)/N;
end

plot(T_array, y);