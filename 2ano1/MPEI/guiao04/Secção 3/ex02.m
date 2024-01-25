% Base code for finding similar sets
% Loads the data file:
udata = load('u.data');
% Keeps only the two first columns:
u = udata(1:end,1:2);
clear udata;
% Determines the list of users:
users = unique(u(:,1));         % Extracts the unique user IDs
Nu = length(users);             % Computes the total number of users

% Creates the data structure with the set of movies of each user
% (uses a cell array since each user has a different number of movies):
Set = CreateMoviesSet(u, users);

% Calculates the Jaccard distance between the movie sets of all user pairs:
tic
J = CalculateJaccardDistance(Set, users); % initialize the matrix of the distances
calcTime = toc;

% Determines the most similar pairs of users, in terms of their movie sets:
threshold = 0.4;
tic
SimilarUsers= SimilarPairs(J, users, threshold);
checkTime = toc;

fprintf("Took %f seconds to calculate the distante\n", calcTime);
fprintf("Took %f seconds to check the distance threshold\n", checkTime);
fprintf("Got %d similar users\n", length(SimilarUsers));

SimilarUsers

save Ex02UserPairsDistance.mat J
