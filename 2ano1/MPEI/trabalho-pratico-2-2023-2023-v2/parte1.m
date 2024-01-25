rest = readcell('restaurantes.txt', 'Delimiter', '\t');
evals = load('turistas1.data');

users = unique(evals(:,1));     % Extracts the unique user IDs
Nu = length(users);             % Computes the total number of users

RestaurantsRated = cell(Nu,1);
for n = 1:Nu
	ind = find(evals(:,1) == users(n));
	RestaurantsRated{n} = [RestaurantsRated{n} evals(ind, 2)];
end

% TODO: Find a good `k`
EvalSignatures = CalculateSignatures(RestaurantsRated, 200);
% TODO: Find a good `k_hashes` and `k_shingles`
TitleSignatures = CalculateSignaturesWithShingles(rest(:, 2), 200, 2);

mask = cellfun(@anymissing, rest);
rest(mask) = {''};
concat_fields = join(rest(:, 3:end));
% TODO: Find a good `k_hashes` and `k_shingles`
FieldSignatures = CalculateSignaturesWithShingles(concat_fields, 200, 3);

% TODO: Find a good `m` and `k`
NumRatingsBloom = CountingBloomFilter(1000, 3);

for n = 1:length(evals)
	NumRatingsBloom.insert(evals(n, 2));
end

rIDs = [rest{:, 1}];
AverageRating = zeros(length(rIDs), 1);
for id = rIDs
	AverageRating(id) = mean(evals(evals(:, 2) == id, 4));
end

save 'processed.mat' rest RestaurantsRated EvalSignatures TitleSignatures FieldSignatures NumRatingsBloom AverageRating;
