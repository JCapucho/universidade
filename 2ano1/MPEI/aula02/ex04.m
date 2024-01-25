N = 1e5;
people_array = 20:50;

A = false(1, N);

y = zeros(1, length(people_array));

for x_idx=1:length(people_array)
    people = people_array(x_idx);
    distribution = randi(365, people, N);
    
    A = false(1, N);

    for i=1:N
        diferentes = unique(distribution(:,i));
        A(i) = length(diferentes) < people;
    end

    y(x_idx) = sum(A)/N;
end

n50 = find(y > 0.5, 1) + people_array(1) - 1;
n90 = find(y > 0.9, 1) + people_array(1) - 1;

fprintf("a) P > 0.5: n=%d\n", n50);
fprintf("b) P > 0.9: n=%d\n", n90);

plot(people_array, y);