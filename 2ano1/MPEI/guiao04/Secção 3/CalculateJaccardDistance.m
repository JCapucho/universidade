function [J] = CalculateJaccardDistance(Set, users)
    Nu = length(users);
    J = zeros(Nu);
    h = waitbar(0,"Calculating");
    for n1= 1:Nu
        waitbar(n1/Nu,h);
        for n2 = n1+1:Nu
            lI = length(intersect(Set{n1}, Set{n2}));
            lU = length(union(Set{n1}, Set{n2}));
            J(n1, n2) = 1 - lI / lU;
        end
    end
    delete (h)
end

