% Estados: 1 3 5 7 9 FIM
T = [0   0.3 0   0.3 0    0;
     1/3 0   0.5 0   0.45 0;
     1/3 0.3 0   0.3 0    0;
     1/3 0   0.5 0   0.45 0;
     0   0.3 0   0.3 0    0;
     0   0.1 0   0.1 0.1  1];

%% c)
digits = ['1', '3', '5', '7', '9', 'F'];

prob_first = [1/4 1/8 1/4 1/4 1/8 0];
states = length(T);

start_digit = discrete_rnd(1:states, prob_first);
gen_states = crawl(T, start_digit, states);
sequence = convertCharsToStrings(digits(gen_states(1:end -1)))

%% d)
N = 1e6;
sequences = cell(1,N);
for i = 1:N
    start_digit = discrete_rnd(1:states, prob_first);
    gen_states = crawl(T, start_digit, states);
    sequences{i} = convertCharsToStrings(digits(gen_states(1:end -1)));
end

%% e)
occurences = 0;

for i=1:length(sequences)
    if sequences{i} == "97153"
        occurences = occurences + 1;
    end
end

fprintf("Probabilidade: %f\n", occurences/length(sequences))

%% f)
estado_1 = [1/4 1/8 1/4 1/4 1/8 0]';
estado_2 = T * [0 0 0 0 1 0]';
estado_3 = T * [0 0 0 1 0 0]';
estado_4 = T * [1 0 0 0 0 0]';
estado_5 = T * [0 0 1 0 0 0]';
estado_final = T * [0 1 0 0 0 0]';

prob = estado_1(5) * estado_2(4) * estado_3(1) * estado_4(3) * estado_5(2) * estado_final(6);

fprintf("Probabilidade (algebrica): %f\n", prob)

%% g)
N_estados_absorventes = 1;
Q = T(1:end-N_estados_absorventes, 1:end-N_estados_absorventes);

F = (eye(length(Q)) - Q)^-1;
t = F' * ones(length(F), 1);

medio_7 = t(4);

fprintf("O tamanho medio de uma sequencia comecada em 7 e %f\n", medio_7);


% if the Markov chain has more than 1 absorving state the third argument
% must be a vector with the absorving states
% for example in a chain with 5 states,and considering that states 4 and 5 are absorbing states:
% state = crawl(H5, 1,  [4 5])  
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
          if ismember(state(end), last) % verifies if state(end) is absorving
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
     probVector = H(:,currentState)';  % probVector is a row vector 
     n = length(probVector);  %n is the number of states
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