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
Set = cell(Nu,1);
for n = 1:Nu
    % Stores in position ’n’ of the cell array the movies of user ’users(n)’:
    ind = find(u(:,1) == users(n));
    Set{n} = [Set{n} u(ind,2)];
end

% Calculates the Jaccard distance between the movie sets of all user pairs:
J = zeros(Nu);                 % initialize the matrix of the distances
h = waitbar(0,"Calculating");
tic
for n1= 1:Nu
    waitbar(n1/Nu,h);
    for n2 = n1+1:Nu
        lI = length(intersect(Set{n1}, Set{n2}));
        lU = length(union(Set{n1}, Set{n2}));
        J(n1, n2) = 1 - lI / lU;
    end
end
calcTime = toc;
delete (h)

% Determines the most similar pairs of users, in terms of their movie sets:
threshold = 0.4                 % similarity threshold
SimilarUsers= zeros(1,3);       % Array to store: user1, user2, distance
k= 1;
tic
for n1= 1:Nu
    for n2= n1+1:Nu
        if J(n1, n2) < threshold
            SimilarUsers(k,:) = [users(n1) users(n2) J(n1,n2)];
            k= k+1;
        end
    end
end
checkTime = toc;

fprintf("Took %f seconds to calculate the distante\n", calcTime);
fprintf("Took %f seconds to check the distance threshold\n", checkTime);
fprintf("Got %d similar users\n", length(SimilarUsers));

SimilarUsers

save Ex01UserPairsDistance.mat J
