tabela = readcell("cars3.xlsx", "NumHeaderLines", 1);

S = size(tabela);
Nl = S(1);

k = 4;
assinaturas = CalculateMinHash(tabela, Nl, k);

J = zeros(Nl);
for n1= 1:Nl
	for n2 = n1+1:Nl
		diff = sum(assinaturas(n1, :) ~= assinaturas(n2, :));
		J(n1, n2) = diff / k;
	end
end
