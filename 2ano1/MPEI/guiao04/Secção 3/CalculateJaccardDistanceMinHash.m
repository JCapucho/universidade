function [J] = CalculateJaccardDistanceMinHash(Set, users, k)
    Nu = length(users);

    assinaturas = CalculateMinHash(Set, Nu, k);

    J = zeros(Nu);
    h = waitbar(0,"Calculating distances");
    for n1= 1:Nu
        waitbar(n1/Nu,h);
        for n2 = n1+1:Nu
            diff = sum(assinaturas(n1, :) ~= assinaturas(n2, :));
            J(n1, n2) = diff / k;
        end
    end
    delete (h)
end

