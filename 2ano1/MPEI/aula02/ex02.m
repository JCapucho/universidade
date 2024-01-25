%% a)

n = 20;
m = 100;

N = 1e5;

lancamentos = randi(m, n, N);

A = false(1, N); 

for i=1:N
    diferentes = unique(lancamentos(:,i));
    A(i) = length(diferentes) == n;
end

prob = sum(A)/N

%% b)

n = 20;
m = 100;

N = 1e5;

lancamentos = randi(m, n, N);

A = false(1, N);

for i=1:N
    diferentes = unique(lancamentos(:,i));
    A(i) = length(diferentes) < n;
end

prob = sum(A)/N

%% c)

N = 1e5;
x = 10:10:100;
m = [1000 100000];

for m_idx = 1:length(m)
    alvos = m(m_idx);

    y = zeros(1, length(x));

    for x_idx=1:length(x)
        n = x(x_idx);
        lancamentos = randi(alvos, n, N);
        
        A = false(1, N);
    
        for i=1:N
            diferentes = unique(lancamentos(:,i));
            A(i) = length(diferentes) < n;
        end

        y(x_idx) = sum(A)/N;
    end

    subplot(1, length(m), m_idx);
    plot(x, y);
    title(sprintf("Alvos = %d", alvos));
end

%% d)

N = 1e5;
n = 100;
m = [200 500 1000 2000 5000 10000 20000 50000 100000];

y = zeros(1, length(m));

for x_idx=1:length(m)
    alvos = m(x_idx);
    lancamentos = randi(alvos, n, N);
    
    A = false(1, N);

    for i=1:N
        diferentes = unique(lancamentos(:,i));
        A(i) = length(diferentes) < n;
    end

    y(x_idx) = sum(A)/N;
end

plot(m, y);