load 'processed.mat';

user_id = input('Insert User ID (1 to ??): ');

while true
	fprintf("1 - Restaurants evaluated by you\n");
	fprintf("2 - Set of restaurants evaluated by the most similar user\n");
	fprintf("3 - Search Restaurant\n");
	fprintf("4 - Find most similar restaurants\n");
	fprintf("5 - Estimate the number of evaluations for each restaurant\n");
	fprintf("6 - Exit\n");
	choice = input("Select choice: ");
	
	fprintf("\n");
	
	switch choice
		case 1
			printRestaurants(rest, [RestaurantsRated{user_id}]');
		case 6
			break
		otherwise
			fprintf("Unknown option\n");
	end
	
	fprintf("\n");
end

function printRestaurants(rest, rIDs)
% fprintf("Nome\tLocalidade\tConcelho\tTipo de Cozinha\tPrato(s) recomendado(s)\tDia(s) encerrado\n");
% for id = rIDs
% 	fprintf("%s\t%s\t%s\t%s\t%s\t%s\n", rest{id, 2:end});
% end

header = {'Nome', 'Localidade', 'Concelho', 'Tipo de Cozinha', 'Prato(s) recomendado(s)', 'Dia(s) encerrado'};
T = cell2table(rest(rIDs, 2:end), 'VariableNames', header);
disp(T)
end
