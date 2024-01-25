%% a)
N = 1e5;
p = 0.5;

nascimentos = rand(2, N);
rapazes = nascimentos < p;
numrapazes = sum(rapazes);

A = numrapazes >= 1; % Pelo menos um rapaz

prob = sum(A)/N

%% b)

% probabiliaded de nascer um filho
%               +
% probabilidade de nascerem dois filhos
prob = 0.5 + 0.5 * 0.5

%% c)

N = 1e5;
p = 0.5;

nascimentos = rand(2, N);
rapazes = nascimentos < p;
numrapazes = sum(rapazes);

A = numrapazes == 2; % Nasceram dois rapazes
B = numrapazes >= 1; % Pelo menos um rapaz

AB = A&B;

prob = sum(AB)/sum(B)

%% d)

N = 1e5;
p = 0.5;

nascimentos = rand(2, N);
rapazes = nascimentos < p;
numrapazes = sum(rapazes);

A = numrapazes == 2; % Nasceram dois rapazes
B = rapazes(1,:) == 1; % Primeiro e rapaz

AB = A&B;

prob = sum(AB)/sum(B)

%% e)

N = 1e5;
p = 0.5;

nascimentos = rand(5, N);
rapazes = nascimentos < p;
numrapazes = sum(rapazes);

A = numrapazes == 2; % Nasceram dois rapazes
B = numrapazes >= 1; % Pelo menos um rapaz

AB = A&B;

prob = sum(AB)/sum(B)

%% f)

N = 1e5;
p = 0.5;

nascimentos = rand(5, N);
rapazes = nascimentos < p;
numrapazes = sum(rapazes);

A = numrapazes >= 2; % Nasceram dois rapazes
B = numrapazes >= 1; % Pelo menos um rapaz

AB = A&B;

prob = sum(AB)/sum(B)