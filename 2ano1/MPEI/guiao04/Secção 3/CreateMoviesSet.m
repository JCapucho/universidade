function [Set] = CreateMoviesSet(data, users)
    Nu = length(users);
    Set = cell(Nu,1);
    for n = 1:Nu
        % Stores in position ’n’ of the cell array the movies of user ’users(n)’:
        ind = data(:,1) == users(n);
        Set{n} = [Set{n} data(ind, 2)];
    end
end

