Frases = {
	'Lisboa e Porto são duas cidades importantes de Portugal.'
	'Lisboa é a capital de Portugal.'
	'Porto é a capital do Norte de Portugal.'
	'Portugal não é só Lisboa e Porto.'
	};

k = 4;

assinaturas = CalculateSignaturesWithShingles(Frases, k);

Nf = length(Frases);

J = zeros(Nf);
for n1= 1:Nf
	for n2 = n1+1:Nf
		diff = sum(assinaturas(n1, :) ~= assinaturas(n2, :));
		J(n1, n2) = diff / k;
	end
end
