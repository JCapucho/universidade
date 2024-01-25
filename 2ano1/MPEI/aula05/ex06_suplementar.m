T = [0.8 0   0.3 0   0;
     0.2 0.6 0.2 0   0;
     0   0.1 0.4 0   0;
     0   0.3 0   1   0;
     0   0   0.1 0   1];

%% a)
N = 1e5;

start1 = zeros(1, N);
start2 = zeros(1, N);
start4 = zeros(1, N);

for k=1:N
    state = crawl(T, 1, [4 5]);
    start1(k) = length(state) - 1;
    state = crawl(T, 2, [4 5]);
    start2(k) = length(state) - 1;
    state = crawl(T, 3, [4 5]);
    start4(k) = length(state) - 1;
end

fprintf("f)\n")
fprintf("Passos medios comecando em 1: %f\n", sum(start1) / N);
fprintf("Passos medios comecando em 2: %f\n", sum(start2) / N);
fprintf("Passos medios comecando em 4: %f\n", sum(start4) / N);

%% a-g)
N = 1e5;

end3 = 0;
end5 = 0;

for k=1:N
    state = crawl(T, 1, [4 5]);
    if state(end) == 4
        end3 = end3 + 1;
    else
        end5 = end5 + 1;
    end
end

fprintf("g)\n")
fprintf("Prob. absorcacao por 3: %f\n", end3 / N);
fprintf("Prob. absorcacao por 5: %f\n", end5 / N);

%% b)

N = 10000;
C = cell(1, N);

for k=1:N
    initial = randi([1, 3]);
    C{k} = crawl(T, initial, [4 5]);
end

fprintf("b)\n")
fprintf("Tamanho minimo: %f\n", min(cellfun(@length, C)));
fprintf("Tamanho maximo: %f\n", max(cellfun(@length, C)));

% Note:
% if the Markov chain has more than 1 absorbing state the third argument
% must be a vector with the absorbing states
% for example in a chain with 5 states and considering that
% states 4 and 5 are absorbing states:
% state = crawl(H5, 1, [4 5])
%
% Random walk on the Markov chain
% Inputs:
% H - state transition matrix
% first - initial state
% last - terminal or absorving state
function [state] = crawl(H, first, last)
    % the sequence of states will be saved in the vector "state"
    % initially, the vector contains only the initial state:
    state = [first];
    % keep moving from state to state until state "last" is reached:
    while (1)
        state(end+1) = nextState(H, state(end));
        if ismember(state(end), last) % verifies if state(end) is absorbing
            break;
        end
    end
end

% Returning the next state
% Inputs:
% H - state transition matrix
% currentState - current state
function state = nextState(H, currentState)
    % find the probabilities of reaching all states starting at the current one:
    probVector = H(:,currentState)'; % probVector is a row vector
    n = length(probVector); %n is the number of states
    % generate the next state randomly according to probabilities probVector:
    state = discrete_rnd(1:n, probVector);
end

% Generate randomly the next state.
% Inputs:
% states = vector with state values
% probVector = probability vector
function state = discrete_rnd(states, probVector)
    U=rand();
    i = 1 + sum(U > cumsum(probVector));
    state= states(i);
end